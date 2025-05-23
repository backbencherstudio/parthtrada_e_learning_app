import 'package:e_learning_app/core/constant/padding.dart';
import 'package:e_learning_app/src/features/book_expert/presentation/schedule_for_book/select_session_time_for_book_bottom_sheet/select_session_time_for_book_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/theme_part/app_colors.dart';
import '../../../horizontal_list_view_calendar/presentation/horizontal_list_calendar.dart';

Future<void> scheduleForBook({required BuildContext context}) async {
  await selectSessionTimeForBook(context: context);
}
