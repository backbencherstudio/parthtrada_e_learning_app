import 'package:e_learning_app/core/constant/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../../core/theme/theme_part/app_colors.dart';

class SentRequestCard extends StatelessWidget {
  const SentRequestCard({
    super.key,
    required this.textTheme,
  });

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
                child: SizedBox(
                  height: 56.w,
                  width: 56.w,
                  child: Image.network(
                    'https://randomuser.me/api/portraits/men/32.jpg',
                    fit: BoxFit.cover,
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
            'David Kim',
            style: textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            'Senior Data Scientist at Google',
            style: textTheme.bodyMedium!.copyWith(
              color: AppColors.onSurfaceTextColor,
            ),
          ),
          SizedBox(height: 5.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.w,
            children: [
              SvgPicture.asset(AppIcons.calender),
              Text(
                'June 1 Monday 02:00 PM',
                style: textTheme.bodyMedium!.copyWith(
                  color: AppColors.onSurfaceTextColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}