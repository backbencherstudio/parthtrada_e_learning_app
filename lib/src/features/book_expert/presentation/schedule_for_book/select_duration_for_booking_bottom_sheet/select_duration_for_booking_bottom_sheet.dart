import 'package:e_learning_app/core/constant/padding.dart';
import 'package:e_learning_app/core/utils/common_widget.dart';
import 'package:e_learning_app/core/utils/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/theme/theme_part/app_colors.dart';
import '../../../rvierpod/book_expert_riverpod.dart';
import '../../../rvierpod/booking_response_provider.dart';
import '../../../rvierpod/payment_provider.dart';
import '../../../rvierpod/session_provider.dart';
import '../confirm_booking_bottom_sheet/confirm_booking_bottom_sheet.dart';

Future<void> selectSessionDurationForBook({
  required BuildContext context,
  required List<String> availableTime,
}) async {
  await showModalBottomSheet(
    backgroundColor: Colors.transparent,
    useSafeArea: true,
    isScrollControlled: true,
    context: context,
    builder: (bottomSheetContext) {
      final textTheme = Theme.of(bottomSheetContext).textTheme;
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
                builder: (_, ref, __) {
                  final bookExpertState = ref.watch(bookExpertRiverpod(availableTime));
                  final bookExpertNotifier = ref.read(bookExpertRiverpod(availableTime).notifier);

                  return ListView.builder(
                    itemCount: bookExpertNotifier.sessionDurationList.length,
                    itemBuilder: (_, index) {
                      final sessionDuration = bookExpertNotifier.sessionDurationList[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 8.h),
                        decoration: BoxDecoration(
                          color: index == bookExpertState.selectedDuration
                              ? AppColors.primary
                              : AppColors.surface,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: RadioListTile(
                          value: index,
                          groupValue: bookExpertState.selectedDuration,
                          onChanged: (value) {
                            bookExpertNotifier.onSelectDurationTile(index: index);
                          },
                          title: Text(sessionDuration, style: textTheme.bodyMedium),
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
                children: [
                  Expanded(
                    child: CommonWidget.primaryButton(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      textStyle: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                      context: bottomSheetContext,
                      onPressed: () => bottomSheetContext.pop(),
                      text: "Cancel",
                      backgroundColor: AppColors.secondaryStrokeColor,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Consumer(
                      builder: (_, ref, __) {
                        final bookExpertState = ref.watch(bookExpertRiverpod(availableTime));
                        final bookExpertNotifier = ref.read(bookExpertRiverpod(availableTime).notifier);

                        return CommonWidget.primaryButton(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          textStyle: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                          context: bottomSheetContext,
                          onPressed: bookExpertState.selectedDuration == null || bookExpertState.isConfirmLoading
                              ? () {}
                              : () async {
                            try {
                              final selectedIndex = bookExpertState.selectedDuration!;
                              final selectedDurationStr =
                              bookExpertNotifier.sessionDurationList[selectedIndex];
                              int durationInMinutes = 0;
                              if (selectedDurationStr.toLowerCase().contains("hour")) {
                                double hourValue =
                                    double.tryParse(selectedDurationStr.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;
                                durationInMinutes = (hourValue * 60).toInt();
                              } else {
                                durationInMinutes =
                                    int.tryParse(selectedDurationStr.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
                              }

                              ref.read(sessionDataProvider.notifier).setSessionDuration(durationInMinutes);

                              // Call Riverpod function that sets isConfirmLoading
                              await bookExpertNotifier.onConfirmBooking();

                              // Continue your booking logic
                              final sessionData = ref.read(sessionDataProvider);
                              final res = await ref.read(bookingResponseProvider(sessionData).future);

                              if (res.success == true && bottomSheetContext.mounted) {
                                ref.read(paymentIntentIdProvider.notifier).state = res.data.paymentIntentId;
                                bottomSheetContext.pop();

                                await Future.delayed(const Duration(milliseconds: 200));
                                if (bottomSheetContext.mounted) {
                                  await confirmAndPayBottomSheet(
                                    context: bottomSheetContext,
                                    availableTime: availableTime,
                                  );
                                }
                              } else if (bottomSheetContext.mounted) {
                                showCustomSnackBar(context, "Booking failed: ${res.message ?? 'Please try again.'}");
                              }
                            } catch (e) {
                              if (bottomSheetContext.mounted) {
                                showCustomSnackBar(context, "Error: $e");
                              }
                            }
                          },
                          text: bookExpertState.isConfirmLoading ? "Booking..." : "Next",
                          backgroundColor: bookExpertState.selectedDuration == null
                              ? AppColors.secondaryStrokeColor
                              : AppColors.primary,
                        );
                      },
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
