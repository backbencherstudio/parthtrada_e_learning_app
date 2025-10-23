import 'package:e_learning_app/src/features/profile/data/models/past_call_response_model.dart';
import 'package:e_learning_app/src/features/profile/data/repository/past_call_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PastCallRiverpod extends StateNotifier<PastCallState> {
  PastCallRiverpod() : super(PastCallState()) {
    fetchPastCalls(page: 1);
  }

  Future<void> fetchPastCalls({
    required int page,
    int limit = 10,
    bool isRefresh = false,
  }) async {
    if (isRefresh) {
      state = state.copyWith(pastCalls: [], pagination: null, error: null);
    }

    if (state.isLoading || (state.isLoadingMore && !isRefresh)) return;

    state = state.copyWith(
      isLoading: page == 1 && !state.isLoadingMore,
      isLoadingMore: page > 1,
      error: null,
    );

    try {
      final result = await PastCallList().getPastCalls(
        page: page,
        limit: limit,
      );

      if (result != null) {
        state = state.copyWith(
          pastCalls: isRefresh || page == 1
              ? result.data
              : [...state.pastCalls, ...result.data],
          pagination: result.pagination,
          isLoading: false,
          isLoadingMore: false,
        );
      } else {
        state = state.copyWith(
          pastCalls: isRefresh || page == 1 ? [] : state.pastCalls,
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