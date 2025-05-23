import 'package:e_learning_app/core/constant/padding.dart';
import 'package:e_learning_app/src/features/schedule/presentation/widgets/schedule_show_container.dart';
import 'package:e_learning_app/src/features/schedule/riverpod/schedule_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/common_widget.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CommonWidget.customAppBar(
              textTheme: Theme.of(context).textTheme,
              isNotification: false,
              title: "Your Schedule",
              subtitle: "Your overall sessions",
            ),

            SizedBox(height: 24.h),

            Padding(
              padding: AppPadding.screenHorizontal,
              child: Consumer(
                builder: (_, ref, _) {
                  final scheduleProviderState = ref.watch(scheduleProvider);
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: scheduleProviderState.meetingList?.length ?? 0,
                    padding: EdgeInsets.only(bottom: 24.h),
                    itemBuilder: (_, index) {
                      final meetingSchedule =
                          scheduleProviderState.meetingList![index];
                      return ScheduleShowContainer(
                        meetingScheduleModel: meetingSchedule,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
