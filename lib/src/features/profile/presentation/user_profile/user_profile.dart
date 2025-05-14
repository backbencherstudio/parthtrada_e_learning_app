import 'package:e_learning_app/src/features/profile/presentation/user_profile/widget/headers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
        final textStyle = Theme.of(context).textTheme;

    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.only(left: 24.w, right: 24.w,),
        child: Column(
          children: [
            SizedBox(height: 48.h,),
            Headers(),
            SizedBox(height: 24.h,),
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
                child: Text("Profession",
                style: textStyle.bodyMedium!.copyWith(
                  color: Color(0xffffffff)
                ),
                ),
              )
          ],
        ),
      ),
    );
  }
}