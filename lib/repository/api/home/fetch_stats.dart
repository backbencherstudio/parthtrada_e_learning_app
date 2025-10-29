import 'dart:convert';
import 'package:e_learning_app/core/services/api_services/api_end_points.dart';
import 'package:e_learning_app/src/features/search/model/home_stat_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FetchStats {
  Future<HomeStatModel> getStats(String token) async {
    final url = Uri.parse(ApiEndPoints.statList);

    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      debugPrint('=======${HomeStatModel.fromJson(jsonData).message}=======');
      return HomeStatModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to fetch skills: ${response.statusCode}');
    }
  }
}
