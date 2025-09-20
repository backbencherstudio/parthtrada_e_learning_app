import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCircleCheckbox extends StatelessWidget {
  final bool isChecked;
  final void Function()? onTap;

  const CustomCircleCheckbox({
    super.key,
    required this.isChecked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 20.h,
        width: 20.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
color: isChecked ? AppColors.primary : null,
          border: Border.all(
            width: 2.w,
color: isChecked ? AppColors.primary : const Color(0xff777980),
          ),
        ),
        child: isChecked
            ? const Center(child: Icon(Icons.check, size: 16, color: Color(0xffffffff)))
            : null,
      ),
    );
  }
}
