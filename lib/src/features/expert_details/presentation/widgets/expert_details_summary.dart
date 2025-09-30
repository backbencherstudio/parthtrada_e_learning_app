// expert_details_summary.dart
import 'package:e_learning_app/core/constant/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/expert_detail_model.dart';
import 'expert_summary_container.dart';

class ExpertDetailsSummary extends StatelessWidget {
  final Stats? stats;
  final String experience;
  const ExpertDetailsSummary({super.key, this.stats, required this.experience});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ExpertDetailsSummaryContainer(
            headerText: "Students",
            bodyText: "${stats?.totalStudents ?? 0}+",
            svgIconAssetPath: AppIcons.userFill,
          ),
        ),
        Expanded(
          child: ExpertDetailsSummaryContainer(
            headerText: "Experience",
            bodyText: "$experience yr+",
            svgIconAssetPath: AppIcons.circleTikMarkFill,
          ),
        ),
        Expanded(
          child: ExpertDetailsSummaryContainer(
            headerText: "Reviews",
            bodyText: "${stats?.totalReviews ?? 0}+",
            svgIconAssetPath: AppIcons.starFill,
          ),
        ),
      ],
    );
  }
}
