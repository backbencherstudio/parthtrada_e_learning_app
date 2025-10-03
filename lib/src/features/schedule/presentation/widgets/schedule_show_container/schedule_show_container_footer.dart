import 'package:e_learning_app/src/features/schedule/model/schedule_meeting_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../../../../../core/constant/icons.dart';
import '../../../../../../core/theme/theme_part/app_colors.dart';
import '../../../../../../core/utils/common_widget.dart';
import '../add_review_bottom_sheet/add_review_bottom_sheet.dart';


class ScheduleShowContainerFooter extends StatelessWidget {
  final Booking meetingScheduleModel;

  const ScheduleShowContainerFooter({
    super.key,
    required this.meetingScheduleModel,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final buttonTextStyle = textTheme.bodySmall?.copyWith(
      fontWeight: FontWeight.w800,
    );

    return meetingScheduleModel.status != "canceled" && meetingScheduleModel.status != "no response"
        ? Column(
          spacing: 12.h,
          children: [
            Row(
              spacing: 8.w,
              children: [
                SvgPicture.asset(AppIcons.calendar),
                Text(
                  DateFormat('yyyy-MM-dd, HH:mm').format(DateTime.parse(meetingScheduleModel.date.toString())),
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.secondaryTextColor,
                  ),
                ),
                Spacer(),
                if (meetingScheduleModel.status == "COMPLETED")
                  Text(
                    "${meetingScheduleModel.sessionDuration} Min",
                    style: textTheme.labelMedium?.copyWith(
                      color: Color(0xffD2D2D5),
                    ),
                  ),
              ],
            ),

            meetingScheduleModel.status != "COMPLETED"
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
                            meetingScheduleModel.status == "PENDING"
                                ? Color(0xff4A4C56)
                                : AppColors.primary,
                        textStyle: buttonTextStyle?.copyWith(
                          color:
                              meetingScheduleModel.status == "PENDING"
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
                : Column(
                  spacing: 12.h,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: CommonWidget.primaryButton(
                        backgroundColor: Color(0xffFF7F48),
                        context: context,
                        onPressed: () async {await addReviewBottomSheet(context: context);},
                        text: "Add Review",
                        textStyle: buttonTextStyle,
                      ),
                    ),
                    SizedBox(
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
                ),
          ],
        )
        :

    Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
            Text(
             meetingScheduleModel.status == "no response" ? "No Response" : "Cancelled The Meeting",
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
        );
  }
}
