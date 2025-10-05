import 'dart:convert';
import 'package:e_learning_app/src/features/profile/data/models/past_call_response_model.dart';
import 'package:e_learning_app/src/features/profile/data/models/sent_request_response_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../../core/services/api_services/api_end_points.dart';
import '../../../../../repository/login_preferences.dart';

class GetSendRequestRepositoryList {
  Future<SendRequestResponse?> getSendRequest({
    required int page,
    int limit = 10,
  }) async {
    final url = Uri.parse(ApiEndPoints.getSendRequests(page, limit));
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
      return SendRequestResponse.fromJson(jsonData);
    } else {
      throw Exception('Failed to fetch past calls: ${response.statusCode}');
    }
  }
}
