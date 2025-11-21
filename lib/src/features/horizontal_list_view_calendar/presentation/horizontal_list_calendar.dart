import 'package:e_learning_app/src/features/horizontal_list_view_calendar/presentation/widgets/horizontal_list_calendar_body.dart';
import 'package:e_learning_app/src/features/horizontal_list_view_calendar/presentation/widgets/horizontal_list_calendar_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HorizontalListCalendar extends StatelessWidget{
  final Function(DateTime time) onTap;
  final EdgeInsets? headerPadding;
  final EdgeInsets? bodyPadding;
  final List<String> availableDays;
  const HorizontalListCalendar({super.key, required this.onTap, this.headerPadding, this.bodyPadding, required this.availableDays});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 24.h,
      children: [
        /// Header of the calendar
        HorizontalListCalendarHeader(headerPadding: headerPadding, availableDays: availableDays, ),

        SizedBox(
          height: 70.h,
          child: HorizontalListCalendarBody(onTap: onTap, availableDays: availableDays,),
        )

      ],
    );
  }
}