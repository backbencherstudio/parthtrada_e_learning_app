import 'package:dio/dio.dart';
import 'package:e_learning_app/core/services/api_services/api_services.dart';
import 'package:e_learning_app/src/features/schedule/riverpod/schedule_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/api_services/api_end_points.dart';

final refundProvider = StateNotifierProvider<RefundRiverpod, ScheduleState>(
  (ref) => RefundRiverpod(),
);

class RefundRiverpod extends StateNotifier<ScheduleState> {
  RefundRiverpod() : super(ScheduleState()) {
    refund('');
  }

  final ApiService _apiService = ApiService();

  Future<bool> refund(String bookingId) async {
    debugPrint("Booking Id received: $bookingId");
    try {
      final response = await _apiService.post(
        ApiEndPoints.refund,
        data: {"bookingId": bookingId},
      );
      if (response.data != null) {
        return true;
      } else {
        throw Exception("Failed to refund");
      }
    } catch (e) {
      debugPrint("Exception in refund: $e");
      if (e is DioException) {
        debugPrint("Error Response: ${e.response?.data['success']}");
        if (e.response?.data['success'] == false) {
          return false;
        }
      }
      throw Exception('Error in refund');
    }
  }
}
