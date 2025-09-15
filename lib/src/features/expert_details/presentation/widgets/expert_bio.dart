import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:e_learning_app/src/features/expert_details/model/user_specific_model.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpertBio extends StatelessWidget {
  final Expert? expert;
  const ExpertBio({super.key, required this.expert});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final String expertBio = expert?.description ?? '';
    return Column(
      spacing: 10.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Professional Bio", style: textTheme.headlineSmall),

        ExpandableText(
          expertBio,
          expandText: "Read More",
          collapseText: "Read Less",
          collapseOnTextTap: true,
          style: textTheme.bodyMedium?.copyWith(
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
