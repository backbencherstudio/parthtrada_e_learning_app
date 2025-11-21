import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/model/transaction_history_response.dart';
import '../data/repository/transaction_history_repository.dart';

class TransactionHistoryViewModel extends StateNotifier<TransactionHistoryState> {
  TransactionHistoryViewModel() : super(TransactionHistoryState.initial());

  final TransactionHistoryRepository _repository = TransactionHistoryRepository();

  Future<void> fetchTransactionHistory({int page = 1, int perPage = 10}) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _repository.getTransactionHistory(
        page: page,
        perPage: perPage,
      );

      debugPrint("transaction history response viewmodel: ${response.data}");

      if (response.success == true) {
        // Append new data to existing list if page > 1
        final updatedData = page == 1
            ? response.data
            : [...?state.history?.data, ...?response.data];
        state = state.copyWith(
          isLoading: false,
          history: response.copyWith(data: updatedData),
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response.message ?? 'Failed to fetch transaction history',
        );
      }
    } catch (e) {
      debugPrint("transaction history response viewmodel exception: ${e}");
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

class TransactionHistoryState {
  final bool isLoading;
  final TransactionHistoryResponse? history;
  final String? error;

  TransactionHistoryState({required this.isLoading, this.history, this.error});

  factory TransactionHistoryState.initial() {
    return TransactionHistoryState(isLoading: false);
  }

  TransactionHistoryState copyWith({
    bool? isLoading,
    TransactionHistoryResponse? history,
    String? error,
  }) {
    return TransactionHistoryState(
      isLoading: isLoading ?? this.isLoading,
      history: history ?? this.history,
      error: error,
    );
  }
}

final transactionHistoryViewModelProvider =
StateNotifierProvider<TransactionHistoryViewModel, TransactionHistoryState>(
      (ref) => TransactionHistoryViewModel(),
);