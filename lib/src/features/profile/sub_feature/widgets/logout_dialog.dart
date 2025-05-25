import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:e_learning_app/core/utils/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

void showLogoutDialog(BuildContext context) {
  final textStyle = Theme.of(context).textTheme;
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Are you sure you want to logout?',
                style: textStyle.titleLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.h),
              Text(
                'Click to the Log Our button from to log out from the app.',
                style: textStyle.labelLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 12.w,
                children: [
                  CommonWidget.primaryButton(
                    backgroundColor: AppColors.secondaryStrokeColor,
                      textStyle: textStyle.bodySmall,
                      context: context,
                      onPressed: (){
                      context.pop();
                      },
                      text: 'Cancel'),
                  CommonWidget.primaryButton(
                    backgroundColor: Colors.white,
                      textStyle: textStyle.bodySmall!.copyWith(color: Colors.black,fontWeight: FontWeight.w700),
                      context: context,
                      onPressed: (){

                      },
                      text: 'Log Out')
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
