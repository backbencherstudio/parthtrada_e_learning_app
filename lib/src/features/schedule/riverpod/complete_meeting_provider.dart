import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../repository/api/schedule/complete_schedule_repository.dart';

final completeScheduleProvider =
StateNotifierProvider<CompleteScheduleNotifier, AsyncValue<String?>>(
      (ref) => CompleteScheduleNotifier(),
);

class CompleteScheduleNotifier extends StateNotifier<AsyncValue<String?>> {
  CompleteScheduleNotifier() : super(const AsyncValue.data(null));

  final CompleteScheduleRepository _repository = CompleteScheduleRepository();

  /// Call this function to trigger the API
  Future<void> completeScheduleMeeting(String id) async {
    state = const AsyncValue.loading();

    try {
      final message = await _repository.completeScheduleMeetings(id: id);
      state = AsyncValue.data(message);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Optional: Reset state for next interaction
  void reset() {
    state = const AsyncValue.data(null);
  }
}
