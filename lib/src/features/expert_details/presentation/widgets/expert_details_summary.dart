import 'package:e_learning_app/core/constant/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'expert_summary_container.dart';

class ExpertDetailsSummary extends StatelessWidget{
  const ExpertDetailsSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10.w,
      children: [

        /// Total Students of the students
        Expanded(
          child: ExpertDetailsSummaryContainer(
            headerText: "Students",
            bodyText: "580+",
            svgIconAssetPath: AppIcons.userFill,
          ),
        ),

        /// Total Experience
        Expanded(
          child: ExpertDetailsSummaryContainer(
            headerText: "Experience",
            bodyText: "4 yr+",
            svgIconAssetPath: AppIcons.circleTikMarkFill,
          ),
        ),

        /// Total Reviews
        Expanded(
          child: ExpertDetailsSummaryContainer(
            headerText: "Reviews",
            bodyText: "230+",
            svgIconAssetPath: AppIcons.starFill,
          ),
        ),
      ],
    );
  }
}