import 'package:e_learning_app/core/constant/icons.dart';
import 'package:e_learning_app/src/features/profile/data/models/sent_request_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../../../../../core/services/api_services/api_end_points.dart';
import '../../../../../../../core/theme/theme_part/app_colors.dart';

class SentRequestCard extends StatelessWidget {
  const SentRequestCard({
    super.key,
    required this.textTheme,
    required this.sendRequest,
  });

  final SendRequest sendRequest;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipOval(
                child:
                sendRequest.image != null && sendRequest.image!.isNotEmpty
                    ? Image.network(
                  '${ApiEndPoints.baseUrl}/uploads/${sendRequest.image!}',
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
              Spacer(),
              CircleAvatar(
                backgroundColor: AppColors.secondaryStrokeColor,
                child: Icon(Icons.close),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            sendRequest.name,
            style: textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5.h),
          Text(
            sendRequest.description,
            style: textTheme.bodyMedium!.copyWith(
              color: AppColors.secondaryTextColor,
            ),
          ),
          SizedBox(height: 5.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.w,
            children: [
              SvgPicture.asset(AppIcons.calender),
              Text(
                DateFormat('dd/MM/yyyy, hh:mm a').format(DateTime.parse(sendRequest.date.toString())),
                style: textTheme.bodyMedium!.copyWith(
                  color: AppColors.secondaryTextColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
