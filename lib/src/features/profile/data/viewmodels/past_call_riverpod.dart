import 'package:e_learning_app/src/features/profile/data/models/past_call_response_model.dart';
import 'package:e_learning_app/src/features/profile/data/repository/past_call_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PastCallRiverpod extends StateNotifier<PastCallState> {
  PastCallRiverpod() : super(PastCallState()) {
    fetchPastCallsList();
  }

  int _currentPage = 1;
  final int _limit = 10;

  Future<void> fetchPastCallsList() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await PastCallList().getPastCalls(
        page: _currentPage,
        limit: _limit,
      );

      if (result != null) {
        state = state.copyWith(
          pastCalls: result.data,
          pagination: result.pagination,
          isLoading: false,
        );
      } else {
        state = state.copyWith(
          pastCalls: [],
          pagination: null,
          isLoading: false,
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadMorePastCalls() async {
    if (state.pagination?.hasNextPage != true || state.isLoadingMore) return;

    state = state.copyWith(isLoadingMore: true, error: null);
    _currentPage++;

    try {
      final result = await PastCallList().getPastCalls(
        page: _currentPage,
        limit: _limit,
      );

      if (result != null) {
        state = state.copyWith(
          pastCalls: [...state.pastCalls, ...result.data],
          pagination: result.pagination,
          isLoadingMore: false,
        );
      } else {
        state = state.copyWith(isLoadingMore: false);
      }
    } catch (e) {
      _currentPage--;
      state = state.copyWith(isLoadingMore: false, error: e.toString());
    }
  }

  Future<void> refreshPastCalls() async {
    _currentPage = 1;
    state = state.copyWith(pastCalls: [], pagination: null, error: null);
    await fetchPastCallsList();
  }
}

final pastCallsProvider =
    StateNotifierProvider<PastCallRiverpod, PastCallState>(
      (ref) => PastCallRiverpod(),
    );

class PastCallState {
  final List<PastCall> pastCalls;
  final Pagination? pagination;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;

  PastCallState({
    this.pastCalls = const [],
    this.pagination,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
  });

  PastCallState copyWith({
    List<PastCall>? pastCalls,
    Pagination? pagination,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
  }) {
    return PastCallState(
      pastCalls: pastCalls ?? this.pastCalls,
      pagination: pagination ?? this.pagination,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error ?? this.error,
    );
  }
}
