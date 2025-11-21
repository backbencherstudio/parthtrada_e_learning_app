import 'package:dio/dio.dart';
import 'package:e_learning_app/core/services/api_services/api_end_points.dart';
import 'package:flutter/cupertino.dart';
import '../../../../../core/services/api_services/api_services.dart';
import '../model/transaction_history_response.dart';


class TransactionHistoryRepository {
  final ApiService _apiService = ApiService();

  Future<TransactionHistoryResponse> getTransactionHistory({
    int page = 1,
    int perPage = 10,
  }) async {
    try {
      final Response response = await _apiService.get(
        ApiEndPoints.transactionsHistory,
        queryParameters: {
          'page': page,
          'perPage': perPage,
        },
      );

      debugPrint("transaction history response: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return TransactionHistoryResponse.fromJson(response.data);
      } else {
        throw Exception(
          'Failed to load transaction history. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      // You can log or handle DioError specifically here if needed
      throw Exception('Error fetching transaction history: $e');
    }
  }
}
