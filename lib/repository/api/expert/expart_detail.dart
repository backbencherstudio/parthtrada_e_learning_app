import 'dart:convert';
import 'package:e_learning_app/core/services/api_services/api_end_points.dart';
import 'package:e_learning_app/src/features/expert_details/model/expert_detail_model.dart';
import 'package:http/http.dart' as http;

class FetchExpertDetail {
  Future<ExpartDetailModel> getExpertDetail(
    String token,
    String expertId,
  ) async {
    final url = Uri.parse(ApiEndPoints.expertDetail(expertId));
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return ExpartDetailModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to fetch expert detail: ${response.statusCode}');
    }
  }
}
