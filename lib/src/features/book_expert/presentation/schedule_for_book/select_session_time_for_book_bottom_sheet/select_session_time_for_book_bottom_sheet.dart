import 'package:e_learning_app/core/utils/common_widget.dart';
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

Future<void> selectSessionTimeForBook({required BuildContext context, required List<String> availableTime, required List<String> availableDays, required WidgetRef ref}) async {
  await showModalBottomSheet(
    backgroundColor: Colors.transparent,
    useSafeArea: false,
    isScrollControlled: true,
    context: context,
    builder: (_) {
      return Container(
        //padding: AppPadding.screenHorizontal,
        constraints: BoxConstraints(minHeight: 590.h),
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
                  final sessionDataNotifier = ref.read(sessionDataProvider.notifier);
                  sessionDataNotifier.setDate(formattedDate);
                },
              ),

              SizedBox(height: 34.h),
              Padding(
                padding: AppPadding.screenHorizontal,
                child: Consumer(
                  builder: (_, ref, _) {
                    final bookExpertState = ref.watch(bookExpertRiverpod(availableTime));
                    final bookExpertNotifier = ref.watch(
                      bookExpertRiverpod(availableTime).notifier,
                    );
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
                  builder: (_, ref, _) {
                    final bookExpertState = ref.watch(bookExpertRiverpod(availableTime));
                    final bookExpertNotifier = ref.watch(
                      bookExpertRiverpod(availableTime).notifier,
                    );
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
                      // Expanded(
                      //   child: CommonWidget.primaryButton(
                      //     padding: EdgeInsets.symmetric(vertical: 16.h),
                      //     backgroundColor: AppColors.secondaryStrokeColor,
                      //     context: context,
                      //     onPressed: () {
                      //       context.pop();
                      //     },
                      //     text: "Cancel",
                      //
                      //     textStyle: Theme.of(context).textTheme.titleMedium
                      //         ?.copyWith(fontWeight: FontWeight.w700),
                      //   ),
                      // ),
                      Expanded(
                        child: Consumer(
                          builder: (context, ref, _) {
                            final sessionData = ref.watch(sessionDataProvider);
                            final hasSelectedDate = sessionData.date.isNotEmpty;
                            final hasSelectedTime = sessionData.time.isNotEmpty;

                            return CommonWidget.primaryButton(
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              context: context,
                              onPressed: () async {
                                debugPrint("Next button pressed");
                                debugPrint("Date: ${sessionData.date}, Time: ${sessionData.time}");

                                if (!hasSelectedDate || !hasSelectedTime) {
                                  debugPrint("Date or Time not selected");
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Please select both date and time."),
                                      backgroundColor: Colors.redAccent,
                                    ),
                                  );
                                  return;
                                }

                                context.pop();
                                await answerSessionDetailsForBook(
                                  context: context,
                                  availableTime: availableTime,
                                  ref: ref,
                                  sessionDataNotifier: ref.read(sessionDataProvider.notifier),
                                );
                              },
                              text: "Next",
                              backgroundColor: hasSelectedDate && hasSelectedTime
                                  ? AppColors.primary
                                  : AppColors.secondaryStrokeColor,
                              textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: hasSelectedDate && hasSelectedTime
                                    ? Colors.white
                                    : Colors.grey,
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
