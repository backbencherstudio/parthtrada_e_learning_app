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
    String? subtitle,
    Widget? trailing,
    bool? isBackIcon,
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 10,
                children: [
                  if (isBackIcon != null && isBackIcon)
                    Icon(
                      Icons.arrow_back_outlined,
                      color: AppColors.mainIconColor,
                      size: 32.w,
                    ),
                  Text(title, style: textTheme.headlineLarge),
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: textTheme.labelLarge!.copyWith(fontSize: 16.sp),
                    ),
                ],
              ),
            ],
          ),
          isNotification ? notificationWidget() : trailing ?? SizedBox.shrink(),
        ],
      ),
    );
  }

  static Container notificationWidget() {
    return Container(
      height: 48.h,
      width: 48.w,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 11.h),
      decoration: BoxDecoration(
        color: AppColors.secondaryButtonBgColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: SvgPicture.asset(AppIcons.notificationIcon),
    );
  }
}
