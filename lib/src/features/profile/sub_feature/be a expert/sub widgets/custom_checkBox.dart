// ignore_for_file: use_super_parameters

import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomCheckbox({Key? key, required this.value, required this.onChanged})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        height: 16.h,
        width: 16.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          color: value ? AppColors.primary : Colors.transparent,
          border: Border.all(color: AppColors.primary, width: 1.5),
        ),
        child:
            value
                ? Center(
                  child: Icon(Icons.check, size: 12.sp, color: Color(0xff191919)),
                )
                : null,
      ),
    );
  }
}
