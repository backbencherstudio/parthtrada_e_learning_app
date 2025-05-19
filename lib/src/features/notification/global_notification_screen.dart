import 'package:e_learning_app/core/constant/images.dart';
import 'package:e_learning_app/core/constant/padding.dart';
import 'package:e_learning_app/src/features/notification/widgets/custom_notification_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GlobalNotificationScreen extends StatelessWidget {
  const GlobalNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.screenHorizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 45.h,),
              Text("Notifications",
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontSize: 32.sp,
                fontWeight: FontWeight.w800,
                color: Color(0xffffffff)
              ),
              ),
          
              SizedBox(height: 8.h,),
               Text("See your notifications",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xffffffff)
              ),
              ),
              ListView.separated(
                separatorBuilder: (context, index) {
                 return SizedBox(height: 12.h,);
                },
                shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                itemCount: 15,
                itemBuilder: (context, index) {
                  return CustomNotificationContainer(title: "Sarah Chen",discription: "Accept your consultation request on June 13th at 3 PM.",img: AppImages.women,);
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}