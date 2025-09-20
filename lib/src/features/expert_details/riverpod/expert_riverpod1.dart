// expert_riverpod.dart

import 'dart:convert';

import 'package:e_learning_app/repository/linkedin_login_webview.dart';
import 'package:e_learning_app/src/features/expert_details/model/expert_review_list_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final expertReviewListProvider =
    StateNotifierProvider<ExpertReviewNotifier, Data?>(
      (ref) => ExpertReviewNotifier(ref),
    );

class ExpertReviewNotifier extends StateNotifier<Data?> {
  final Ref ref;
  bool isFullReviewShow = false;

  ExpertReviewNotifier(this.ref) : super(null);

  void showFullReview() {
    isFullReviewShow = !isFullReviewShow;
    state = state;
  }

  Future<void> fetchReviews({
    required int page,
    required String id,
    required String token,
  }) async {
    final uri = '$baseUrl/experts/$id/reviews?page=$page&limit=3';
    final url = Uri.parse(uri);

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final expertReviewDetails = ExpertReviewListModel.fromJson(jsonData);

        if (expertReviewDetails.data != null) {
          state = expertReviewDetails.data;
        }
      } else {
        debugPrint('Failed to fetch reviews: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching reviews: $e');
    }
  }
}
