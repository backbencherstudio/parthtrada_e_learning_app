import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/theme_part/app_colors.dart';

class ProfessionalBio extends StatelessWidget {
  const ProfessionalBio({
    super.key,
    required this.textStyle,
  });

  final TextTheme textStyle;

  @override
  Widget build(BuildContext context) {
    final String studentBio =
        "An experienced industry professional dedicated to helping students and early-career individuals with personalized career advice, skill-building, and growth strategies"
        "An experienced industry professional dedicated to helping students and early-career individuals with personalized career advice, skill-building, and growth strategies";

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Professional Bio', style: textStyle.headlineSmall),
        SizedBox(height: 5.h),
        ExpandableText(
          studentBio,
          expandText: "Read More",
          collapseText: "Read Less",
          collapseOnTextTap: true,
          style: textStyle.bodyMedium?.copyWith(
            color: AppColors.secondaryTextColor,
          ),
          maxLines: 4,
          animation: true,
          expandOnTextTap: true,
          linkColor: AppColors.primary,
          animationDuration: Duration(milliseconds: 300),
          animationCurve: Curves.linear,
        ),
      ],
    );
  }
}