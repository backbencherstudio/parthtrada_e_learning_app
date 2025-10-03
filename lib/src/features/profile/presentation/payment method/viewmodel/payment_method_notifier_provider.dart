import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/repository/payment_method_repository_impl.dart';

class PaymentMethodState {
  final bool isLoading;
  final String? message;

  const PaymentMethodState({this.isLoading = false, this.message});

  PaymentMethodState copyWith({bool? isLoading, String? message}) {
    return PaymentMethodState(
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
    );
  }
}

class PaymentMethodNotifier extends StateNotifier<PaymentMethodState> {
  final PaymentMethodRepositoryImpl _repository = PaymentMethodRepositoryImpl();

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
            isLoading: false, message: "Failed to create payment token");
        return;
      }

      // Step 2: Call backend API -> add card with token
      final success = await _repository.addCard(tokenId);

      state = state.copyWith(
        isLoading: false,
        message: success ? "Card added successfully" : "Failed to add card",
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, message: "Error: $e");
    }
  }
}

final paymentMethodNotifierProvider =
StateNotifierProvider<PaymentMethodNotifier, PaymentMethodState>(
      (ref) => PaymentMethodNotifier(),
);