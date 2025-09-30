import 'dart:convert';
import 'package:e_learning_app/core/services/api_services/api_end_points.dart';
import 'package:e_learning_app/src/features/expert_details/model/expert_detail_model.dart';
import 'package:e_learning_app/src/features/expert_details/model/expert_review_model.dart';
import 'package:http/http.dart' as http;

class FetchExpertDetail {
  /// expert details
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

  /// expert reviews
  Future<ExpertReviewModel> getExpertReviews(
      String token,
      String expertId,
      ) async {
    final url = Uri.parse(ApiEndPoints.expertReviewsById(expertId, 1, 5));
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return ExpertReviewModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to fetch expert reviews: ${response.statusCode}');
    }
  }
}
