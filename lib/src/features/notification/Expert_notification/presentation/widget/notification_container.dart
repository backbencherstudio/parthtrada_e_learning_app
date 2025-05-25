import 'package:e_learning_app/core/constant/icons.dart';
import 'package:e_learning_app/core/constant/images.dart';
import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:e_learning_app/src/features/profile/sub_feature/user%20profile/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class NotificationContainer extends StatelessWidget {
  final String title;
  final String discription;
  final bool isRefund;
  final String? img;
  const NotificationContainer({super.key,
  
  required this.title,
  required this.discription,
   this.img,
  required this.isRefund
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 235.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: AppColors.fillColor,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 12.w,
          right: 12.w,
          top: 16.h,
          bottom: 16.h,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset( img ?? AppImages.bedi, height: 56.h, width: 56.w),
            SizedBox(height: 16.h),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w800,
                color: Color(0xffffffff),

              ),
            ),
            SizedBox(height: 4.h),
            Text(
              discription,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(color: Color(0xff777980)),
            ),
       SizedBox(height: 15.h,),
            isRefund?
            Mybutton(
              height: 40.h,
                     width: double.infinity,
                  color: AppColors.primary,
                    text: "Mark as Refunded",
                    onTap: () {

                    },
                  ):
            Expanded(
              child: Row(
                children: [
                  Mybutton(
                    color: Color(0xff2B2C31),
                    text: "Decline",
                    onTap: () {
                    },
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Mybutton(
                      color: AppColors.primary,
                      text: "Accept",
                      onTap: () {
                      },
                    ),
                  ),
                ] ,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
