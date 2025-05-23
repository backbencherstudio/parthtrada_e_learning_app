import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/constant/padding.dart';
import '../../../../../../core/theme/theme_part/app_colors.dart';

Future<void> confirmBookingBottomSheet({required BuildContext context}) async {
  await showModalBottomSheet(
    backgroundColor: Colors.transparent,
    useSafeArea: false,
    isScrollControlled: true,
    context: context,
    builder: (_) {
      final textTheme = Theme.of(context).textTheme;
      final buttonTextStyle = textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w700,
      );

      return Container(
        constraints: BoxConstraints(maxHeight: 585.h),
        padding: AppPadding.screenHorizontal,
        decoration: BoxDecoration(
          color: AppColors.screenBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32.r),
            topRight: Radius.circular(32.r),
          ),
        ),

      );
    },
  );
}
