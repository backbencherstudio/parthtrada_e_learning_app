import 'package:e_learning_app/src/features/book_expert/presentation/schedule_for_book/select_session_time_for_book_bottom_sheet/select_session_time_for_book_bottom_sheet.dart';
import 'package:flutter/material.dart';

Future<void> scheduleForBook({required BuildContext context}) async {
  await selectSessionTimeForBook(context: context);
}
