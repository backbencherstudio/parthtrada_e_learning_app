import 'package:e_learning_app/src/features/book_expert/presentation/schedule_for_book/select_session_time_for_book_bottom_sheet/select_session_time_for_book_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


Future<void> scheduleForBook({required BuildContext context, required List<String> availableTime, required List<String> availableDays, required WidgetRef ref}) async {
  await selectSessionTimeForBook(context: context, availableTime: availableTime, availableDays: availableDays, ref: ref);
}
