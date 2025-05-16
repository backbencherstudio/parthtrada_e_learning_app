import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widget/custom_button.dart';
import 'widget/headers.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 48.h),
              Headers(),
              SizedBox(height: 24.h),
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
              SizedBox(height: 20.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Profession",
                  style: textStyle.bodyMedium!.copyWith(
                    color: Color(0xffffffff),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              TextFormField(decoration: InputDecoration(hintText: "student")),
              SizedBox(height: 14.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Organization Name",
                  style: textStyle.bodyMedium!.copyWith(
                    color: Color(0xffffffff),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              TextFormField(decoration: InputDecoration(hintText: "Tesla")),

              SizedBox(height: 14.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Location",
                  style: textStyle.bodyMedium!.copyWith(
                    color: Color(0xffffffff),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              TextFormField(decoration: InputDecoration(hintText: "USA")),
              SizedBox(height: 14.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Professional Bio",
                  style: textStyle.bodyMedium!.copyWith(
                    color: Color(0xffffffff),
                  ),
                ),
              ),
              SizedBox(height: 8.h),

              SizedBox(
                width: 326.w,
                height: 127.h,
                child: TextFormField(
                  expands: false,
                  maxLines: 5,
                  minLines: 3,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(hintText: "Description"),
                ),
              ),
              Row(
                children: [
                  Mybutton(color: Color(0xff2B2C31), text: "Discard", onTap: () {
                    Navigator.pop(context);
                  },),
                  SizedBox(width: 8.w,),
                  Mybutton(color:AppColors.primary , text: "Save", onTap: () {
                    
                  },)
                ],
              ),
              SizedBox(height: 100.h,)
            ],
          ),
        ),
      ),
    );
  }
}
