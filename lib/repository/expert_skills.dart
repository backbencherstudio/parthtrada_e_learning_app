import 'dart:convert';

import 'package:e_learning_app/repository/linkedin_login_webview.dart';
import 'package:http/http.dart' as http;

class ExpertService {
  Future<List<String>> fetchSkills(String authToken) async {
    final response = await http.get(
      Uri.parse('$baseUrl/experts/skills'),
      headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return List<String>.from(body['data']);
    } else {
      throw Exception("Failed to load skills");
    }
  }
}
