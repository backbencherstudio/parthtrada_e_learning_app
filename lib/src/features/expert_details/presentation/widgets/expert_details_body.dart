import 'package:e_learning_app/core/constant/padding.dart';
import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:e_learning_app/src/features/expert_details/model/expert_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'expert_bio.dart';
import 'expert_details_summary.dart';
import 'expert_reviews/expert_ratings_summary.dart';
import 'expert_reviews/expert_review_list.dart';
import 'expert_sklills.dart';

class ExpertDetailsBody extends StatelessWidget {
  final String description;
  final List<String> skills;
  final List<String> availableDays;
  final List<String> availableTime;
  final Stats? stats;
  final String experience;
  final String expertId;
  final Availability availability;

  const ExpertDetailsBody({
    super.key,
    required this.description,
    required this.skills,
    required this.availableDays,
    required this.availableTime,
    this.stats, required this.experience, required this.expertId, required this.availability,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: AppPadding.screenHorizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExpertDetailsSummary(stats: stats, experience: experience,),
          SizedBox(height: 30.h),

         ExpertSkill(skills: skills),
          SizedBox(height: 30.h),

          ExpertBio(description: description),
          SizedBox(height: 30.h),

          /// Availability
          Text(
            "Availability",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 10.h),

          Column(
            children: List.generate(availability.days?.length ?? 0, (index) {
              return Row(
                children: [
                  Text('${availability.days?[index]} : '),
                  Text(availability.time?[index] ?? ''),
                ],
              );
            }),
          ),

          SizedBox(height: 30.h),

          /// Reviews Section
          ExpertRatingsSummary(stats: stats),
          SizedBox(height: 30.h),
          ExpertReviewList(expertId: expertId,),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }
}
