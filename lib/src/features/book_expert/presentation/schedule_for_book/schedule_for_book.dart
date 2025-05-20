import 'package:e_learning_app/core/constant/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/theme_part/app_colors.dart';

Future<void> scheduleForBook({required BuildContext context})async {
  await showModalBottomSheet(
    backgroundColor: Colors.transparent,
      useSafeArea: false,
      isScrollControlled: true,
      context: context,
      builder: (context){
        return Container(
          padding: AppPadding.screenHorizontal,
          decoration: BoxDecoration(
            color: AppColors.screenBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32.r),
              topRight: Radius.circular(32.r),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

            ],
          ),
        );
      }
  );
}