import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpertBookingShimmer extends StatelessWidget{
  const ExpertBookingShimmer({super.key});


  Widget shimmerContainer({required double width, required double height, Widget? child}){
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10.r)
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 32.h,),
        shimmerContainer(width: 194.w,height: 33.h),
        SizedBox(height: 12.h,),
        shimmerContainer(width: 327.w,height: 240.h,),
        SizedBox(height: 32.h,),
        Align(
            alignment: Alignment.center,
            child: shimmerContainer(width: 327.w,height: 56.h,)),
      ],
    );
  }
}