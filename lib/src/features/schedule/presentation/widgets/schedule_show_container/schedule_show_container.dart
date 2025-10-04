import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:e_learning_app/core/utils/utils.dart';
import 'package:e_learning_app/src/features/book_expert/model/booking_response.dart';
import 'package:e_learning_app/src/features/schedule/model/schedule_meeting_model.dart';
import 'package:e_learning_app/src/features/schedule/presentation/widgets/schedule_show_container/schedule_show_container_footer.dart';
import 'package:e_learning_app/src/features/search/model/expert_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/services/api_services/api_end_points.dart';
import '../../../../expert_details/riverpod/expert_details_provider.dart';

class ScheduleShowContainer extends StatelessWidget {
  final Booking meetingScheduleModel;
  final String expertName;
  final String expertProfession;
  final String expertOrganization;
  final String expertImage;

  const ScheduleShowContainer({
    super.key,
    required this.meetingScheduleModel,
    required this.expertName,
    required this.expertProfession,
    required this.expertOrganization,
    required this.expertImage,
  });

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
            child:
            expertImage != null && expertImage.isNotEmpty
                ? Image.network(
              '${ApiEndPoints.baseUrl}/uploads/$expertImage',
              width: 56.w,
              height: 56.w,
              fit: BoxFit.cover,
            )
                : CircleAvatar(
              radius: 28.w,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                color: Colors.grey,
                size: 28.w,
              ),
            ),
          ),

          SizedBox(height: 16.h),

          /// User Name
          Text(expertName, style: textTheme.titleMedium),

          SizedBox(height: 4.h),

          /// Designation
          Text(
            '$expertProfession, $expertOrganization',
            style: textTheme.bodyMedium?.copyWith(
              color: AppColors.secondaryTextColor,
            ),
          ),
          SizedBox(height: 4.h),

          ScheduleShowContainerFooter(
            meetingScheduleModel: meetingScheduleModel,
          ),

          SizedBox(height: 4.h),
        ],
      ),
    );
  }
}
