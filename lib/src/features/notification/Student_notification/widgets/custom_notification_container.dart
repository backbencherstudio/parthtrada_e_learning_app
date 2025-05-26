import 'package:e_learning_app/core/utils/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomNotificationContainer extends StatelessWidget {
  final String title;
  final String img;
  final String discription;
  final VoidCallback onClose;

  const CustomNotificationContainer({
    super.key,
    required this.title,
    required this.discription,
    required this.img,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: 12.w,
        right: 12.w,
        top: 16.h,
        bottom: 16.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: const Color(0xff191919),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.asset(
              img,
              height: 48.h,
              width: 48.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12.w),

          // Texts and close button
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    CommonWidget.closeButton(context: context, ontap: onClose),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  discription,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff777980),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
