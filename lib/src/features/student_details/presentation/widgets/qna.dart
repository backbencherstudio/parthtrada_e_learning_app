import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/theme_part/app_colors.dart';

class QNA extends StatelessWidget {
  const QNA({
    super.key,
    required this.textStyle,
    required this.question,
    required this.answer,
  });

  final TextTheme textStyle;
  final String question;
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(question, style: textStyle.titleMedium),
        SizedBox(height: 6.h),
        Text(
          answer,
          style: textStyle.bodySmall!.copyWith(color: AppColors.onSurface),
        ),
      ],
    );
  }
}
