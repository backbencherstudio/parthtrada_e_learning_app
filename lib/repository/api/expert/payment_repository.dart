import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../core/services/api_services/api_end_points.dart';
import '../../login_preferences.dart';

class PaymentRepository {
  Future<bool> confirmPayment({
    required String paymentIntentId,
    // required String paymentMethodId,
  }) async {
    // Validate input parameters
    if (paymentIntentId.isEmpty) {
      debugPrint('======= paymentIntentId or paymentMethodId is empty =======');
      return false;
    }

    final url = Uri.parse(ApiEndPoints.confirmPayment);
    final body = jsonEncode({
      "paymentIntentId": paymentIntentId
      // "paymentMethodId": paymentMethodId,
    });

    // Log the request body for debugging
    debugPrint('======= Sending request with body: $body =======');

    final token = await LoginPreferences().loadAuthToken();

    if (token == null || token.isEmpty) {
      debugPrint('======= token is null or empty =======');
      return false;
    }

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json', // Required for JSON payloads
        },
        body: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('======= Payment confirmed successfully =======');
        return true;
      } else {
        throw Exception('Failed to confirm payment: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      debugPrint('======= Error: $e =======');
      return false;
    }
  }
}