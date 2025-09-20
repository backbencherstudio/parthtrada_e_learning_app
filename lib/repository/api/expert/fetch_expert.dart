import 'dart:convert';

import 'package:e_learning_app/repository/linkedin_login_webview.dart';
import 'package:e_learning_app/src/features/search/model/expert_model.dart';
import 'package:http/http.dart' as http;

class FetchExpert {
  Future<ExpertModel> getExperts(String token) async {
    final url = '$baseUrl/experts';
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return ExpertModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to fetch experts: ${response.statusCode}');
    }
  }
}
