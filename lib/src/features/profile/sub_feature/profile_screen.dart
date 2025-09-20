import 'package:e_learning_app/core/constant/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widget_List.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.only(left: 24.w, right: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
              children: [
              SizedBox(height: 67.h),
              Center(
                child: Image.asset(AppImages.maiya, height: 140.h, width: 140.w),
              ),
              SizedBox(height: 20.h),
              Text(
                "Jenny Wilson",
                style: textStyle.titleSmall!.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Color(0xffffffff),
                ),
              ),
              Text(
                "Student at Dhaka University",
                style: textStyle.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Color(0xffA5A5AB),
                ),
              ),
              SizedBox(height: 20.h,),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "General",
                  style: textStyle.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
              SizedBox(height: 18.h,),
            ...callContainerGeneral(context),
              SizedBox(height: 28.h,),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Preferencess",
                  style: textStyle.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
              SizedBox(height: 18.h,),
            ...callContainerPreferences(context),
              SizedBox(height: 18.h,),
            ],
          ),
        ),
      ),
    );                 
  }
}


