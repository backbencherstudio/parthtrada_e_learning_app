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
    final totalStudensNumber = data?.stats?.totalStudents ?? 0;
    final bodyTextPart = data?.expert?.experience ?? 'N/A';
    final totalReviews = data?.stats?.totalReviews ?? 0;
    return Row(
      spacing: 10.w,
      children: [
        Expanded(
          child: ExpertDetailsSummaryContainer(
            headerText: "Students",
            bodyText:
                totalStudensNumber > 1
                    ? '${totalStudensNumber - 1} +'
                    : totalStudensNumber > 0
                    ? '$totalStudensNumber'
                    : 'N/A',
            svgIconAssetPath: AppIcons.userFill,
          ),
        ),

        /// Total Experience
        Expanded(
          child: ExpertDetailsSummaryContainer(
            headerText: "Experience",
            bodyText: "$bodyTextPart yr+",

            svgIconAssetPath: AppIcons.circleTikMarkFill,
          ),
        ),

        /// Total Reviews
        Expanded(
          child: ExpertDetailsSummaryContainer(
            headerText: "Reviews",
            bodyText:
                totalReviews > 2 ? '${totalReviews - 1}+' : '$totalReviews',
            svgIconAssetPath: AppIcons.starFill,
          ),
        ),
      ],
    );
  }
}
