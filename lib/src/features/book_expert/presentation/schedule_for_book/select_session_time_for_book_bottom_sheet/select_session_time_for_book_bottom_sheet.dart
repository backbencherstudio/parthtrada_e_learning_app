import 'package:e_learning_app/core/utils/common_widget.dart';
import 'package:e_learning_app/core/utils/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../../../core/constant/padding.dart';
import '../../../../../../core/theme/theme_part/app_colors.dart';
import '../../../../horizontal_list_view_calendar/presentation/horizontal_list_calendar.dart';
import '../../../rvierpod/book_expert_riverpod.dart';
import '../../../rvierpod/session_provider.dart';
import '../answer_session_details_for_book/answer_session_details_for_book_bottomsheet.dart';
import 'session_grid_view.dart';

Future<void> selectSessionTimeForBook({
  required BuildContext context,
  required List<String> availableTime,
  required List<String> availableDays,
  required WidgetRef ref,
}) async {
  await showModalBottomSheet(
    backgroundColor: Colors.transparent,
    useSafeArea: true,
    isScrollControlled: true,
    context: context,
    builder: (bottomSheetContext) {
      return Container(
        constraints: BoxConstraints(minHeight: 590.h, maxHeight: MediaQuery.of(bottomSheetContext).size.height * 0.9),
        decoration: BoxDecoration(
          color: AppColors.screenBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32.r),
            topRight: Radius.circular(32.r),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 32.h),
              HorizontalListCalendar(
                headerPadding: AppPadding.screenHorizontal,
                availableDays: availableDays,
                onTap: (value) {
                  final formattedDate = DateFormat('yyyy-MM-dd').format(value);
                  ref.read(sessionDataProvider.notifier).setDate(formattedDate);
                },
              ),
              SizedBox(height: 34.h),
              Padding(
                padding: AppPadding.screenHorizontal,
                child: Consumer(
                  builder: (_, ref, __) {
                    final bookExpertState = ref.watch(bookExpertRiverpod(availableTime));
                    final bookExpertNotifier = ref.read(bookExpertRiverpod(availableTime).notifier);
                    return SessionGridView(
                      isMorningShift: true,
                      state: bookExpertState,
                      stateNotifier: bookExpertNotifier,
                      heading: "Morning Session",
                      sessions: bookExpertNotifier.morningSessionTimeList,
                    );
                  },
                ),
              ),
              SizedBox(height: 34.h),
              Padding(
                padding: AppPadding.screenHorizontal,
                child: Consumer(
                  builder: (_, ref, __) {
                    final bookExpertState = ref.watch(bookExpertRiverpod(availableTime));
                    final bookExpertNotifier = ref.read(bookExpertRiverpod(availableTime).notifier);
                    return SessionGridView(
                      state: bookExpertState,
                      stateNotifier: bookExpertNotifier,
                      heading: "Afternoon Session",
                      sessions: bookExpertNotifier.afternoonSessionTimeList,
                      isMorningShift: false,
                    );
                  },
                ),
              ),
              SizedBox(height: 34.h),
              Padding(
                padding: AppPadding.screenHorizontal,
                child: SafeArea(
                  child: Row(
                    children: [
                      Expanded(
                        child: CommonWidget.primaryButton(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          backgroundColor: AppColors.secondaryStrokeColor,
                          context: bottomSheetContext,
                          onPressed: () => bottomSheetContext.pop(),
                          text: "Cancel",
                          textStyle: Theme.of(bottomSheetContext).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Consumer(
                          builder: (context, ref, _) {
                            final sessionData = ref.watch(sessionDataProvider);
                            final hasSelectedDate = sessionData.date.isNotEmpty;
                            final hasSelectedTime = sessionData.time.isNotEmpty;
                            return CommonWidget.primaryButton(
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              context: bottomSheetContext,
                              onPressed: () {
                                if (!hasSelectedDate || !hasSelectedTime) {
                                  showCustomSnackBar(context, "Please select both date and time.", bgColor: AppColors.error);
                                  return;
                                }
                                Future.microtask(() async {
                                  bottomSheetContext.pop();
                                  await Future.delayed(const Duration(milliseconds: 200));
                                  if (bottomSheetContext.mounted) {
                                    await answerSessionDetailsForBook(
                                      context: bottomSheetContext,
                                      availableTime: availableTime,
                                      ref: ref,
                                      sessionDataNotifier: ref.read(sessionDataProvider.notifier),
                                    );
                                  }
                                });
                              },
                              text: "Next",
                              backgroundColor: hasSelectedDate && hasSelectedTime
                                  ? AppColors.primary
                                  : AppColors.secondaryStrokeColor,
                              textStyle: Theme.of(bottomSheetContext).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: hasSelectedDate && hasSelectedTime ? Colors.white : Colors.grey,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 28.h),
            ],
          ),
        ),
      );
    },
  );
}