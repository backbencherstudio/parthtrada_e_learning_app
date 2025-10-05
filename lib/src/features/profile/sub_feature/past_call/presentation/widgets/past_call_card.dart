import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../data/models/past_call_response_model.dart';

class PastCallCard extends StatelessWidget {
  const PastCallCard({super.key, required this.pastCall});

  final PastCall pastCall;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pastCall.name,
                style: textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                '${pastCall.duration} Min',
                style: textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(height: 2.h),

              Text(
                DateFormat('dd/MM/yyyy, hh:mm a').format(DateTime.parse(pastCall.date.toString())),
                style: textTheme.labelSmall!.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Text(
            '- \$${pastCall.amount}',
            style: textTheme.labelMedium!.copyWith(
              color: AppColors.error,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
