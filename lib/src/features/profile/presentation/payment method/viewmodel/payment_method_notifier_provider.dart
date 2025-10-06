import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../repository/api/expert/get_card_repository.dart';
import '../../../../book_expert/model/get_card_data_model.dart';
import '../data/repository/payment_method_repository_impl.dart';

class PaymentMethodState {
  final bool isLoading;
  final String? message;

  final CardsResponse? cardsResponse;
  final bool isSuccessGetPaymentMethod;

  final bool isLoadingGetPaymentMethod;
  final String? errorMessageGetPaymentMethod;

  const PaymentMethodState({
    this.isLoading = false,
    this.message,
    this.isLoadingGetPaymentMethod = false,
    this.errorMessageGetPaymentMethod,
    this.cardsResponse,
    this.isSuccessGetPaymentMethod = false,
  });

  PaymentMethodState copyWith({
    bool? isLoading,
    String? message,
    bool? isLoadingGetPaymentMethod,
    String? errorMessageGetPaymentMethod,
    CardsResponse? cardsResponse,
    bool? isSuccessGetPaymentMethod,
  }) {
    return PaymentMethodState(
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
      isLoadingGetPaymentMethod:
          isLoadingGetPaymentMethod ?? this.isLoadingGetPaymentMethod,
      errorMessageGetPaymentMethod:
          errorMessageGetPaymentMethod ?? this.errorMessageGetPaymentMethod,
      cardsResponse: cardsResponse ?? this.cardsResponse,
      isSuccessGetPaymentMethod: isSuccessGetPaymentMethod ?? this.isSuccessGetPaymentMethod,
    );
  }
}

class PaymentMethodNotifier extends StateNotifier<PaymentMethodState> {
  final PaymentMethodRepositoryImpl _repository = PaymentMethodRepositoryImpl();
  final GetCardRepository _getCardRepository = GetCardRepository();

  PaymentMethodNotifier() : super(const PaymentMethodState());

  Future<void> addNewCard({
    required String cardNumber,
    required String expMonth,
    required String expYear,
    required String cvc,
  }) async {
    try {
      state = state.copyWith(isLoading: true, message: null);

      // Step 1: Call Stripe API -> get token id
      final tokenId = await _repository.addPaymentMethod(
        cardNumber,
        expMonth,
        expYear,
        cvc,
      );

      if (tokenId.isEmpty) {
        state = state.copyWith(
          isLoading: false,
          message: "Failed to create payment token",
        );
        return;
      }

      // Step 2: Call backend API -> add card with token
      final success = await _repository.addCard(tokenId);
      getCards();

      state = state.copyWith(
        isLoading: false,
        message: success ? "Card added successfully" : "Failed to add card",
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, message: "Error: $e");
    }
  }




  Future<void> getCards() async {
    try {
      state = state.copyWith(
        isLoadingGetPaymentMethod: true,
        errorMessageGetPaymentMethod: null,
        isSuccessGetPaymentMethod: false,
      );

      final cardsResponse = await _getCardRepository.getCards();

      if (cardsResponse != null) {
        state = state.copyWith(
          isLoadingGetPaymentMethod: false,
          cardsResponse: cardsResponse,
          isSuccessGetPaymentMethod: true,
          errorMessageGetPaymentMethod: null,
        );
      } else {
        state = state.copyWith(
          isLoadingGetPaymentMethod: false,
          isSuccessGetPaymentMethod: false,
          errorMessageGetPaymentMethod: "No cards found or invalid token",
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoadingGetPaymentMethod: false,
        isSuccessGetPaymentMethod: false,
        errorMessageGetPaymentMethod: "Error fetching cards: $e",
      );
    }
  }



}

final paymentMethodNotifierProvider =
    StateNotifierProvider<PaymentMethodNotifier, PaymentMethodState>(
      (ref) => PaymentMethodNotifier(),
    );
