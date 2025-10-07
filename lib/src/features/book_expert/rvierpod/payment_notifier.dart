import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../repository/api/expert/payment_repository.dart';
import 'payment_provider.dart';

class PaymentNotifier extends StateNotifier<AsyncValue<bool>> {
  final PaymentRepository repository;
  final Ref ref;

  PaymentNotifier({required this.repository, required this.ref})
      : super(const AsyncValue.data(false));

  Future<bool> confirmPayment() async {
    final paymentIntentId = ref.read(paymentIntentIdProvider);
    // final paymentMethodId = ref.read(selectedCardMethodIdProvider);

    if (paymentIntentId == null) {
      state = AsyncValue.error('Payment data not available', StackTrace.current);
      return false;
    }

    state = const AsyncValue.loading();

    try {
      final success = await repository.confirmPayment(
        paymentIntentId: paymentIntentId,
        // paymentMethodId: paymentMethodId,
      );

      state = AsyncValue.data(success);
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }
}
