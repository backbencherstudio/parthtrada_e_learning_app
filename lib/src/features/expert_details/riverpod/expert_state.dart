import '../model/expert_review_model.dart';

class ExpertState {
  int starRating;
  List<ReviewItem> expertReviewList;  // No longer nullable
  bool isFullReviewShow;

  ExpertState({
    this.starRating = 0,
    this.expertReviewList = const [],  // Default to an empty list
    this.isFullReviewShow = false,
  });

  ExpertState copyWith({
    int? starRating,
    List<ReviewItem>? expertReviewList,
    bool? isFullReviewShow,
  }) {
    return ExpertState(
      starRating: starRating ?? this.starRating,
      expertReviewList: expertReviewList ?? this.expertReviewList,
      isFullReviewShow: isFullReviewShow ?? this.isFullReviewShow,
    );
  }
}
