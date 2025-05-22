
import 'package:e_learning_app/core/constant/images.dart';
import 'package:e_learning_app/src/features/expert_details/model/expert_review_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'expert_state.dart';


final expertRiverpod = StateNotifierProvider<ExpertRiverpod,ExpertState>((ref)=>ExpertRiverpod());

class ExpertRiverpod extends StateNotifier<ExpertState>{
  ExpertRiverpod():super(ExpertState()){
    fetchReviews();
  }

  final List<Map<String,dynamic>> expertReviews = const [
    {
      "userName": "Olivia Rhye",
      "profilePicture":AppImages.women,
      "ratings": 4,
      "e-mail": "olivia@gmail.com",
      "reviews": "Incredible group of people and talented professionals."
    },
    {
      "userName": "Olivia Rhye",
      "profilePicture":AppImages.women,
      "ratings": 4,
      "e-mail": "olivia@gmail.com",
      "reviews": "Incredible group of people and talented professionals."
    },
    {
      "userName": "Olivia Rhye",
      "profilePicture":AppImages.women,
      "ratings": 4,
      "e-mail": "olivia@gmail.com",
      "reviews": "Incredible group of people and talented professionals."
    },
    {
      "userName": "Olivia Rhye",
      "profilePicture":AppImages.women,
      "ratings": 4,
      "e-mail": "olivia@gmail.com",
      "reviews": "Incredible group of people and talented professionals."
    },
    {
      "userName": "Olivia Rhye",
      "profilePicture":AppImages.women,
      "ratings": 4,
      "e-mail": "olivia@gmail.com",
      "reviews": "Incredible group of people and talented professionals."
    },
    {
      "userName": "Olivia Rhye",
      "profilePicture":AppImages.women,
      "ratings": 4,
      "e-mail": "olivia@gmail.com",
      "reviews": "Incredible group of people and talented professionals."
    },
    {
      "userName": "Olivia Rhye",
      "profilePicture":AppImages.women,
      "ratings": 4,
      "e-mail": "olivia@gmail.com",
      "reviews": "Incredible group of people and talented professionals."
    },

  ];

  /// fetch reviews
  Future<void> fetchReviews() async {
    final reviewList = expertReviews.map((review)=>ExpertReviewModel.fromJson(review)).toList();
    state = state.copyWith(
      expertReviewList: reviewList
    );
  }

  /// Give reviews for expert
  Future<void> addReviews({required ExpertReviewModel userReview}) async{
    state.expertReviewList!.add(userReview);
    //final review = state.expertReviewList;
    state = state.copyWith(
      expertReviewList: state.expertReviewList
    );
  }

  /// give rating for expert
  void onRating({required int ratings}){
    debugPrint("Ratings $ratings");
    state = state.copyWith(starRating: ratings);
  }

  /// show full review
  void showFullReview(){
    state = state.copyWith(isFullReviewShow: !state.isFullReviewShow);
  }
}