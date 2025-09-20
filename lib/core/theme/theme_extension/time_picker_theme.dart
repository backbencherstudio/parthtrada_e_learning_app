import 'package:flutter/material.dart';
import '../theme_part/app_colors.dart';

class CustomTimePickerTheme{
  static TimePickerThemeData timePickerTheme = TimePickerThemeData(
    hourMinuteColor: WidgetStateColor.resolveWith((states){
      return states.contains(WidgetState.selected) ? AppColors.primary : Colors.white;
    }),
    hourMinuteTextColor: WidgetStateColor.resolveWith((states) {
      return states.contains(WidgetState.selected)
          ? Colors.white
          : AppColors.primary;
    }),
    dayPeriodColor: WidgetStateColor.resolveWith((states) {
      return states.contains(WidgetState.selected)
          ? AppColors.primary
          : Colors.white;
    }),
    dayPeriodTextColor: WidgetStateColor.resolveWith((states) {
      return states.contains(WidgetState.selected)
          ? Colors.white
          : AppColors.primary;
    }),
    backgroundColor: Colors.white,
    dialHandColor: AppColors.primary,
    helpTextStyle: TextStyle(color: Colors.white),

  );
}