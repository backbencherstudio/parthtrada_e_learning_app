import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../core/theme/theme_part/app_colors.dart';
import '../../riverpod/horizontal_list_calendar_riverpod.dart';

class HorizontalListCalendarBody extends ConsumerWidget {
  final Function(DateTime time) onTap;
  final EdgeInsets? bodyPadding;
  final List<String> availableDays;

  const HorizontalListCalendarBody({
    super.key,
    required this.onTap,
    this.bodyPadding,
    required this.availableDays,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = horizontalListCalendarRiverpodProvider(availableDays);

    final horizontalListCalendarState = ref.watch(provider);

    final horizontalListCalendarNotifier = ref.read(provider.notifier);

    final textTheme = Theme.of(context).textTheme;

    WidgetsBinding.instance.addPostFrameCallback(
          (_) => horizontalListCalendarNotifier.scrollToCurrentDate(),
    );
    
    if (horizontalListCalendarNotifier.daysInMonth.isEmpty) {
      return Text('No Available Date Found');
    }

    return ListView.builder(
      itemCount: horizontalListCalendarNotifier.daysInMonth.length,
      scrollDirection: Axis.horizontal,
      padding: bodyPadding ?? EdgeInsets.symmetric(horizontal: 10.w),
      controller: horizontalListCalendarNotifier.calendarScrollController,
      itemBuilder: (_, index) {
        final date = horizontalListCalendarNotifier.daysInMonth[index];
        // bool isToday =
        //     date.day == DateTime.now().day &&
        //         date.month == DateTime.now().month &&
        //         date.year == DateTime.now().year;
        bool isSelectedDay = date == horizontalListCalendarState.selectedDate;
        return GestureDetector(
          onTap: () {
            horizontalListCalendarNotifier.onSelectDate(
              index: index,
              onTap: onTap,
            );
          },
          child: Container(
            width: 47.w,
            height: 68.w,
            margin: EdgeInsets.only(right: 4.w),
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color:
              isSelectedDay
                  ? AppColors.primary.withOpacity(0.1)
                  : Colors.transparent,
              border: Border.all(
                color:
                // isToday && isSelectedDay
                isSelectedDay
                    // ? Colors.transparent
                    // : isSelectedDay
                    ? AppColors.primary
                    : Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                Text(
                  date.day.toString(),
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color:
                    isSelectedDay ? AppColors.primary : const Color(0xffD2D2D5),
                  ),
                ),
                SizedBox(height: 2.h),
                Expanded(
                  child: Text(
                    DateFormat.E().format(date),
                    textAlign: TextAlign.center,
                    style: textTheme.bodySmall?.copyWith(
                      color:
                      isSelectedDay
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
