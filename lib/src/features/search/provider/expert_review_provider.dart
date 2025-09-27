import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../repository/api/expert/expert_review.dart';
import '../../onboarding/riverpod/login_state.dart';
import '../model/expert_review_model.dart';

final expertReviewProvider = FutureProvider<UserReviewModel>((ref) async {
  final token = ref.watch(authTokenProvider);

  if (token == null) {
    throw Exception('Unauthorized / No auth token found');
  }

  final repository = FetchExpertReview();
  return await repository.getExpertsReview(token);
});
