import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  ConversationState({
    this.isLoading = false,
    this.conversation,
    this.messages,
    this.error,
    this.typingUserId,
  });

  ConversationState copyWith({
    bool? isLoading,
    ConversationModel? conversation,
    MessageModel? messages,
    String? error,
    String? typingUserId,
  }) {
    return ConversationState(
      isLoading: isLoading ?? this.isLoading,
      conversation: conversation ?? this.conversation,
      messages: messages ?? this.messages,
      error: error ?? this.error,
      typingUserId: typingUserId ?? this.typingUserId,
    );
  }
}

class ConversationViewModel extends StateNotifier<ConversationState> {
  final ConversationRepository _repository;
  MessageService? _messageService;

  ConversationViewModel(this._repository) : super(ConversationState()) {
    fetchConversation();
  }

  void initializeMessageService(String userId) {
    _messageService = MessageService(
      onMessageReceived: (Data message) {
        final currentMessages = state.messages?.data ?? [];
        state = state.copyWith(
          messages: MessageModel(
            success: true,
            data: [...currentMessages, message],
          ),
        );
      },
      onTyping: (String userId) {
        state = state.copyWith(typingUserId: userId);
      },
      onStopTyping: (String userId) {
        if (state.typingUserId == userId) {
          state = state.copyWith(typingUserId: null);
        }
      },
    );
    _messageService!.connect(userId);
  }

  void disposeMessageService() {
    _messageService?.disconnect();
  }

  void sendMessage({
    required String recipientId,
    required String recipientRole,
    required String content,
  }) {
    try {

      debugPrint("message set: ${recipientId} - $recipientRole - $content");

      _messageService?.sendMessage(
        recipientId: recipientId,
        recipientRole: recipientRole,
        content: content,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: "Failed to send message",
      );
    }
  }

  void emitTyping(String userId) {
    _messageService?.emitTyping(userId);
  }

  void emitStopTyping(String userId) {
    _messageService?.emitStopTyping(userId);
  }

  /// fetch all conversations
  Future<void> fetchConversation() async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final result = await _repository.getConversation();

      state = state.copyWith(
        isLoading: false,
        conversation: result,
        error: (result.success == false) ? result.message : null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: "Failed to load conversation",
      );
    }
  }

  /// fetch messages of a given conversation
  Future<void> fetchMessages(String conversationId, String page, String perPage) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final result = await _repository.getMessages(conversationId, page, perPage);

      state = state.copyWith(
        isLoading: false,
        messages: result,
        error: (result.success == false) ? result.message : null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: "Failed to load messages",
      );
    }
  }
}

final conversationRepositoryProvider = Provider<ConversationRepository>((ref) {
  return ConversationRepository();
});

final conversationViewModelProvider =
StateNotifierProvider<ConversationViewModel, ConversationState>((ref) {
  return ConversationViewModel(ref.read(conversationRepositoryProvider));
});