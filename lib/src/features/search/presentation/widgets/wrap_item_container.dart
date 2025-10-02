import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/theme_part/app_colors.dart';

class WrapItemContainer extends StatelessWidget {
  final String text;
  final bool? isRemainingItemShow;
  final bool isSelected;
  final TextStyle? textStyle;

  const WrapItemContainer({
    super.key,
    required this.text,
    this.isRemainingItemShow,
    this.textStyle,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.primary.withOpacity(0.3)
            : AppColors.primary.withAlpha(8),
        border: isRemainingItemShow == true
            ? null
            : Border.all(
          color: isSelected
              ? AppColors.primary
              : AppColors.primary.withAlpha(25),
        ),
        borderRadius: isRemainingItemShow == true
            ? null
            : BorderRadius.circular(30.r),
        shape: isRemainingItemShow == true ? BoxShape.circle : BoxShape.rectangle,
      ),
      child: Text(
        text,
        style: textStyle?.copyWith(
          color: isSelected
              ? Colors.white
              : AppColors.primary,
        ) ??
            Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isSelected ? Colors.white : AppColors.primary,
            ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      ),
    );
  }
}
