import 'package:e_learning_app/core/constant/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/theme_part/app_colors.dart';
import 'add_review_for_expert.dart';

Future<void> addReviewBottomSheet({required BuildContext context}) async {
  await showModalBottomSheet(
    backgroundColor: Colors.transparent,
    useSafeArea: false,
    isScrollControlled: true,
    context: context,
    builder: (_) {
      return IntrinsicHeight(
        child: Container(
          padding: AppPadding.screenHorizontal,
          // constraints: BoxConstraints(maxHeight: 425.h),
          decoration: BoxDecoration(
            color: AppColors.screenBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32.r),
              topRight: Radius.circular(32.r),
            ),
          ),

          child: AddReviewForExpert(),

        ),
      );
    },
  );
}
