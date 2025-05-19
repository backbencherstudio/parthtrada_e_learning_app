import 'package:e_learning_app/core/constant/padding.dart';
import 'package:e_learning_app/src/features/notification/Riverpod/notification_provider.dart';
import 'package:e_learning_app/src/features/notification/widgets/custom_notification_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GlobalNotificationScreen extends StatelessWidget {
  const GlobalNotificationScreen({super.key});

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
              Text(
                "Notifications",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w800,
                  color: Color(0xffffffff),
                ),
              ),
          
              SizedBox(height: 8.h),
              Text(
                "See your notifications",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffffffff),
                ),
              ),
              Consumer(
                builder: (context, ref, _) {
                  final notifications = ref.watch(notificationProvider);
                  final notifier = ref.read(notificationProvider.notifier);
                  return ListView.separated(
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 12.h);
                    },
                    padding: EdgeInsets.only(top: 24.h),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      final item = notifications[index];
                            
                      return CustomNotificationContainer(
                        title: item.title,
                        discription: item.description,
                        img: item.img,
                        onClose: () => notifier.removeNotification(index),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
