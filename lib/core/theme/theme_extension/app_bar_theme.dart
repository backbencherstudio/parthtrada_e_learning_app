import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme_part/app_colors.dart';

class AppAppBarTheme {
  static AppBarTheme darkAppBarTheme = AppBarTheme(
    backgroundColor: AppColors.onPrimary,
    actionsPadding: EdgeInsets.all(10.r),
    titleTextStyle: GoogleFonts.roboto(
      textStyle: GoogleFonts.nunitoSans(
        fontSize: 32.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.textColor,
      ),
    ),
  );
}