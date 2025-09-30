import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/services/api_services/api_end_points.dart';
import '../../../src/features/search/model/expert_review_model.dart';

class FetchExpertReview {
  Future<UserReviewModel> getExpertsReview(String token) async {
    final url = Uri.parse(ApiEndPoints.expertReview);
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return UserReviewModel.fromJson(jsonData);
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception(
          'Failed to fetch expert reviews: ${response.statusCode} ${errorData}');
    }
  }
}
