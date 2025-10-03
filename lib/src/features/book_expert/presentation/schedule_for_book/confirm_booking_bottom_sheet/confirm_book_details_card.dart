import 'package:e_learning_app/src/features/book_expert/model/session_model.dart';
import 'package:e_learning_app/src/features/book_expert/rvierpod/session_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/theme/theme_part/app_colors.dart';

class ConfirmBookDetailsCard extends ConsumerWidget{
  const ConfirmBookDetailsCard({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final bookingData = ref.watch(sessionDataProvider);
    return Container(
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
              Text(bookingData.expertName, style: textTheme.bodyMedium,),
            ],
          ),

          /// Request Date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Time:",style: textTheme.bodyMedium?.copyWith(color: AppColors.secondaryTextColor),),
              Text("${bookingData.date}, ${bookingData.time}",style: textTheme.bodyMedium,),
            ],
          ),

          /// Session Fee
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Session Fee",style: textTheme.bodyMedium?.copyWith(color: AppColors.secondaryTextColor),),
              Text("\$${bookingData.hourlyRate}/hour",style: textTheme.bodyMedium,),
            ],
          ),

          /// Duration
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Duration:",style: textTheme.bodyMedium?.copyWith(color: AppColors.secondaryTextColor),),
              Text("${bookingData.sessionDuration} min",style: textTheme.bodyMedium,),
            ],
          ),

          Divider(),

          /// Total Payment
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total Payment:",style: textTheme.bodyMedium?.copyWith(color: AppColors.secondaryTextColor),),
              Text("\$${getTotalPayment(bookingData)}",style: textTheme.bodyMedium,),
            ],
          ),
        ],
      ),
    );
  }

  double getTotalPayment(SessionModel bookingData) {
    final rateString = bookingData.hourlyRate;
    final hourlyRate = double.tryParse(rateString ?? '') ?? 0.0;

    return hourlyRate * (bookingData.sessionDuration / 60);
  }

}