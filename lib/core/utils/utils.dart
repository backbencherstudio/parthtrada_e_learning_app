import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Utils{
  static BoxDecoration commonBoxDecoration(){
    return BoxDecoration(
      color: AppColors.secondary,
      borderRadius: BorderRadius.circular(12.r)
    );
  }
}