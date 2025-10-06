import 'dart:convert';
import 'package:e_learning_app/src/data/model/accept_reject_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import '../../../../../core/services/api_services/api_end_points.dart';
import '../../../../../repository/login_preferences.dart';

class AcceptRejectBookingRepository {
  Future<AcceptRejectResponseModel?> patchBookingAction({
    required String url,
  }) async {
    final token = await LoginPreferences().loadAuthToken();
    final fullUrl = Uri.parse(ApiEndPoints.baseUrl + url);

    final response = await http.patch(
      fullUrl,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonData = jsonDecode(response.body);
      return AcceptRejectResponseModel.fromJson(jsonData);
    } else {
      debugPrint('Error PATCH: ${response.statusCode} ${response.body}');
      throw Exception('Failed to update booking');
    }
  }
}
