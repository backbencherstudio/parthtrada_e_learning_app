import 'package:e_learning_app/src/features/schedule/presentation/widgets/schedule_show_container/schedule_show_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/constant/padding.dart';
import '../../../../core/theme/theme_part/app_colors.dart';
import '../../expert_details/riverpod/expert_details_provider.dart';
import '../riverpod/schedule_riverpod.dart';

class ScheduleScreen extends ConsumerStatefulWidget {
  const ScheduleScreen({super.key});

  @override
  ConsumerState<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends ConsumerState<ScheduleScreen> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMoreData);
  }

  void _loadMoreData() {
    final state = ref.read(scheduleProvider);
    if (!state.isLoadingMore && state.pagination?.hasNextPage == true) {
      if (_scrollController.position.extentAfter < 300) {
        _currentPage++;
        ref.read(scheduleProvider.notifier).fetchMeetings(page: _currentPage);
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
    final textTheme = Theme.of(context).textTheme;

    /// 🔹 1. Initial Loading
    if (scheduleState.isLoading && meetings.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    /// 🔹 2. Error State
    if (scheduleState.error != null && meetings.isEmpty) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(scheduleState.error!, style: textTheme.bodyLarge),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.read(scheduleProvider.notifier).fetchMeetings(
                    page: 1,
                    isRefresh: true,
                  );
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    /// 🔹 3. Empty State
    if (meetings.isEmpty) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('No Schedule Found', style: textTheme.bodyLarge),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.read(scheduleProvider.notifier).fetchMeetings(
                    page: 1,
                    isRefresh: true,
                  );
                },
                child: const Text('Refresh'),
              ),
            ],
          ),
        ),
      );
    }

    /// 🔹 4. Success State
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Schedule', style: textTheme.titleLarge),
        backgroundColor: AppColors.screenBackgroundColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: AppPadding.screenHorizontal,
          child: RefreshIndicator(
            onRefresh: () async {
              _currentPage = 1;
              await ref.read(scheduleProvider.notifier).fetchMeetings(
                page: _currentPage,
                isRefresh: true,
              );
            },
            child: ListView.builder(
              controller: _scrollController,
              itemCount: meetings.length + (scheduleState.isLoadingMore ? 1 : 0),
              padding: EdgeInsets.only(bottom: 24.h),
              itemBuilder: (context, index) {
                if (index < meetings.length) {
                  final meeting = meetings[index];

                  // Load expert details
                  final expertAsync =
                  ref.watch(expertDetailProvider(meeting.expertId));

                  return expertAsync.when(
                    data: (expert) => ScheduleShowContainer(
                      key: ValueKey(meeting.id),
                      expertName: meeting.user?.name ?? "",
                      expertImage: meeting.user?.image ?? "",
                      expertOrganization: meeting.user?.profession ?? "",
                      expertProfession: expert.data?.expert?.profession ?? "",
                      meetingScheduleModel: meeting,
                    ),
                    loading: () => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Shimmer.fromColors(
                        baseColor: AppColors.secondary,
                        highlightColor: Colors.grey.shade600,
                        child: Center(
                          child: Container(
                            width: double.infinity,
                            height: 150.h,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade700,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ),
                    error: (_, __) => const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Center(child: Text("Error loading expert data")),
                    ),
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
