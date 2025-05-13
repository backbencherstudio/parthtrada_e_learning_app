import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../constant/icons.dart';
import '../theme/theme_part/app_colors.dart';

class CommonWidget {
  static Widget customAppBar({
    required TextTheme textTheme,
    required bool isNotification,
    required String title,
    required String subtitle,
  }) {
    return SizedBox(
      height: 76.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: textTheme.headlineLarge),
              Text(
                subtitle,
                style: textTheme.labelLarge!.copyWith(fontSize: 16.sp),
              ),
            ],
          ),
          isNotification?Container(
            height: 48.h,
            width: 48.w,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 11.h),
            decoration: BoxDecoration(
              color: AppColors.secondaryButtonBgColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: SvgPicture.asset(AppIcons.notificationIcon),
          ):SizedBox.shrink(),
        ],
      ),
    );
  }
}
