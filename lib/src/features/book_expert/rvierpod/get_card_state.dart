import 'package:e_learning_app/src/features/book_expert/model/get_card_data_model.dart';

class CardState {
  final bool isLoading;
  final CardsResponse? cardsResponse;
  final String? error;

  CardState({
    this.isLoading = false,
    this.cardsResponse,
    this.error,
  });

  CardState copyWith({
    bool? isLoading,
    CardsResponse? cardsResponse,
    String? error,
  }) {
    return CardState(
      isLoading: isLoading ?? this.isLoading,
      cardsResponse: cardsResponse ?? this.cardsResponse,
      error: error ?? this.error,
    );
  }
}
