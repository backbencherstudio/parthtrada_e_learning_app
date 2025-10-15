import 'dart:convert';
import 'package:e_learning_app/core/services/api_services/api_end_points.dart';
import 'package:e_learning_app/src/features/search/model/expert_model.dart';
import 'package:http/http.dart' as http;

class FetchExpert {
  Future<ExpertModel> getExperts(
      String token, {
        int page = 1,
        int perPage = 10,
        String? query,
        String? skills,
      }) async {
    String urlStr = ApiEndPoints.expertList(page, perPage);

    if (query != null && query.trim().isNotEmpty) {
      urlStr =
      '${ApiEndPoints.baseUrl}/experts?q=${Uri.encodeComponent(query)}&page=$page&perPage=$perPage';
    }

    final bool hasSkills = skills != null && skills.trim().isNotEmpty;
    if (hasSkills) {
      final encodedSkills = Uri.encodeQueryComponent(skills!);
      if (urlStr.contains('?')) {
        urlStr = '$urlStr&skills=$encodedSkills';
      } else {
        urlStr =
        '${ApiEndPoints.baseUrl}/experts?skills=$encodedSkills&page=$page&perPage=$perPage';
      }
    }

    final url = Uri.parse(urlStr);

    final response = await http.get(
      url,
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
