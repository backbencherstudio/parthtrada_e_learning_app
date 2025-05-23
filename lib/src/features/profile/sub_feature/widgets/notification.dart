import 'package:e_learning_app/core/constant/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class BellNotification extends StatelessWidget {
  const BellNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //notification page
      },
      child: Container(
       height: 48.h,
       width: 48.w,
        decoration: BoxDecoration(
          borderRadius:  BorderRadius.circular(12.r),
          color: Color(0xff191919),
        ),
        child:Padding(
          padding:  EdgeInsets.only(left: 8.w, right: 8.w, top: 10.h, bottom: 10.h),
          child: SvgPicture.asset(AppIcons.bell,
          height: 26.h,
          width: 26.w,
          ),
        ) ,
      ),
    );
  }
}