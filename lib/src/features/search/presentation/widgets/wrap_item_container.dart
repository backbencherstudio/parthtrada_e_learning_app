import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/theme_part/app_colors.dart';

class WrapItemContainer extends StatelessWidget {
  final String text;
  final bool? isRemainingItemShow;
  final TextStyle? textStyle;

  const WrapItemContainer({super.key, required this.text, this.isRemainingItemShow, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.03),
        border: isRemainingItemShow == true ? null : Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
        borderRadius: isRemainingItemShow == true ? null : BorderRadius.circular(30.r),
        shape: isRemainingItemShow == true ? BoxShape.circle : BoxShape.rectangle,
      ),
      child: Text(
        text,
        style: textStyle?.copyWith(color: AppColors.primary) ?? Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(color: AppColors.primary),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      ),
    );
  }
}
