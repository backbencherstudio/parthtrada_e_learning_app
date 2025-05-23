import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../riverpod/horizontal_list_calendar_riverpod.dart';

class HorizontalListCalendarBody extends ConsumerWidget {
  final Function(DateTime time) onTap;
  final EdgeInsets? bodyPadding;
  const HorizontalListCalendarBody({super.key, required this.onTap,  this.bodyPadding});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final horizontalListCalendarState = ref.watch(
      horizontalListCalendarRiverpodProvider,
    );
    final horizontalListCalendarNotifier = ref.watch(
      horizontalListCalendarRiverpodProvider.notifier,
    );
    final textTheme = Theme.of(context).textTheme;

    WidgetsBinding.instance.addPostFrameCallback((_) => horizontalListCalendarNotifier.scrollToCurrentDate());

    return ListView.builder(
      itemCount: horizontalListCalendarNotifier.daysInMonth.length,
      scrollDirection: Axis.horizontal,
      padding: bodyPadding ?? EdgeInsets.symmetric(horizontal: 10.w),
      controller: horizontalListCalendarNotifier.calendarScrollController,
      itemBuilder: (_, index) {
        final date = horizontalListCalendarNotifier.daysInMonth[index];
        bool isToday =
            date.day == DateTime.now().day &&
            date.month == DateTime.now().month &&
            date.year == DateTime.now().year;
        bool isSelectedDay = date == horizontalListCalendarState.selectedDate;
        return GestureDetector(
          onTap: () {
            horizontalListCalendarNotifier.onSelectDate(index: index, onTap: onTap);

          },
          child: Container(
            width: 47.w,
            height: 68.w,
            margin: EdgeInsets.only(right: 4.w),
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color:
                  isToday
                      ? AppColors.primary.withValues(alpha: 0.1)
                      : Colors.transparent,
              border: Border.all(
                color: isToday && isSelectedDay ? Colors.transparent : isSelectedDay ? AppColors.primary : Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),

            child: Column(
              children: [
                /// day of month
                Text(
                  date.day.toString(),
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isToday ? AppColors.primary : Color(0xffD2D2D5),
                  ),
                ),

                SizedBox(height: 2.h),

                /// day of week
                Expanded(
                  child: Text(
                    DateFormat.E().format(date),

                    style: textTheme.bodySmall?.copyWith(
                      color:
                          isToday
                              ? AppColors.primary
                              : AppColors.secondaryTextColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
