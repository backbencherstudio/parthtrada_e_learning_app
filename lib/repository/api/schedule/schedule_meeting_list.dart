import 'dart:convert';
import 'package:e_learning_app/core/services/api_services/api_end_points.dart';
import 'package:e_learning_app/src/features/schedule/model/schedule_meeting_model.dart';
import 'package:e_learning_app/src/features/search/model/expert_model.dart';
import 'package:e_learning_app/src/features/search/model/home_stat_model.dart';
import 'package:e_learning_app/src/features/search/model/skill_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../login_preferences.dart';

class ScheduleMeetingList {
  Future<ScheduleMeetingModel?> getScheduleMeetings() async {
    final url = Uri.parse(ApiEndPoints.getScheduleMeetings(1, 10));

    final token = await LoginPreferences().loadAuthToken();

    if (token == null || token == '' ) {
      debugPrint('======= token is null =======');
      return null;
    }

    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonData = jsonDecode(response.body);
      debugPrint('=======${ScheduleMeetingModel.fromJson(jsonData).message}=======');
      return ScheduleMeetingModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to fetch skills: ${response.statusCode}');
    }
  }
}
