import 'package:e_learning_app/src/features/schedule/riverpod/schedule_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../repository/api/schedule/schedule_meeting_list.dart';

final scheduleProvider = StateNotifierProvider<ScheduleRiverpod, ScheduleState>(
      (ref) => ScheduleRiverpod(),
);

class ScheduleRiverpod extends StateNotifier<ScheduleState> {
  ScheduleRiverpod() : super(ScheduleState()) {
    fetchMeetingList();
  }

  int _currentPage = 1;
  final int _limit = 10;

  Future<void> fetchMeetingList() async {
    state = state.copyWith(isLoading: true);

    try {
      final result = await ScheduleMeetingList().getScheduleMeetings(
        page: _currentPage,
        limit: _limit,
      );

      if (result != null) {
        state = state.copyWith(
          meetings: result.data,
          pagination: result.pagination,
          isLoading: false,
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }

  Future<void> loadMoreMeetings() async {
    if (state.pagination?.hasNextPage != true || state.isLoadingMore) return;

    state = state.copyWith(isLoadingMore: true);
    _currentPage++;

    try {
      final result = await ScheduleMeetingList().getScheduleMeetings(
        page: _currentPage,
        limit: _limit,
      );

      if (result != null) {
        state = state.copyWith(
          meetings: [...state.meetings, ...?result.data],
          pagination: result.pagination,
          isLoadingMore: false,
        );
      }
    } catch (e) {
      _currentPage--;
      state = state.copyWith(isLoadingMore: false);
      rethrow;
    }
  }

  void removeMeeting(String id) {
    final updated = state.meetings.where((m) => m.id != id).toList();
    state = state.copyWith(meetings: updated);
  }
}
