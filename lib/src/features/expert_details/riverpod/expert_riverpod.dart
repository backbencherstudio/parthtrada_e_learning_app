import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:e_learning_app/repository/api/expert/expart_detail.dart';
import 'package:e_learning_app/src/features/expert_details/model/expert_review_model.dart';
import 'package:flutter/cupertino.dart';
import '../../onboarding/riverpod/login_state.dart';
import 'expert_state.dart';

// final expertIdProvider = Provider<String>((ref) {
//   return 'some_expert_id';
// });

final expertRiverpod = StateNotifierProvider.family<ExpertRiverpod, ExpertState, String>((ref, expertId) {
  return ExpertRiverpod(ref: ref, expertId: expertId);
});

class ExpertRiverpod extends StateNotifier<ExpertState> {
  final String expertId;
  final Ref ref;

  ExpertRiverpod({required this.ref, required this.expertId}) : super(ExpertState()) {
    fetchReviews();
  }

  /// Fetch reviews from the API
  Future<void> fetchReviews() async {
    final token = ref.read(authTokenProvider);

    if (token == null) {
      throw Exception('Unauthorized/No auth token found');
    }

    final repository = FetchExpertDetail();

    try {
      final reviews = await repository.getExpertReviews(token, expertId);
      debugPrint('Successfully fetched expert reviews');

      state = state.copyWith(
        expertReviewList: reviews.data.items,
      );
    } catch (e) {
      debugPrint('Error fetching expert reviews: $e');
      throw Exception('Failed to fetch reviews: $e');
    }
  }

  /// Add a review for the expert
  Future<void> addReview({required ReviewItem userReview}) async {
    final updatedList = List<ReviewItem>.from(state.expertReviewList);
    updatedList.add(userReview);

    state = state.copyWith(expertReviewList: updatedList);
  }

  /// Update the expert's rating
  void onRating({required int ratings}) {
    debugPrint("Rating: $ratings");
    state = state.copyWith(starRating: ratings);
  }

  /// Toggle full review visibility
  void showFullReview() {
    state = state.copyWith(isFullReviewShow: !state.isFullReviewShow);
  }
}
