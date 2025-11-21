import 'package:e_learning_app/src/features/book_expert/rvierpod/get_card_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../repository/api/expert/get_card_repository.dart';

class CardNotifier extends StateNotifier<CardState> {
  final GetCardRepository repository;

  CardNotifier(this.repository) : super(CardState());

  // Fetch cards
  Future<void> fetchCards() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await repository.getCards();
      if (response != null) {
        state = state.copyWith(isLoading: false, cardsResponse: response);
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'No cards found',
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}


final getCardRepositoryProvider = Provider<GetCardRepository>((ref) {
  return GetCardRepository();
});

final cardProvider =
StateNotifierProvider<CardNotifier, CardState>((ref) {
  final repository = ref.watch(getCardRepositoryProvider);
  return CardNotifier(repository);
});