import 'package:e_learning_app/src/features/schedule/presentation/widgets/schedule_show_container/schedule_show_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/constant/padding.dart';
import '../../../../core/theme/theme_part/app_colors.dart';
import '../../../../core/utils/common_widget.dart';
import '../../../../core/utils/utils.dart';
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

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _scrollController.jumpTo(0);
      _currentPage = 1;
      await ref.read(scheduleProvider.notifier).fetchMeetings(
        page: _currentPage,
        isRefresh: true,
      );
    });
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

    /// 🔹 4. Success State
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CommonWidget.customAppBar(
              context: context,
              textTheme: textTheme,
              isNotification: true,
              title: 'Your Schedules',
              subtitle: 'Your overall sessions',
            ),
            SizedBox(height: 12.h,),
            Expanded(
              child: Padding(
                padding: AppPadding.screenHorizontal,
                child: Builder(
                  builder: (_) {
                    /// 🔹 1. Initial Loading
                    if (scheduleState.isLoading && meetings.isEmpty) {
                      return SingleChildScrollView(
                        child: Column(
                          spacing: 16.h,
                          children: List.generate(3, (index) {
                            return _scheduleCardShimmer(context);
                          })
                        ),
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("No Schedules Found"),
                              SizedBox(height: 12.h),
                              GestureDetector(
                                onTap: () async {
                                  _currentPage = 1;
                                  await ref.read(scheduleProvider.notifier).fetchMeetings(
                                    page: _currentPage,
                                    isRefresh: true,
                                  );
                                },
                                child: Container(
                                  height: 40.h,
                                  width: 40.h,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade900,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.refresh_outlined,
                                    color: AppColors.primary,
                                    size: 24.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: () async {
                        _scrollController.jumpTo(0);
                        _currentPage = 1;
                        await ref.read(scheduleProvider.notifier).fetchMeetings(
                          page: _currentPage,
                          isRefresh: true,
                        );
                      },
                      child: ListView.builder(
                        controller: _scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
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
                                padding: EdgeInsets.only(bottom: 16.h),
                                child: _scheduleCardShimmer(context),
                              ),
                              error: (_, __) => const Padding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: Center(child: Text("Error loading expert data")),
                              ),
                            );
                          }
                          else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    );
                  }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _scheduleCardShimmer(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
      decoration: Utils.commonBoxDecoration(),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade800,
        highlightColor: Colors.grey.shade600,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar shimmer
            ClipOval(
              child: Container(
                width: 56.w,
                height: 56.w,
                decoration: BoxDecoration(
                  color: Colors.grey.shade700,
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),

            // Name shimmer
            Container(
              width: 140.w,
              height: 16.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade700,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            SizedBox(height: 4.h),

            // Profession shimmer
            Container(
              width: 100.w,
              height: 14.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade700,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            SizedBox(height: 7.h),

            // Skills shimmer row
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 24.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade700,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Container(
                  width: 40.w,
                  height: 24.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade700,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),

            // Button shimmer
            Container(
              width: double.infinity,
              height: 40.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade700,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
