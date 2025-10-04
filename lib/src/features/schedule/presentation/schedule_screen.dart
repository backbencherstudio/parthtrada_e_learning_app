import 'package:e_learning_app/core/constant/padding.dart';
import 'package:e_learning_app/src/features/schedule/presentation/widgets/schedule_show_container/schedule_show_container.dart';
import 'package:e_learning_app/src/features/schedule/presentation/widgets/schedule_show_container/schedule_show_container_footer.dart';
import 'package:e_learning_app/src/features/schedule/riverpod/schedule_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/common_widget.dart';
import '../../expert_details/riverpod/expert_details_provider.dart';

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
                builder: (context, ref, _) {
                  final scheduleState = ref.watch(scheduleProvider);
                  final meetings = scheduleState.meetings;

                  if (meetings.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: double.infinity, height: MediaQuery.of(context).size.height * 0.3,),
                        const Center(child: Text("No meetings found.")),
                      ],
                    );
                  }

                  final expertStates =
                  meetings.map((meeting) {
                    return ref.watch(
                      expertDetailProvider(meeting.expertId),
                    );
                  }).toList();

                  final isAnyLoading = expertStates.any(
                        (state) => state.isLoading,
                  );

                  if (isAnyLoading) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: double.infinity, height: MediaQuery.of(context).size.height * 0.3,),
                        const Center(child: CircularProgressIndicator()),
                      ],
                    );
                  }

                  final hasError = expertStates.any((state) => state.hasError);
                  if (hasError) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: double.infinity, height: MediaQuery.of(context).size.height * 0.3,),
                        const Center(
                          child: Text("Error loading Schedule data."),
                        ),
                      ],
                    );
                  }

                  return Column(
                    children: [
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: meetings.length,
                        padding: EdgeInsets.only(bottom: 24.h),
                        itemBuilder: (_, index) {
                          final meeting = meetings[index];
                          final expert = expertStates[index].asData!.value;

                          return ScheduleShowContainer(
                            expertName: expert.data?.expert?.user?.name ?? "",
                            expertImage: expert.data?.expert?.user?.image ?? "",
                            expertOrganization: expert.data?.expert?.organization ?? "",
                            expertProfession: expert.data?.expert?.profession ?? "",
                            meetingScheduleModel: meeting,
                          );
                        },
                      ),

                      if (scheduleState.isLoadingMore)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      else if (scheduleState.pagination?.hasNextPage == true)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: ElevatedButton(
                            onPressed: () {
                              ref.read(scheduleProvider.notifier).loadMoreMeetings();
                            },
                            child: const Text('Load More'),
                          ),
                        ),
                    ],
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
