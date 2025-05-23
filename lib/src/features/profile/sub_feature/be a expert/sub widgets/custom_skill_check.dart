// ignore_for_file: deprecated_member_use


import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_checkBox.dart';

class CustomSkillCheck extends StatelessWidget {
  final String text;
    final bool isSelected;

  final void Function()? onTap;
  const CustomSkillCheck({super.key, required this.text, required this.onTap, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32.r),
          color: Color(0xff019877).withOpacity(0.1),
          border: Border.all(
            color: AppColors.primary.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: 8.w,
            right: 12.w,
            top: 5.h,
            bottom: 5.h,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomCheckbox(value: isSelected, onChanged: (_)=> onTap?.call()),
              SizedBox(width: 6.w),
              Text(
                text,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
