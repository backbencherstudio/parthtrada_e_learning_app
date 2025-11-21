import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../core/services/api_services/api_end_points.dart';
import '../../../core/services/local_storage_services/user_type_storage.dart';
import '../../../src/features/schedule/model/schedule_meeting_model.dart';
import '../../login_preferences.dart';

class ScheduleMeetingList {
  Future<ScheduleMeetingModel?> getScheduleMeetings({
    required int page,
    int limit = 10,
  }) async {
    final UserTypeStorage _userTypeStorage = UserTypeStorage();
    final role = await _userTypeStorage.getUserType();

    debugPrint('======= $page ======= $limit =======');
    final url = Uri.parse(role == 'EXPERT' ? ApiEndPoints.getScheduleMeetingsForExperts(page, limit) : ApiEndPoints.getScheduleMeetingsForStudents(page, limit));
    final token = await LoginPreferences().loadAuthToken();

    if (token == null || token == '') {
      debugPrint('======= token is null =======');
      return null;
    }

    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonData = jsonDecode(response.body);
      debugPrint('======= schedule meetings data ======= $jsonData');
      return ScheduleMeetingModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to fetch schedule: ${response.statusCode}');
    }
  }
}
