import 'package:e_learning_app/src/features/schedule/model/schedule_meeting_model.dart';

class ScheduleState {
  final List<Booking> meetings;
  final Pagination? pagination;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;

  ScheduleState({
    this.meetings = const [],
    this.pagination,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
  });

  ScheduleState copyWith({
    List<Booking>? meetings,
    Pagination? pagination,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
  }) {
    return ScheduleState(
      meetings: meetings ?? this.meetings,
      pagination: pagination ?? this.pagination,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error ?? this.error,
    );
  }
}

