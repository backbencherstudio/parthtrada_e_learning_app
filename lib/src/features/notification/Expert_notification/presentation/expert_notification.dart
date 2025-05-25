import 'package:e_learning_app/core/constant/icons.dart';
import 'package:e_learning_app/core/constant/padding.dart';
import 'package:e_learning_app/src/features/notification/Expert_notification/presentation/widget/notification_container.dart';
import 'package:e_learning_app/src/features/notification/Student_notification/Riverpod/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ExpertNotificationScreen extends StatelessWidget {
  const ExpertNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppPadding.screenHorizontal,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 45.h),
              Row(
                children: [
               GestureDetector(
                 onTap: () {
                   Navigator.pop(context);
                 },
                 child: SvgPicture.asset(AppIcons.backlongArrow),
               ),
          SizedBox(width: 12.w,),
                  Text(
                    "Notifications",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w800,
                      color: Color(0xffffffff),
                    ),
                  ),
                ],
              ),
          
              SizedBox(height: 8.h),

              // consumer(
              //   builder: (context,ref,_) {
              //     final call = ref.watch(notificationProvider);
              //     return ListView.builder(
              //       itemCount: ,
              //       itemBuilder:(context, index){

              //         return NotificationContainer(
              //           title: ,
              //            discription: discription, 
              //            isRefund: isRefund);
              //       } );
              //   }
              // ),
            // NotificationContainer(
            //   title: "Jenny Wilson",
            //   discription: "Wants to take your consultation on June 13th at 3 PM.",
            //   isRefund: false,
            // ),
             
            
            ],
          ),
        ),
      ),
    );
  }
}
