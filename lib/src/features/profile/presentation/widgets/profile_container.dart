// ignore_for_file: unused_local_variable, must_be_immutable

import 'package:e_learning_app/core/constant/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProfileContainer extends StatelessWidget {
  final String icon;
  final String title;
  void Function()? onTap;
   ProfileContainer({super.key,
  required this.icon,
  required this.title,
  required this.onTap
  });
  @override
  Widget build(BuildContext context) {
   final textStyle = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:  EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Color(0xff191919),
        ),
        child: Row(
          children: [
           SvgPicture.asset(icon),
           SizedBox(width: 8.w,),
           Text(title,
           style: textStyle.titleSmall!.copyWith(
            fontWeight: FontWeight.w600,
            color: Color(0xffffffff)
           ),
         ),
           Spacer(),
           SvgPicture.asset(AppIcons.backIcon),
              
          ],
        ),
      ),
    );
  }
}