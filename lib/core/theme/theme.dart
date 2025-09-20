import 'package:e_learning_app/core/theme/theme_extension/app_bar_theme.dart';
import 'package:e_learning_app/core/theme/theme_extension/date_picker_theme.dart';
import 'package:e_learning_app/core/theme/theme_extension/elevated_button_theme.dart';
import 'package:e_learning_app/core/theme/theme_extension/input_decoration_theme.dart';
import 'package:e_learning_app/core/theme/theme_extension/time_picker_theme.dart';
import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:e_learning_app/core/theme/theme_part/text_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    inputDecorationTheme: AppInputDecorationTheme.inputDecorationTheme,
    scaffoldBackgroundColor: AppColors.screenBackgroundColor,
    appBarTheme: AppAppBarTheme.darkAppBarTheme,
    elevatedButtonTheme: AppEvaluatedButtonThemes.evaluatedButtonTheme,
    textTheme: AppTextTheme.darkTextTheme,
    colorScheme: AppColors.darkColorScheme,
    timePickerTheme: CustomTimePickerTheme.timePickerTheme,
    datePickerTheme:CustomDatePickerTheme.datePickerTheme,
  );

}
