// expert_bio.dart
import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpertBio extends StatelessWidget {
  final String description;
  const ExpertBio({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Professional Bio", style: textTheme.headlineSmall),
        SizedBox(height: 10.h),
        ExpandableText(
          description,
          expandText: "Read More",
          collapseText: "Read Less",
          collapseOnTextTap: true,
          style: textTheme.bodyMedium
              ?.copyWith(color: AppColors.secondaryTextColor),
          maxLines: 4,
          animation: true,
          expandOnTextTap: true,
          linkColor: AppColors.primary,
          animationDuration: const Duration(milliseconds: 300),
          animationCurve: Curves.linear,
        ),
      ],
    );
  }
}
