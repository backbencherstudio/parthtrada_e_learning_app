import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../data/repository/payment_method_repository_impl.dart';

// ---------------- State ----------------
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

// ---------------- Notifier ----------------
class PaymentMethodNotifier extends StateNotifier<PaymentMethodState> {
  final PaymentMethodRepositoryImpl _repository = PaymentMethodRepositoryImpl();

  PaymentMethodNotifier() : super(const PaymentMethodState());

  Future<void> addCard({
    required CardFieldInputDetails cardDetails,
    required String name,
    required String email,
  }) async {
    state = state.copyWith(isLoading: true, message: null);

    try {
      // 1. Get client_secret from backend
      final clientSecret = await _repository.createSetupIntent();

      // 2. Create PaymentMethod with billing details
      final paymentMethod = await Stripe.instance.createPaymentMethod(
        params: PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(
            billingDetails: BillingDetails(name: name, email: email),
          ),
        ),
      );

      // 3. Confirm SetupIntent
      await Stripe.instance.confirmSetupIntent(
        paymentIntentClientSecret: clientSecret,
        params: PaymentMethodParams.cardFromMethodId(
          paymentMethodData: PaymentMethodDataCardFromMethod(
            paymentMethodId: paymentMethod.id,
          ),
        ),
      );

      // 4. Save to backend
      final success = await _repository.savePaymentMethod(paymentMethod.id);

      if (success) {
        state = state.copyWith(
            isLoading: false, message: "Card saved successfully ✅");
      } else {
        state =
            state.copyWith(isLoading: false, message: "Failed to save card ❌");
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, message: "Error: $e");
    }
  }
}

// ---------------- Provider ----------------
final paymentMethodNotifierProvider =
StateNotifierProvider<PaymentMethodNotifier, PaymentMethodState>(
        (ref) => PaymentMethodNotifier());
