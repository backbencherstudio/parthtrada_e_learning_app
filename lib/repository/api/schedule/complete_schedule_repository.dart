import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../core/services/api_services/api_end_points.dart';
import '../../login_preferences.dart';

class CompleteScheduleRepository {
  Future<String?> completeScheduleMeetings({
    required String id
  }) async {
    final url = Uri.parse(ApiEndPoints.completedScheduleMeetings(id));
    final token = await LoginPreferences().loadAuthToken();

    if (token == null || token == '') {
      debugPrint('======= token is null =======');
      return null;
    }

    final response = await http.post(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonData = jsonDecode(response.body);
      return jsonData['message'];
    } else {
      throw Exception('Failed to fetch schedule: ${response.statusCode}');
    }
  }
}
