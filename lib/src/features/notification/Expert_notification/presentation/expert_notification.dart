import 'package:e_learning_app/core/constant/icons.dart';
import 'package:e_learning_app/core/constant/padding.dart';
import 'package:e_learning_app/src/features/notification/Expert_notification/Riverpod/expert_noti_provider.dart';
import 'package:e_learning_app/src/features/notification/Expert_notification/presentation/widget/notification_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ExpertNotificationScreen extends StatelessWidget {
  const ExpertNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppPadding.screenHorizontal,
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
        
           Expanded(
             child: SizedBox(
               height: MediaQuery.of(context).size.height, 
               child: Consumer(
                 builder: (context, ref, _) {
                   final call = ref.watch(expertNotiProvider);
                   return ListView.builder(
                     itemCount: call.length,
                     itemBuilder: (context, index) {
                       final tile = call[index];
                       return Padding(
              padding:  EdgeInsets.only(bottom: 12.h),
              child: NotificationContainer(
                title: tile.title,
                discription: tile.discription,
                isRefund: tile.isRefund,
              ),
                       );
                     },
                   );
                 },
               ),
             ),
           ),

         
          
          ],
        ),
      ),
    );
  }
}
