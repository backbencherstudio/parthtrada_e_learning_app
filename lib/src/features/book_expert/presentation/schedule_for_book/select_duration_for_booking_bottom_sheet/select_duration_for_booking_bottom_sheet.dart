import 'package:e_learning_app/core/constant/padding.dart';
import 'package:e_learning_app/core/utils/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/theme/theme_part/app_colors.dart';
import '../../../rvierpod/book_expert_riverpod.dart';
import '../confirm_booking_bottom_sheet/confirm_booking_bottom_sheet.dart';

Future<void> selectSessionTimeForBook({required BuildContext context}) async {
  await showModalBottomSheet(
    backgroundColor: Colors.transparent,
    useSafeArea: false,
    isScrollControlled: true,
    context: context,
    builder: (_) {
      final textTheme = Theme.of(context).textTheme;

      return Container(
        constraints: BoxConstraints(maxHeight: 440.h),
        padding: AppPadding.screenHorizontal,
        decoration: BoxDecoration(
          color: AppColors.screenBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32.r),
            topRight: Radius.circular(32.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 32.h),
            Text("Session Duration", style: textTheme.headlineSmall),
            SizedBox(height: 12.h),
            Expanded(
              child: Consumer(
                builder: (_, ref, _) {
                  final bookExpertState = ref.watch(bookExpertRiverpod);
                  final bookExpertNotifier = ref.watch(
                    bookExpertRiverpod.notifier,
                  );
                  return ListView.builder(
                    itemCount: bookExpertNotifier.sessionDurationList.length,
                    itemBuilder: (_, index) {
                      final sessionDuration =
                          bookExpertNotifier.sessionDurationList[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 8.h),
                        decoration: BoxDecoration(
                          color:
                              index == bookExpertState.selectedDuration
                                  ? AppColors.primary
                                  : AppColors.surface,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: RadioListTile(

                          value: index,
                          groupValue: bookExpertState.selectedDuration,

                          onChanged: (value) {
                            bookExpertNotifier.onSelectDurationTile(
                              index: index,
                            );
                          },

                          title: Text(
                            sessionDuration,
                            style: textTheme.bodyMedium,
                          ),
                          activeColor: Colors.white,
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            SizedBox(height: 32.h),

            SafeArea(
              child: Row(
                spacing: 10.w,
                children: [
                  Expanded(
                    child: CommonWidget.primaryButton(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      textStyle: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                      context: context,
                      onPressed: () {
                        context.pop();
                      },
                      text: "Cancel",
                      backgroundColor: AppColors.secondaryStrokeColor,
                    ),
                  ),

                  Expanded(
                    child: Consumer(
                      builder: (_, ref, _) {
                        return CommonWidget.primaryButton(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          textStyle: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                          context: context,
                          onPressed: () {
                            context.pop();
                            ref.read(bookExpertRiverpod.notifier).onCancelBooking();
                            confirmBookingBottomSheet(context: context);
                          },
                          text: "Next",
                        );
                      }
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 28.h),
          ],
        ),
      );
    },
  );
}
