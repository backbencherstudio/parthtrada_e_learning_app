import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../core/services/api_services/api_end_points.dart';
import '../../login_preferences.dart';

class CancelSchedule {
  Future<CancelResponse?> cancelScheduleMeetings({
    required String id
  }) async {
    final url = Uri.parse(ApiEndPoints.cancelScheduleMeetings(id));
    final token = await LoginPreferences().loadAuthToken();

    if (token == null || token == '') {
      debugPrint('======= token is null =======');
      return null;
    }

    final response = await http.patch(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonData = jsonDecode(response.body);
      final result = CancelResponse.fromJson(jsonData);
      debugPrint('Successful to cancel schedule: ${response.body}');
      debugPrint('result: ${result.message}');
      return result;
    } else {
      final jsonData = jsonDecode(response.body);
      final result = CancelResponse.fromJson(jsonData);
      debugPrint('Failed to cancel schedule: ${response.body}');
      debugPrint('result: ${result.message}');
      return result;
    }
  }
}

class CancelResponse {
  final bool success;
  final String message;

  CancelResponse({
    required this.success,
    required this.message,
  });

  factory CancelResponse.fromJson(Map<String, dynamic> json) {
    return CancelResponse(
      success: json['success'],
      message: json['message'],
    );
  }
}
