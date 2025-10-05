import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:e_learning_app/src/features/profile/data/models/sent_request_response_model.dart';

import '../repository/get_send_request_repository.dart';

class SendRequestRiverpod extends StateNotifier<SendRequestState> {
  SendRequestRiverpod() : super(SendRequestState()) {
    fetchSendRequestList();
  }

  int _currentPage = 1;
  final int _limit = 10;

  Future<void> fetchSendRequestList() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await GetSendRequestRepositoryList().getSendRequest(
        page: _currentPage,
        limit: _limit,
      );

      if (result != null) {
        state = state.copyWith(
          sendRequests: result.data,
          pagination: result.pagination,
          isLoading: false,
        );
      } else {
        state = state.copyWith(
          sendRequests: [],
          pagination: null,
          isLoading: false,
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadMoreSendRequests() async {
    if (state.pagination?.hasNextPage != true || state.isLoadingMore) return;

    state = state.copyWith(isLoadingMore: true, error: null);
    _currentPage++;

    try {
      final result = await GetSendRequestRepositoryList().getSendRequest(
        page: _currentPage,
        limit: _limit,
      );

      if (result != null) {
        state = state.copyWith(
          sendRequests: [...state.sendRequests, ...result.data],
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

  Future<void> refreshSendRequests() async {
    _currentPage = 1;
    state = state.copyWith(sendRequests: [], pagination: null, error: null);
    await fetchSendRequestList();
  }
}

final sendRequestProvider =
StateNotifierProvider<SendRequestRiverpod, SendRequestState>(
      (ref) => SendRequestRiverpod(),
);

class SendRequestState {
  final List<SendRequest> sendRequests;
  final Pagination? pagination;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;

  SendRequestState({
    this.sendRequests = const [],
    this.pagination,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
  });

  SendRequestState copyWith({
    List<SendRequest>? sendRequests,
    Pagination? pagination,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
  }) {
    return SendRequestState(
      sendRequests: sendRequests ?? this.sendRequests,
      pagination: pagination ?? this.pagination,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error ?? this.error,
    );
  }
}
