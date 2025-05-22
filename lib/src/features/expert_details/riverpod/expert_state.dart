
import 'package:e_learning_app/src/features/expert_details/model/expert_review_model.dart';

class ExpertState{
  int starRating;
  List<ExpertReviewModel>? expertReviewList;

  bool isFullReviewShow;

  ExpertState({this.starRating = 0, this.expertReviewList, this.isFullReviewShow = false});
  ExpertState copyWith({int? starRating, List<ExpertReviewModel>? expertReviewList, bool? isFullReviewShow}){
    return ExpertState(
        starRating: starRating ?? this.starRating,
        expertReviewList: expertReviewList ?? this.expertReviewList,
      isFullReviewShow: isFullReviewShow ?? this.isFullReviewShow
    );
  }

}