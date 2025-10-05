import 'package:e_learning_app/src/features/book_expert/rvierpod/payment_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../repository/api/expert/payment_repository.dart';

final paymentIntentIdProvider = StateProvider<String?>((ref) => null);

final selectedCardMethodIdProvider = StateProvider<String?>((ref) => null);

final paymentRepositoryProvider = Provider<PaymentRepository>((ref) {
  return PaymentRepository();
});

final paymentNotifierProvider = StateNotifierProvider<PaymentNotifier, AsyncValue<bool>>((ref) {
      final repo = ref.read(paymentRepositoryProvider);
      return PaymentNotifier(repository: repo, ref: ref);
    });
