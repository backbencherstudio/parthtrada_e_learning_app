import 'dart:convert';
import 'package:e_learning_app/core/services/api_services/api_end_points.dart';
import 'package:e_learning_app/src/features/book_expert/model/get_card_data_model.dart';
import 'package:e_learning_app/src/features/search/model/expert_model.dart';
import 'package:e_learning_app/src/features/search/model/skill_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../login_preferences.dart';

class GetCardRepository {
  Future<CardsResponse?> getCards() async {
    final url = Uri.parse(ApiEndPoints.getCards);

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
      debugPrint('=======${CardsResponse.fromJson(jsonData).message}');
      return CardsResponse.fromJson(jsonData);
    } else {
      throw Exception('Failed to fetch Cards: ${response.statusCode}');
    }
  }
}
