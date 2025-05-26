import 'package:e_learning_app/core/utils/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:horizontal_list_calendar/horizontal_list_calendar.dart';
import '../../../../../../core/constant/padding.dart';
import '../../../../../../core/theme/theme_part/app_colors.dart';
import '../../../../horizontal_list_view_calendar/presentation/horizontal_list_calendar.dart';
import '../../../rvierpod/book_expert_riverpod.dart';
import '../answer_session_details_for_book/answer_session_details_for_book_bottomsheet.dart';
import 'session_grid_view.dart';

Future<void> selectSessionTimeForBook({required BuildContext context}) async {
  await showModalBottomSheet(
    backgroundColor: Colors.transparent,
    useSafeArea: false,
    isScrollControlled: true,
    context: context,
    builder: (_) {
      final textTheme = Theme.of(context).textTheme;
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
                onTap: (value) => debugPrint("\n\n${value.toString()}\n\n"),
                headerTextStyle: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(
                  color: Color(0xff777980),
                  fontWeight: FontWeight.w500,
                ),
                iconSize: 14,
                moveToPreviousMonthIconBackgroundColor:
                    AppColors.secondaryStrokeColor,
                moveToPreviousMonthIconColor: Color(0xff979797),
                moveToNextMonthIconBackgroundColor: AppColors.primary,
                moveToNextMonthIconColor: Colors.white,
                todayFillColor: AppColors.primary.withValues(alpha: 0.1),
                todayTextStyle: textTheme.titleSmall!.copyWith(
                  color: AppColors.primary,
                ),
                selectedColor: AppColors.primary,
                selectedTextStyle: textTheme.bodyMedium!.copyWith(
                  color: AppColors.primary,
                ),
                unSelectedTextStyle: textTheme.bodySmall!.copyWith(
                  color: Colors.white,
                ),

                headerPadding: AppPadding.screenHorizontal,
              ),

              SizedBox(height: 34.h),
              Padding(
                padding: AppPadding.screenHorizontal,
                child: Consumer(
                  builder: (_, ref, _) {
                    final bookExpertState = ref.watch(bookExpertRiverpod);
                    final bookExpertNotifier = ref.watch(
                      bookExpertRiverpod.notifier,
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
                    final bookExpertState = ref.watch(bookExpertRiverpod);
                    final bookExpertNotifier = ref.watch(
                      bookExpertRiverpod.notifier,
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
                    spacing: 10.w,
                    children: [
                      Expanded(
                        child: CommonWidget.primaryButton(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          backgroundColor: AppColors.secondaryStrokeColor,
                          context: context,
                          onPressed: () {
                            context.pop();
                          },
                          text: "Cancel",

                          textStyle: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                      Expanded(
                        child: CommonWidget.primaryButton(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          context: context,
                          onPressed: () async {
                            context.pop();
                            await answerSessionDetailsForBook(context: context);
                          },
                          text: "Next",
                          textStyle: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
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
