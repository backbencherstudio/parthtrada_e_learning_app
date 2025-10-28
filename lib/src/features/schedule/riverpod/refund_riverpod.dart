import 'package:dio/dio.dart';
import 'package:e_learning_app/core/services/api_services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/api_services/api_end_points.dart';

/// --- Provider ---
final refundProvider = StateNotifierProvider.family<RefundRiverpod, RefundState, String>(
      (ref, bookingId) => RefundRiverpod(),
);

/// --- Notifier ---
class RefundRiverpod extends StateNotifier<RefundState> {
  RefundRiverpod() : super(RefundState());

  final ApiService _apiService = ApiService();

  Future<bool> refund(String bookingId) async {
    state = state.copyWith(isLoading: true, error: null);

    debugPrint("Booking Id received: $bookingId");

    try {
      final response = await _apiService.patch(
        ApiEndPoints.refundByStudent(bookingId),
      );

      final data = response.data;

      final success = data['success'] ?? false;
      final message = data['message'] ?? 'Unknown response';

      state = state.copyWith(
        isLoading: false,
        success: success,
        error: message,
      );

      return success;
    } catch (e) {
      debugPrint("Exception in refund: $e");

      String message = 'Error in refund';

      if (e is DioException) {
        message = e.response?.data?['message'] ?? message;
      }

      state = state.copyWith(
        isLoading: false,
        success: false,
        error: message,
      );

      return false;
    }
  }
}

/// --- State ---
class RefundState {
  final bool isLoading;
  final bool success;
  final String? error;

  RefundState({
    this.isLoading = false,
    this.success = false,
    this.error,
  });

  RefundState copyWith({
    bool? isLoading,
    bool? success,
    String? error,
  }) {
    return RefundState(
      isLoading: isLoading ?? this.isLoading,
      success: success ?? this.success,
      error: error ?? this.error,
    );
  }
}
