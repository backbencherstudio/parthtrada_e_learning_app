import 'package:e_learning_app/core/constant/icons.dart';
import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:e_learning_app/core/utils/common_widget.dart';
import 'package:e_learning_app/core/utils/utils.dart';
import 'package:e_learning_app/src/features/schedule/model/meeting_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ScheduleShowContainer extends StatelessWidget {
  final MeetingScheduleModel meetingScheduleModel;

  const ScheduleShowContainer({super.key, required this.meetingScheduleModel});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final buttonTextStyle = textTheme.bodySmall?.copyWith(
      fontWeight: FontWeight.w800,
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 16.h),
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: Utils.commonBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipOval(
            child: Image.asset(
              meetingScheduleModel.profilePicture,
              width: 55.w,
              height: 55.w,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(height: 16.h),

          Text(meetingScheduleModel.userName, style: textTheme.titleMedium),

          SizedBox(height: 4.h),

          Text(
            meetingScheduleModel.designation,
            style: textTheme.bodyMedium?.copyWith(
              color: AppColors.secondaryTextColor,
            ),
          ),

          SizedBox(height: 4.h),

          meetingScheduleModel.status != "canceled"
              ?
          Column(
                spacing: 12.h,
                children: [
                  Row(
                    spacing: 8.w,
                    children: [
                      SvgPicture.asset(AppIcons.calendar),
                      Text(
                        meetingScheduleModel.scheduleDate,
                        style: textTheme.bodyMedium?.copyWith(
                          color: AppColors.secondaryTextColor,
                        ),
                      ),
                      Spacer(),
                      if (meetingScheduleModel.status == "completed")
                        Text(
                          "30 Min",
                          style: textTheme.labelMedium?.copyWith(
                            color: Color(0xffD2D2D5),
                          ),
                        ),
                    ],
                  ),

                  meetingScheduleModel.status != "completed"
                      ? Row(
                        spacing: 8.w,
                        children: [
                          Expanded(
                            child: CommonWidget.primaryButton(
                              textStyle: buttonTextStyle,
                              context: context,
                              onPressed: () {},
                              text: "Cancel",
                              backgroundColor: Color(0xff2B2C31),
                            ),
                          ),
                          Expanded(
                            child: CommonWidget.primaryButton(
                              backgroundColor:
                                  meetingScheduleModel.status == "pending"
                                      ? Color(0xff4A4C56)
                                      : AppColors.primary,
                              textStyle: buttonTextStyle?.copyWith(
                                color:
                                    meetingScheduleModel.status == "pending"
                                        ? Color(0xffA5A5AB)
                                        : Colors.white,
                              ),
                              context: context,
                              onPressed: () {},
                              text: "Copy Link",
                            ),
                          ),
                        ],
                      )
                      : SizedBox(
                        width: double.infinity,
                        child: CommonWidget.primaryButton(
                          backgroundColor: Color(0xff2B2C31),
                          context: context,
                          onPressed: () {},
                          text: "View Summary",
                          textStyle: buttonTextStyle,
                        ),
                      ),
                ],
              )
              :
          Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 12.h,
                children: [
                  Text(
                    "Cancelled The Meeting",
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.error,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: CommonWidget.primaryButton(
                      context: context,
                      onPressed: () {},
                      text: "Refund",
                      textStyle: buttonTextStyle,
                      backgroundColor: AppColors.error,
                    ),
                  ),
                ],
              ),
        ],
      ),
    );
  }
}
