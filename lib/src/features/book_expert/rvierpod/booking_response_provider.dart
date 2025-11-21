import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../repository/api/expert/expert_booking.dart';
import '../../onboarding/riverpod/login_state.dart';
import '../model/booking_response.dart';
import '../model/session_model.dart';

final bookingResponseProvider = FutureProvider.family<BookingResponse, SessionModel>((ref, sessionData) async {
  final token = ref.watch(authTokenProvider);
  if (token == null) {
    throw Exception('Unauthorized: No auth token found');
  }
  final repository = ExpertBooking();
  return await repository.bookExpert(sessionData);
});
