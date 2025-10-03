import 'package:e_learning_app/core/constant/padding.dart';
import 'package:e_learning_app/core/utils/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/theme/theme_part/app_colors.dart';
import '../../../../../../repository/api/expert/expert_booking.dart';
import '../../../rvierpod/book_expert_riverpod.dart';
import '../../../rvierpod/booking_response_provider.dart';
import '../../../rvierpod/session_provider.dart';
import '../confirm_booking_bottom_sheet/confirm_booking_bottom_sheet.dart';

Future<void> selectSessionTimeForBook({
  required BuildContext context,
  required List<String> availableTime,
}) async {
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

            /// Duration selection list
            Expanded(
              child: Consumer(
                builder: (_, ref, __) {
                  final bookExpertState = ref.watch(
                    bookExpertRiverpod(availableTime),
                  );
                  final bookExpertNotifier = ref.watch(
                    bookExpertRiverpod(availableTime).notifier,
                  );

                  return ListView.builder(
                    itemCount: bookExpertNotifier.sessionDurationList.length,
                    itemBuilder: (_, index) {
                      final sessionDuration =
                      bookExpertNotifier.sessionDurationList[index];

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

            /// Buttons
            SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: CommonWidget.primaryButton(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      textStyle: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      context: context,
                      onPressed: () {
                        context.pop();
                      },
                      text: "Cancel",
                      backgroundColor: AppColors.secondaryStrokeColor,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Builder(
                      builder: (safeContext) {
                        final isLoading = ValueNotifier<bool>(false);

                        return Consumer(
                          builder: (_, ref, __) {
                            return ValueListenableBuilder<bool>(
                              valueListenable: isLoading,
                              builder: (context, loading, child) {
                                print('ValueListenableBuilder rebuilt, loading: $loading');

                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(vertical: 16.h),
                                    textStyle: textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                                    backgroundColor: AppColors.primary,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                  ),
                                  onPressed: loading
                                      ? null
                                      : () async {
                                    print('Next button pressed');
                                    isLoading.value = true;
                                    try {
                                      final bookExpertNotifier = ref.read(bookExpertRiverpod(availableTime).notifier);
                                      final selectedIndex = ref.read(bookExpertRiverpod(availableTime)).selectedDuration;
                                      final selectedDurationStr = bookExpertNotifier.sessionDurationList[selectedIndex];

                                      print('Selected index: $selectedIndex, duration: $selectedDurationStr'); // Debug

                                      int durationInMinutes;
                                      if (selectedDurationStr.toLowerCase().contains("hour")) {
                                        durationInMinutes = 60;
                                      } else {
                                        durationInMinutes = int.tryParse(selectedDurationStr.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
                                      }

                                      print('Duration in minutes: $durationInMinutes'); // Debug

                                      ref.read(sessionDataProvider.notifier).setSessionDuration(durationInMinutes);

                                      print('Calling onCancelBooking'); // Debug
                                      bookExpertNotifier.onCancelBooking();

                                      print('Calling onConfirmBooking'); // Debug
                                      await bookExpertNotifier.onConfirmBooking();
                                      final sessionData = ref.read(sessionDataProvider);

                                      print('Session data: $sessionData'); // Debug

                                      print('Fetching booking response'); // Debug
                                      final res = await ref.read(bookingResponseProvider(sessionData).future);

                                      print('Booking response: success=${res.success}, message=${res.message}'); // Debug

                                      if (res.success == true) {
                                        if (safeContext.mounted && Navigator.of(safeContext).canPop()) {
                                          print('Popping bottom sheet'); // Debug
                                          Navigator.of(safeContext).pop();
                                        }

                                        await Future.delayed(const Duration(milliseconds: 200));
                                        if (safeContext.mounted) {
                                          print('Showing confirmBookingBottomSheet'); // Debug
                                          confirmBookingBottomSheet(
                                            context: safeContext,
                                            availableTime: availableTime,
                                          );
                                        } else {
                                          print('safeContext not mounted for bottom sheet'); // Debug
                                        }
                                      } else {
                                        if (safeContext.mounted) {
                                          print('Showing error SnackBar'); // Debug
                                          ScaffoldMessenger.of(safeContext).showSnackBar(
                                            SnackBar(
                                              content: Text("Booking failed: ${res.message ?? 'Please try again.'}"),
                                            ),
                                          );
                                        } else {
                                          print('safeContext not mounted for error SnackBar'); // Debug
                                        }
                                      }
                                    } catch (e, stackTrace) {
                                      print('Error occurred: $e'); // Debug
                                      print('Stack trace: $stackTrace'); // Debug
                                      if (safeContext.mounted) {
                                        ScaffoldMessenger.of(safeContext).showSnackBar(
                                          SnackBar(content: Text("Error: $e")),
                                        );
                                      } else {
                                        print('safeContext not mounted for error SnackBar'); // Debug
                                      }
                                    } finally {
                                      print('Setting isLoading to false'); // Debug
                                      isLoading.value = false; // Stop loading
                                    }
                                  },
                                  child: Text(
                                    loading ? "Booking..." : "Next",
                                    style: textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white, // Adjust as needed
                                    ),
                                  ),
                                );
                              },
                            );
                          },
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