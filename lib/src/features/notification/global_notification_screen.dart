import 'package:e_learning_app/core/constant/padding.dart';
import 'package:e_learning_app/src/features/notification/Riverpod/notification_provider.dart';
import 'package:e_learning_app/src/features/notification/widgets/custom_notification_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GlobalNotificationScreen extends ConsumerStatefulWidget {
  const GlobalNotificationScreen({super.key});

  @override
  ConsumerState<GlobalNotificationScreen> createState() =>
      _GlobalNotificationScreenState();
}

class _GlobalNotificationScreenState
    extends ConsumerState<GlobalNotificationScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMoreData);
  }

  void _loadMoreData() {
    final state = ref.read(notificationsProvider);
    if (!state.isLoadingMore && state.pagination?.hasNextPage == true) {
      if (_scrollController.position.extentAfter < 100) {
        ref.read(notificationsProvider.notifier).loadMoreNotifications();
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
    final state = ref.watch(notificationsProvider);
    final notifier = ref.read(notificationsProvider.notifier);

    return SafeArea(
      top: false,
      left: false,
      bottom: true,
      right: false,
      child: Scaffold(
        body: Padding(
          padding: AppPadding.screenHorizontal,
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
              SizedBox(height: 16.h),

              // Main Body
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await notifier.refreshNotifications();
                  },
                  child: Builder(
                    builder: (context) {
                      if (state.isLoading && state.notifications.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state.error != null && state.notifications.isEmpty) {
                        return Center(
                          child: Text(
                            'Error: ${state.error}',
                            style: TextStyle(color: Colors.red),
                          ),
                        );
                      }

                      if (state.notifications.isEmpty) {
                        return const Center(child: Text("No Notifications"));
                      }

                      return ListView.separated(
                        controller: _scrollController,
                        itemCount: state.notifications.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 12.h),
                        padding: EdgeInsets.only(bottom: 24.h),
                        itemBuilder: (context, index) {
                          final item = state.notifications[index];
                          return CustomNotificationContainer(item: item);
                        },
                      );
                    },
                  ),
                ),
              ),

              if (state.isLoadingMore)
                const LinearProgressIndicator(), // show bottom loader
            ],
          ),
        ),
      ),
    );
  }
}
