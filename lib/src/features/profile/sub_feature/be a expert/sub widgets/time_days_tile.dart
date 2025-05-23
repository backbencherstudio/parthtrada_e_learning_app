import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimeDaysTile extends StatelessWidget {
  final String text;
  final bool isSelected;
  const TimeDaysTile({super.key,
  required this.text,
  required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(41.r),
        color: isSelected ? AppColors.primary : AppColors.secondaryStrokeColor
      ),
      child: Text(text,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600
      ),
      ),
    );
  }
}