import 'package:e_learning_app/src/features/schedule/presentation/widgets/schedule_show_container/schedule_show_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/padding.dart';
import '../../../../core/utils/common_widget.dart';
import '../../expert_details/riverpod/expert_details_provider.dart';
import '../riverpod/schedule_riverpod.dart';

class ScheduleScreen extends ConsumerStatefulWidget {
  const ScheduleScreen({super.key});

  @override
  ConsumerState<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends ConsumerState<ScheduleScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMoreData);
  }

  void _loadMoreData() {
    final state = ref.read(scheduleProvider);
    if (!state.isLoadingMore && state.pagination?.hasNextPage == true) {
      if (_scrollController.position.extentAfter < 100) {
        ref.read(scheduleProvider.notifier).loadMoreMeetings();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheduleState = ref.watch(scheduleProvider);
    final meetings = scheduleState.meetings;

    return Scaffold(
      body: Column(
        children: [
          CommonWidget.customAppBar(
            textTheme: Theme.of(context).textTheme,
            isNotification: false,
            title: "Your Schedule",
            subtitle: "Your overall sessions",
          ),
          Expanded(
            child: Padding(
              padding: AppPadding.screenHorizontal,
              child: Column(
                children: [
                  if (scheduleState.isLoading && meetings.isEmpty)
                    const Expanded(child: Center(child: CircularProgressIndicator())),

                  if (!(scheduleState.isLoading))
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          await ref.read(scheduleProvider.notifier).refreshMeetings();
                        },
                        child: Consumer(
                          builder: (context, ref, _) {
                            final expertStates = meetings
                                .map((meeting) => ref.watch(expertDetailProvider(meeting.expertId)))
                                .toList();

                            final isAnyLoading = expertStates.any((state) => state.isLoading);
                            final isAnyError = expertStates.any((state) => state.hasError);

                            if (isAnyLoading) {
                              return const Center(child: CircularProgressIndicator());
                            }

                            if (isAnyError) {
                              return const Center(child: Text("Error loading expert data"));
                            }

                            if (meetings.isEmpty) {
                              return const Center(child: Text("No Schedule Found"));
                            }

                            return ListView.builder(
                              controller: _scrollController,
                              itemCount: meetings.length,
                              padding: EdgeInsets.only(bottom: 24.h),
                              itemBuilder: (context, index) {
                                final meeting = meetings[index];
                                final expert = expertStates[index].asData!.value;

                                return ScheduleShowContainer(
                                  key: ValueKey(meeting.id),
                                  expertName: expert.data?.expert?.user?.name ?? "",
                                  expertImage: expert.data?.expert?.user?.image ?? "",
                                  expertOrganization: expert.data?.expert?.organization ?? "",
                                  expertProfession: expert.data?.expert?.profession ?? "",
                                  meetingScheduleModel: meeting,
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),

                  if (scheduleState.isLoadingMore)
                    const LinearProgressIndicator(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
