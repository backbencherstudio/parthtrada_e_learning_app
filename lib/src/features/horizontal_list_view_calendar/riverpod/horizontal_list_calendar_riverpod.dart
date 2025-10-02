import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:horizontal_list_calendar/riverpod/horizontal_list_calendar_state.dart';

final horizontalListCalendarRiverpodProvider = StateNotifierProvider
    .family<HorizontalListCalendarRiverpod, HorizontalListCalendarState, List<String>>(
      (ref, availableDays) => HorizontalListCalendarRiverpod(availableDays),
);

class HorizontalListCalendarRiverpod extends StateNotifier<HorizontalListCalendarState> {
  final List<String> availableDays;

  HorizontalListCalendarRiverpod(this.availableDays) : super(HorizontalListCalendarState()) {
    setCurrentDate();
  }

  void setCurrentDate() {
    final currentDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    state = state.copyWith(currentDate: currentDate, selectedDate: null);
  }

  final ScrollController calendarScrollController = ScrollController();

  /// Filtered list of days in current month according to availableDays
  List<DateTime> get daysInMonth {
    final allDays = _getDaysInMonth(state.currentDate!);
    return allDays.where((date) {
      // DateFormat.E() returns short day name like "Sun", "Mon", but your list has full names, so get full weekday name
      final weekdayName = _weekdayFullName(date.weekday);
      return availableDays.contains(weekdayName);
    }).toList();
  }

  List<DateTime> _getDaysInMonth(DateTime date) {
    int daysInMonth = DateTime(date.year, date.month + 1, 0).day;
    return List.generate(daysInMonth, (index) => DateTime(date.year, date.month, index + 1));
  }

  /// Helper to get full weekday name from int (1 = Monday ... 7 = Sunday)
  String _weekdayFullName(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return "Monday";
      case DateTime.tuesday:
        return "Tuesday";
      case DateTime.wednesday:
        return "Wednesday";
      case DateTime.thursday:
        return "Thursday";
      case DateTime.friday:
        return "Friday";
      case DateTime.saturday:
        return "Saturday";
      case DateTime.sunday:
        return "Sunday";
      default:
        return "";
    }
  }

  void changeMonth(int increment) {
    DateTime currentDate = DateTime(state.currentDate!.year, state.currentDate!.month + increment, 1);
    if (currentDate.month == DateTime.now().month && currentDate.year == DateTime.now().year) {
      currentDate = DateTime.now();
    }
    state = state.copyWith(currentDate: currentDate);
  }

  void scrollToCurrentDate({Duration? duration}) {
    // Since daysInMonth is filtered, find index of currentDate in filtered list
    final currentDate = state.currentDate!;
    final filteredDays = daysInMonth;
    final currentIndex = filteredDays.indexWhere((date) =>
    date.year == currentDate.year && date.month == currentDate.month && date.day == currentDate.day);

    if (currentIndex == -1) return; // current date not in available days

    double itemWidth = 51.w;
    double screenWidth = calendarScrollController.position.viewportDimension;

    double scrollTo = (currentIndex * itemWidth) - (screenWidth / 2) + (itemWidth / 2);
    calendarScrollController.animateTo(
      scrollTo.clamp(0, calendarScrollController.position.maxScrollExtent),
      duration: duration ?? const Duration(milliseconds: 600),
      curve: Curves.linear,
    );
  }

  void onSelectDate({required int index, required Function(DateTime) onTap}) {
    final selectedDate = daysInMonth[index];
    state = state.copyWith(selectedDate: selectedDate, currentDate: selectedDate);
    onTap(state.selectedDate!);
  }
}
