import 'package:e_learning_app/core/constant/padding.dart';
import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:e_learning_app/src/features/expert_details/model/user_specific_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'expert_bio.dart';
import 'expert_details_summary.dart';
import 'expert_reviews/expert_ratings_summary.dart';
import 'expert_reviews/expert_review_list.dart';
import 'expert_sklills.dart';

class ExpertDetailsBody extends StatelessWidget {
  final Data? data;
  const ExpertDetailsBody({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final expert = data?.expert;

    return Padding(
      padding: AppPadding.screenHorizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ExpertDetailsSummary(data: data),
          SizedBox(height: 30.h),
          ExpertSkill(),
          SizedBox(height: 30.h),
          ExpertBio(),
          SizedBox(height: 30.h),

          /// Availability
          Text(
            "Availability",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 10.h),
          Text(
            "Mon - Fri : 07.00 - 16.30",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.secondaryTextColor,
            ),
          ),

          SizedBox(height: 30.h),

          /// Reviews of Expert
          ExpertRatingsSummary(),

          SizedBox(height: 30.h),

          ExpertReviewList(),

          SizedBox(height: 30.h),
        ],
      ),
    );
  }
}
