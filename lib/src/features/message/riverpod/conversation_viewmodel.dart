import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/local_storage_services/user_id_storage.dart';
import '../../../../core/services/message_services/message_service.dart';
import '../model/conversation_model.dart' hide Data;
import '../model/message_model.dart';
import '../repository/conversation_repository.dart';

class ConversationState {
  final bool isLoading;
  final ConversationModel? conversation;
  final MessageModel? messages;
  final String? error;
  final String? typingUserId;
  final bool isLoadingConversation;
  final String? errorMessageConversation;

  ConversationState({
    this.isLoading = false,
    this.conversation,
    this.messages,
    this.error,
    this.typingUserId,
    this.isLoadingConversation = false,
    this.errorMessageConversation
  });

  ConversationState copyWith({
    bool? isLoading,
    ConversationModel? conversation,
    MessageModel? messages,
    String? error,
    String? typingUserId,
    bool? isLoadingConversation,
    String? errorMessageConversation,

  }) {
    return ConversationState(
      isLoading: isLoading ?? this.isLoading,
      conversation: conversation ?? this.conversation,
      messages: messages ?? this.messages,
      error: error ?? this.error,
      typingUserId: typingUserId ?? this.typingUserId,
      isLoadingConversation: isLoadingConversation ?? this.isLoadingConversation,
      errorMessageConversation: errorMessageConversation ?? this.errorMessageConversation
    );
  }
}

class ConversationViewModel extends StateNotifier<ConversationState> {
  final ConversationRepository _repository;
  final ScrollController scrollController;
  MessageService? _messageService;

  ConversationViewModel(this._repository, this.scrollController)
      : super(ConversationState()) {
    fetchConversation();
  }

  void initializeMessageService(BuildContext context) {

    _messageService = MessageService(
      onMessageReceived: (Data message) {

        debugPrint("Message Received in viewmodel:  $message");
        fetchConversation();

        if (context.mounted) {
          final currentMessages = state.messages?.data ?? [];
          state = state.copyWith(
            messages: MessageModel(
              success: true,
              data: List.from(currentMessages)..add(message),
            ),
          );


          // Smoothly scroll to bottom
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (scrollController.hasClients) {
              scrollController.animateTo(
                scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            }
          });
        }
      },
      onTyping: (String userId) {
        if (context.mounted) {
          state = state.copyWith(typingUserId: userId);
        }
      },
      onStopTyping: (String userId) {
        if (context.mounted && state.typingUserId == userId) {
          state = state.copyWith(typingUserId: null);
        }
      },
      onNotificationReceived: (Data message) {

      },
    );
    _messageService!.connect();
  }



  void disposeMessageService() {
    _messageService?.disconnect();
    scrollController.dispose();
  }

  Future<void> sendMessage({
    required String recipientId,
    //required String recipientRole,
    required String content,
    required BuildContext context,
  }) async {
    try {
      debugPrint("message set: ${recipientId}  - $content");
      _messageService?.sendMessage(
        recipientId: recipientId,
       // recipientRole: recipientRole,
        content: content,
      );
      //
      // final success = await _repository.postMessages(
      //   recipientId,
      //   recipientRole,
      //   content,
      // );

      if (context.mounted && scrollController.hasClients) {
        // Smoothly scroll to bottom after sending
        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        });
      }
    } catch (e) {
      if (context.mounted) {
        state = state.copyWith(
          isLoading: false,
          error: "Failed to send message",
        );
      }
    }
  }

  void emitTyping(String userId) {
    _messageService?.emitTyping(userId);
  }

  void emitStopTyping(String userId) {
    _messageService?.emitStopTyping(userId);
  }

  /// Fetch all conversations
  Future<void> fetchConversation() async {
    try {
      state = state.copyWith(isLoadingConversation: true, errorMessageConversation: null);
      final result = await _repository.getConversation();

      state = state.copyWith(
        isLoadingConversation: false,
        conversation: result,
        errorMessageConversation: (result.success == false) ? result.message : null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingConversation: false,
        errorMessageConversation: "Failed to load conversation",
      );
    }
  }


  /// Fetch messages of a given conversation
  Future<void> fetchMessages(String conversationId, String page, String perPage, {required BuildContext context}) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final result = await _repository.getMessages(conversationId, page, perPage);

      if (context.mounted) {
        state = state.copyWith(
          isLoading: false,
          messages: result,
          error: (result.success == false) ? result.message : null,
        );
        // Scroll to bottom after initial load
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (scrollController.hasClients) {
            scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        });
      }
    } catch (e) {
      if (context.mounted) {
        state = state.copyWith(
          isLoading: false,
          error: "Failed to load messages",
        );
      }
    }
  }
}

final conversationRepositoryProvider = Provider<ConversationRepository>((ref) {
  return ConversationRepository();
});

final conversationViewModelProvider =
StateNotifierProvider<ConversationViewModel, ConversationState>((ref) {
  return ConversationViewModel(
    ref.read(conversationRepositoryProvider),
    ScrollController(),
  );
});