import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../../../../../../core/services/api_services/api_end_points.dart';
import '../../../../../../../core/services/api_services/api_services.dart';
import '../../domain/payment_method_repository.dart';

class PaymentMethodRepositoryImpl implements PaymentMethodRepository {
  final ApiService _apiService = ApiService();

  @override
  Future<String> addPaymentMethod(
      String cardNumber, String expMonth, String expYear, String cvc) async {
    final url = Uri.parse("https://api.stripe.com/v1/tokens");

    // Validate expMonth (should be 01-12)
    final month = int.tryParse(expMonth);
    if (month == null || month < 1 || month > 12) {
      throw Exception("Invalid expiration month");
    }

    try {
      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer pk_test_51SD0zRCxUxOOLtAci4asQy9jiijS471gYWJhRcPsv3WUKYq7T5o1yR4HQuJ5bcMBeXFFJsad1o1Bi2QM32eIm7OA00cM1aUPPK", // Replace with your Stripe SECRET key
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: {
          "card[number]": cardNumber,
          "card[exp_month]": expMonth, // Use expMonth directly (e.g., "12")
          "card[exp_year]": expYear,   // Use expYear as-is (e.g., "25" or "2025")
          "card[cvc]": cvc,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data["id"] != null) {
          return data["id"]; // Return the token id
        } else {
          throw Exception("Invalid response: No token ID found");
        }
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(
            "Failed to create payment method: ${errorData['error']['message'] ?? 'Unknown error'}");
      }
    } catch (e) {
      throw Exception("Error in addPaymentMethod: $e");
    }
  }

  @override
  Future<bool> addCard(String token) async {

    debugPrint("token received: $token");

    try {
      final response = await _apiService.post(
        ApiEndPoints.addCard,
        data: {'token': token},
      );

      if (response.data != null && response.data['success'] == true) {
        return true;
      } else {
        throw Exception("Failed to add card to backend");
      }
    } catch (e) {
      throw Exception('Error in addCard: $e');
    }
  }
}