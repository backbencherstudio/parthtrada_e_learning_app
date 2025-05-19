import 'package:e_learning_app/core/constant/padding.dart';
import 'package:e_learning_app/core/routes/route_name.dart';
import 'package:e_learning_app/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../constant/icons.dart';
import '../theme/theme_part/app_colors.dart';

class CommonWidget {
  static Widget customAppBar({
    required TextTheme textTheme,
    required bool isNotification,
    required String title,
    required String subtitle,
    BuildContext? context,
  }) {
    return SafeArea(
      child: Padding(
        padding: AppPadding.screenHorizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: textTheme.headlineLarge),
                  Text(
                    subtitle,
                    style: textTheme.labelLarge!.copyWith(fontSize: 16.sp),
                  ),
                ],
              ),
            ),
            isNotification ? notificationWidget(context!) : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  static Container notificationWidget(BuildContext context) {
    return Container(
      height: 48.h,
      width: 48.w,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 11.h),
      decoration: BoxDecoration(
        color: AppColors.secondaryButtonBgColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: GestureDetector(
        onTap: () {
          context.push(RouteName.globalNotificationScreen);
        },
        child: SvgPicture.asset(AppIcons.notificationIcon),
      ),
    );
  }

  static Widget primaryButton({
    required BuildContext context,
    required VoidCallback onPressed,
    required String text,
    Color? backgroundColor,
    Color? foregroundColor,
    TextStyle? textStyle,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.primary,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style:
            textStyle ??
            Theme.of(context).textTheme.bodySmall?.copyWith(
              color: foregroundColor ?? Colors.white,
            ),
      ),
    );
  }

  static Widget closeButton({
    required BuildContext context,
    Color? backgroundColor,
    Color? foregroundColor,
    VoidCallback? ontap,
  }) {
    return GestureDetector(
      onTap: () {
        if (ontap != null) {
          ontap();
        } else {
          Navigator.pop(context);
        }
      },

      child: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.secondaryStrokeColor,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          AppIcons.close,
          colorFilter: ColorFilter.mode(
            foregroundColor ?? Colors.white,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
