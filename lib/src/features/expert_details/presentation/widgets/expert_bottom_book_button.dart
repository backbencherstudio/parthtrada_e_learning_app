import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/theme_part/app_colors.dart';
import '../../../../../core/utils/common_widget.dart';
import '../../../book_expert/presentation/schedule_for_book/schedule_for_book.dart';
import '../../../book_expert/rvierpod/session_provider.dart';

class ExpertDetailsBottomBookButton extends ConsumerWidget{
  const ExpertDetailsBottomBookButton({super.key, required this.username, required this.userId, required this.hourlyRate, required this.availableTime, required this.availableDays});

  final String userId;
  final String username;
  final String hourlyRate;
  final List<String> availableTime;
  final List<String> availableDays;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.only(left: 24.w,right: 24.w,bottom: 16.h,top: 16.h),
      decoration: BoxDecoration(
          color: AppColors.secondary
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: CommonWidget.primaryButton(
              padding: EdgeInsets.all(16.r),
              context: context,
              onPressed: (){
                debugPrint("\nExpert\n");
                final sessionDataNotifier = ref.read(sessionDataProvider.notifier);
                sessionDataNotifier.setExpertId(userId);
                sessionDataNotifier.setExpertName(username);
                sessionDataNotifier.setHourlyRate(hourlyRate);
                scheduleForBook(ref: ref, context: context, availableTime: availableTime, availableDays: availableDays);
              },
              text: "Book \$$hourlyRate/hour"),
        ),
      ),
    );
  }
}