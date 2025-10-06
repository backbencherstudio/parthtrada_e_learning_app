import 'package:e_learning_app/src/features/notification/data/model/notification_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:e_learning_app/src/features/notification/data/repository/notification_repository.dart';

class NotificationState {
  final List<NotificationItem> notifications;
  final Pagination? pagination;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;

  NotificationState({
    this.notifications = const [],
    this.pagination,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
  });

  NotificationState copyWith({
    List<NotificationItem>? notifications,
    Pagination? pagination,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
  }) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
      pagination: pagination ?? this.pagination,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
    );
  }
}

final notificationsProvider =
StateNotifierProvider<NotificationRiverpod, NotificationState>(
      (ref) => NotificationRiverpod(),
);

class NotificationRiverpod extends StateNotifier<NotificationState> {
  NotificationRiverpod() : super(NotificationState()) {
    fetchNotifications();
  }

  int _currentPage = 1;
  final int _limit = 10;

  Future<void> fetchNotifications() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await NotificationList().getNotifications(
        page: _currentPage,
        limit: _limit,
      );

      if (result != null) {
        state = state.copyWith(
          notifications: result.data,
          pagination: result.pagination,
          isLoading: false,
        );
      } else {
        state = state.copyWith(
          notifications: [],
          pagination: null,
          isLoading: false,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> loadMoreNotifications() async {
    if (state.pagination?.hasNextPage != true || state.isLoadingMore) return;

    state = state.copyWith(isLoadingMore: true, error: null);
    _currentPage++;

    try {
      final result = await NotificationList().getNotifications(
        page: _currentPage,
        limit: _limit,
      );

      if (result != null) {
        state = state.copyWith(
          notifications: [...state.notifications, ...result.data],
          pagination: result.pagination,
          isLoadingMore: false,
        );
      } else {
        state = state.copyWith(isLoadingMore: false);
      }
    } catch (e) {
      _currentPage--;
      state = state.copyWith(
        isLoadingMore: false,
        error: e.toString(),
      );
    }
  }

  Future<void> refreshNotifications() async {
    _currentPage = 1;
    state = state.copyWith(notifications: [], pagination: null, error: null);
    await fetchNotifications();
  }
}
