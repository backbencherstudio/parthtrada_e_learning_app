import 'package:e_learning_app/src/features/schedule/riverpod/schedule_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../repository/api/schedule/schedule_meeting_list.dart';

final scheduleProvider =
StateNotifierProvider<ScheduleRiverpod, ScheduleState>(
      (ref) => ScheduleRiverpod(),
);

class ScheduleRiverpod extends StateNotifier<ScheduleState> {
  ScheduleRiverpod() : super(ScheduleState()) {
    fetchMeetings(page: 1);
  }

  Future<void> fetchMeetings({
    required int page,
    int limit = 10,
    bool isRefresh = false,
  }) async {
    if (isRefresh) {
      state = state.copyWith(meetings: [], pagination: null, error: null);
    }

    if (state.isLoading || (state.isLoadingMore && !isRefresh)) return;

    state = state.copyWith(
      isLoading: page == 1 && !state.isLoadingMore,
      isLoadingMore: page > 1,
      error: null,
    );

    try {
      final result = await ScheduleMeetingList().getScheduleMeetings(
        page: page,
        limit: limit,
      );

      if (result != null) {
        state = state.copyWith(
          meetings: isRefresh || page == 1
              ? result.data
              : [...state.meetings, ...result.data],
          pagination: result.pagination,
          isLoading: false,
          isLoadingMore: false,
        );
      } else {
        state = state.copyWith(
          meetings: isRefresh || page == 1 ? [] : state.meetings,
          pagination: null,
          isLoading: false,
          isLoadingMore: false,
          error: 'No data received',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isLoadingMore: false,
        error: e.toString(),
      );
    }
  }

  void removeMeeting(String id) {
    final updated = state.meetings.where((m) => m.id != id).toList();
    state = state.copyWith(meetings: updated);
  }
}
