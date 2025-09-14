import 'package:e_learning_app/core/constant/icons.dart';
import 'package:e_learning_app/src/features/expert_details/model/user_specific_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'expert_summary_container.dart';

class ExpertDetailsSummary extends StatelessWidget {
  final Data? data;
  const ExpertDetailsSummary({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // final totalStudensNumber =
    //     data?.stats?.totalStudents != 0 ? data?.stats?.totalStudents : 'N/A';
    return Row(
      spacing: 10.w,
      children: [
        /// Total Students of the students
        Expanded(
          child: ExpertDetailsSummaryContainer(
            headerText: "Students",
            // bodyText: '${data?.expert?.totalStudents?}',
            bodyText: '${data?.stats?.totalStudents ?? 0}+',
            svgIconAssetPath: AppIcons.userFill,
          ),
        ),

        /// Total Experience
        Expanded(
          child: ExpertDetailsSummaryContainer(
            headerText: "Experience",
            bodyText: "${data?.expert?.experience}yr+",
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
