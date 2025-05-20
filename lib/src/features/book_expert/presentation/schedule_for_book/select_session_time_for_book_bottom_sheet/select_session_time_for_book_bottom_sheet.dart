import 'package:e_learning_app/core/utils/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/constant/padding.dart';
import '../../../../../../core/theme/theme_part/app_colors.dart';
import '../../../../horizontal_list_view_calendar/presentation/horizontal_list_calendar.dart';
import 'session_grid_view.dart';

Future<void> selectSessionTimeForBook({required BuildContext context}) async {
  await showModalBottomSheet(
    backgroundColor: Colors.transparent,
    useSafeArea: false,
    isScrollControlled: true,
    context: context,
    builder: (context) {
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
                onTap: (value) {
                  debugPrint("\n\n${value.toString()}\n\n");
                },
              ),

              SizedBox(height: 34.h,),
              Padding(
                padding: AppPadding.screenHorizontal,
                child: SessionGridView(
                  heading: "Morning Session",
                  sessions: [
                    "08:00 AM",
                    "08:30 AM",
                    "09:00 AM",
                    "09:30 AM",
                    "10:00 AM",
                    "10:30 AM",
                    "11:00 AM",
                    "11:30 AM",
                  ],
                ),
              ),

              SizedBox(height: 34.h,),
              Padding(
                padding: AppPadding.screenHorizontal,
                child: SessionGridView(
                  heading: "Afternoon Session",
                  sessions: [
                    "08:00 AM",
                    "08:30 AM",
                    "09:00 AM",
                    "09:30 AM",
                    "10:00 AM",
                    "10:30 AM",
                    "11:00 AM",
                    "11:30 AM",
                  ],
                ),
              ),


              SizedBox(height: 34.h,),

              Padding(
                padding: AppPadding.screenHorizontal,
                child: Row(
                  spacing: 10.w,
                  children: [
                    Expanded(child: CommonWidget.primaryButton(
                        backgroundColor: AppColors.secondary,
                        context: context, onPressed: (){
                          context.pop();
                    }, text: "Cancel",

                    textStyle: Theme.of(context).textTheme.titleMedium,
                    ),
                    ),
                    Expanded(child: CommonWidget.primaryButton(context: context, onPressed: (){
                      context.pop();
                    }, text: "Next",
                      textStyle: Theme.of(context).textTheme.titleMedium,
                    ),),
                  ],
                ),
              ),

              SizedBox(height: 28.h,),

            ],
          ),
        ),
      );
    },
  );
}