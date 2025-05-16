import 'package:e_learning_app/core/constant/padding.dart';
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
            isNotification?notificationWidget():SizedBox.shrink(),
          ],
        ),
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


  static Widget primaryButton({required BuildContext context, required VoidCallback onPressed, required String text}){
    return ElevatedButton(onPressed: onPressed, child: Text(text,style: Theme.of(context).textTheme.bodySmall,),
    );
  }

}
