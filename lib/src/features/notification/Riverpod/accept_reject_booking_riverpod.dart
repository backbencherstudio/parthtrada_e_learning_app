import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../repository/api/accept_reject_booking/accept_reject_booking_repository.dart';
import '../../../data/model/accept_reject_response_model.dart';

final acceptRejectBookingProvider = StateNotifierProvider<AcceptRejectBookingNotifier, AsyncValue<AcceptRejectResponseModel?>>(
      (ref) => AcceptRejectBookingNotifier(),
);


class AcceptRejectBookingNotifier
    extends StateNotifier<AsyncValue<AcceptRejectResponseModel?>> {
  AcceptRejectBookingNotifier() : super(const AsyncValue.data(null));

  Future<void> patchBookingAction(String url) async {
    state = const AsyncValue.loading();
    try {
      final response = await AcceptRejectBookingRepository().patchBookingAction(url: url);
      if (mounted) {
        state = AsyncValue.data(response);
      }
    } catch (e, st) {
      if (mounted) {
        state = AsyncValue.error(e, st);
      }
    }
  }

  void reset() {
    state = const AsyncValue.data(null);
  }
}
