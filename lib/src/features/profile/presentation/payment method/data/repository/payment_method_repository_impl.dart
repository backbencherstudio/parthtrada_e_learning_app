import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:e_learning_app/src/features/profile/presentation/payment%20method/data/models/account_status_response.dart';
import 'package:e_learning_app/src/features/profile/presentation/payment%20method/data/models/balance_response.dart';
import 'package:e_learning_app/src/features/profile/presentation/payment%20method/data/models/payout_response.dart';
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
      if (e is DioException) {
        final errorMessage = e.response?.data["error"]?["message"] ?? "Something went wrong";
        throw Exception(errorMessage);
      } else {
        throw Exception("Something went wrong");
      }
    }

  }

  @override
  Future<bool> addCard(String token) async {

    debugPrint("token received: $token");

    try {
      final response = await _apiService.post(
        ApiEndPoints.addCard,
        data: {"token": token},
      );

      if (response.data != null) {
        return true;
      } else {
        throw Exception("Failed to add card to backend");
      }
    } catch (e) {
      debugPrint("Exception in add card: $e");
      if (e is DioException) {
        debugPrint("Error Response: ${e.response?.data['success']}");
        if(e.response?.data['success']==false)
          {
            return false;
          }
      }
      throw Exception('Error in addCard');
    }
  }

  @override
  Future<bool> createAccount() async {
    try {
      final response = await _apiService.post(ApiEndPoints.createAccount);

      // Log the full response for debugging
      debugPrint("createAccount response: ${response.data}");

      // Check if response.data is a map and has 'success' key
      if (response.data is Map<String, dynamic> && response.data['success'] is bool) {
        if (response.data['success'] == true) {
          return true;
        } else {
          throw Exception("Failed to create account: ${response.data['message'] ?? 'Unknown error'}");
        }
      } else {
        throw Exception("Invalid response format: ${response.data}");
      }
    } catch (e, stackTrace) {
      debugPrint("Exception in createAccount: $e\nStackTrace: $stackTrace");
      if (e is DioException) {
        debugPrint("Error Response: ${e.response?.data}");
        if (e.response?.data is Map<String, dynamic> && e.response?.data['success'] == false) {
          return false;
        }
      }
      throw Exception('Error in createAccount: $e');
    }
  }

  @override
  Future<String> getOnbordingUrl() async {
    try {
      final response = await _apiService.get(
        ApiEndPoints.onboardingLink,
      );
      debugPrint("get url response: ${response.data}");

      if (response.data != null && response.data['success']==true) {
        return response.data['url'];
      } else {
        throw Exception("Failed to add card to backend");
      }
    } catch (e) {
      debugPrint("Exception in add card: $e");
      if (e is DioException) {
        debugPrint("Error Response: ${e.response?.data['success']}");
        if(e.response?.data['success']==false)
        {
          throw Exception('Error in addCard');
        }
      }
      throw Exception('Error in addCard');
    }


  }

  @override
  Future<AccountStatusResponse> getAccountStatus() async {
    try {
      final response = await _apiService.post(ApiEndPoints.checkAccoutStatus);

      if (response.data != null) {
        return AccountStatusResponse.fromJson(response.data);
      } else {
        throw Exception("Empty response from server");
      }
    } catch (e) {
      debugPrint("Exception in getAccountStatus: $e");

      if (e is DioException) {
        final errorData = e.response?.data;
        debugPrint("Error Response: $errorData");

        final errorMessage = errorData?['message'] ?? 'Failed to fetch account status';
        throw Exception(errorMessage);
      }

      throw Exception("Unexpected error occurred while fetching account status");
    }
  }

  @override
  Future<BalanceResponse> checkBalance() async {
    try {
      final response = await _apiService.get(ApiEndPoints.balanceCheck);

      debugPrint("checkBalance response: ${response.data}");

      if (response.data != null) {
        return BalanceResponse.fromJson(response.data);
      } else {
        throw Exception("Empty response from server");
      }
    } catch (e) {
      debugPrint("Exception in checkBalance: $e");

      if (e is DioException) {
        final errorData = e.response?.data;
        debugPrint("Error Response: $errorData");

        final errorMessage = errorData?['message'] ?? 'Failed to fetch balance';
        throw Exception(errorMessage);
      }

      throw Exception("Unexpected error occurred while fetching balance");
    }
  }

  @override
  Future<PayoutResponse> payoutBalance(double amount) async {
    try {
      final response = await _apiService.post(ApiEndPoints.payoutBalance, data: {'amount': amount});

      debugPrint("payoutBalance response: ${response.data}");

      if (response.data != null) {
        return PayoutResponse.fromJson(response.data);
      } else {
        throw Exception("Empty response from server");
      }
    } catch (e) {
      debugPrint("Exception in payoutBalance: $e");

      if (e is DioException) {
        final errorData = e.response?.data;
        debugPrint("Error Response: $errorData");

        final errorMessage = errorData?['message'] ?? 'Failed to initiate payout';
        throw Exception(errorMessage);
      }

      throw Exception("Unexpected error occurred while initiating payout");
    }
  }


}