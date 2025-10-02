import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/conversation_model.dart';
import '../model/message_model.dart';
import '../repository/conversation_repository.dart';

class ConversationState {
  final bool isLoading;
  final ConversationModel? conversation;
  final MessageModel? messages;
  final String? error;

  ConversationState({
    this.isLoading = false,
    this.conversation,
    this.messages,
    this.error,
  });

  ConversationState copyWith({
    bool? isLoading,
    ConversationModel? conversation,
    MessageModel? messages,
    String? error,
  }) {
    return ConversationState(
      isLoading: isLoading ?? this.isLoading,
      conversation: conversation ?? this.conversation,
      messages: messages ?? this.messages,
      error: error ?? this.error,
    );
  }
}

class ConversationViewModel extends StateNotifier<ConversationState> {
  final ConversationRepository _repository;

  ConversationViewModel(this._repository) : super(ConversationState()) {
    fetchConversation();
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
