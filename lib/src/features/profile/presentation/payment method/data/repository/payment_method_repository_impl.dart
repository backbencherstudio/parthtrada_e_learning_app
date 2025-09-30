import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../domain/payment_method_repository.dart';
import 'package:e_learning_app/core/services/api_services/api_end_points.dart';

class PaymentMethodRepositoryImpl implements PaymentMethodRepository {
  @override
  Future<String> createSetupIntent() async {
    final res = await http.post(
      Uri.parse("${ApiEndPoints.baseUrl}/payments/create-setup-intent"),
    );
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return data['client_secret'];
    } else {
      throw Exception("Failed to create setup intent: ${res.statusCode} ${res.body}");
    }
  }

  @override
  Future<bool> savePaymentMethod(String paymentMethodId) async {
    final res = await http.post(
      Uri.parse("${ApiEndPoints.baseUrl}/payments/cards"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "paymentMethodId": paymentMethodId,
        "provider": "stripe",
      }),
    );
    final data = jsonDecode(res.body);
    return res.statusCode == 200 && data["success"] == true;
  }
}