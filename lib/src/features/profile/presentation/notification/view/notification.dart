import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:e_learning_app/src/features/profile/presentation/notification/Riverpod/notification_provider.dart'
    show notificationToggleProvider;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;

import '../../../../../../core/constant/icons.dart';
import '../../../sub_feature/user profile/widget/custom_button.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> settting = [
      "Notifications",
      "Email",
      "Sound",
      "Vibrate",
      "App Updates",
    ];

    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        title: Text(
          "Notification",
          style: Theme.of(
            context,
          ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.only(left: 24.w),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset(AppIcons.backlongArrow),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Divider(
              thickness: 1,
              color: Color(0xff2B2C31),
              indent: 6.w,
              endIndent: 6.w,
            ),
            SizedBox(height: 24.h),
            SizedBox(
              height: 500.h,
              child: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                itemCount: settting.length,
                separatorBuilder: (context, index) => SizedBox(height: 12.h),

                itemBuilder: (context, index) {
                  return Consumer(
                    builder: (context, ref, _) {
                      final toggles = ref.watch(notificationToggleProvider);
                      final notifier = ref.read(
                        notificationToggleProvider.notifier,
                      );
                      return Container(
                        height: 64.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: Color(0xff191919),
                        ),

                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),

                          child: Row(
                            children: [
                              Text(
                                settting[index],
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyLarge!.copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xffffffff),
                                ),
                              ),
                              Spacer(),
                              Switch(
                                value: toggles[index],
                                onChanged: (_) => notifier.toggle(index),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            Mybutton(
              color: AppColors.primary,
              text: "Save",
              onTap: () {},
              width: 327.w,
            ),
          ],
        ),
      ),
    );
  }
}
