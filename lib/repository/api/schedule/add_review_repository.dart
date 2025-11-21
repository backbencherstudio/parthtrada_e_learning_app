import 'dart:convert';
import 'package:e_learning_app/src/features/schedule/model/add_review_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../core/services/api_services/api_end_points.dart';
import '../../login_preferences.dart';

class AddReviewRepository {
  Future<bool> addReview({
    required AddReviewModel review
  }) async {
    final url = Uri.parse(ApiEndPoints.addReview);
    final token = await LoginPreferences().loadAuthToken();

    if (token == null || token == '') {
      debugPrint('======= token is null =======');
      return false;
    }

    debugPrint('======= $url =======');
    debugPrint('======= $token =======');
    debugPrint('======= ${review.toJson()} =======');

    final response = await http.post(
      url,
      headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
      body: jsonEncode(review.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonData = jsonDecode(response.body);
      debugPrint('======= $jsonData =======');
      return jsonData['success'];
    } else {
      throw Exception('Failed to post review: ${response.statusCode}');
    }
  }
}