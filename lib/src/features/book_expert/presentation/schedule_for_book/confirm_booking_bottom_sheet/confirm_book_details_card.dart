import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/theme/theme_part/app_colors.dart';

class ConfirmBookDetailsCard extends StatelessWidget{
  const ConfirmBookDetailsCard({super.key});


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return   Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: AppColors.surface,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 8.h,
        children: [
          Text("Booking Summary",style: textTheme.titleMedium,),
          SizedBox(height: 4.h,),
          /// Expert Name
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Expert:",style: textTheme.bodyMedium?.copyWith(color: AppColors.secondaryTextColor),),
              Text("Sarah Chen",style: textTheme.bodyMedium,),
            ],
          ),

          /// Request Date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Time:",style: textTheme.bodyMedium?.copyWith(color: AppColors.secondaryTextColor),),
              Text("Wed 10am",style: textTheme.bodyMedium,),
            ],
          ),

          /// Session Fee
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Session Fee",style: textTheme.bodyMedium?.copyWith(color: AppColors.secondaryTextColor),),
              Text("\$150/hour",style: textTheme.bodyMedium,),
            ],
          ),

          /// Duration
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Duration:",style: textTheme.bodyMedium?.copyWith(color: AppColors.secondaryTextColor),),
              Text("30 min",style: textTheme.bodyMedium,),
            ],
          ),

          Divider(),

          /// Total Payment
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total Payment:",style: textTheme.bodyMedium?.copyWith(color: AppColors.secondaryTextColor),),
              Text("\$75",style: textTheme.bodyMedium,),
            ],
          ),
        ],
      ),
    );
  }
}