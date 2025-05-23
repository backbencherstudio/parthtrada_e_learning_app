import 'package:e_learning_app/core/constant/icons.dart';
import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:e_learning_app/core/utils/common_widget.dart';
import 'package:e_learning_app/core/utils/utils.dart';
import 'package:e_learning_app/src/features/schedule/model/meeting_model.dart';
import 'package:e_learning_app/src/features/schedule/presentation/widgets/schedule_show_container_footer.dart';
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
          /// Profile Picture
          ClipOval(
            child: Image.asset(
              meetingScheduleModel.profilePicture,
              width: 55.w,
              height: 55.w,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(height: 16.h),

          /// User Name
          Text(meetingScheduleModel.userName, style: textTheme.titleMedium),

          SizedBox(height: 4.h),

          /// Designation
          Text(
            meetingScheduleModel.designation,
            style: textTheme.bodyMedium?.copyWith(
              color: AppColors.secondaryTextColor,
            ),
          ),

          SizedBox(height: 4.h),

          ScheduleShowContainerFooter(
            meetingScheduleModel: meetingScheduleModel,
          ),
        ],
      ),
    );
  }
}
