import 'package:e_learning_app/src/features/notification/data/model/notification_model.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constant/images.dart';
import '../../../../../core/constant/padding.dart';
import '../../../../../core/routes/route_name.dart';
import '../../../../../core/services/api_services/api_end_points.dart';
import '../../../../../core/services/local_storage_services/user_id_storage.dart';
import '../../../../../core/theme/theme_part/app_colors.dart';
import '../../../../../core/utils/common_widget.dart';
import '../../Riverpod/accept_reject_booking_riverpod.dart';
import '../../Riverpod/get_student_details_provider.dart';
import '../../Riverpod/notification_provider.dart';
import '../../data/model/student/student_model.dart';

class StudentDetailsScreen extends ConsumerWidget {
  final NotificationItem notificationItem;
  final StudentData studentData;


  const StudentDetailsScreen({super.key, required this.notificationItem, required this.studentData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(studentProvider);
    final textTheme = Theme.of(context).textTheme;
    final buttonTextStyle = textTheme.bodySmall?.copyWith(
      fontWeight: FontWeight.w800,
    );
    return Padding(
      padding: AppPadding.screenHorizontal,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => context.pop(),
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                ),
                const Spacer(),
              ],
            ),
            Center(
              child: ClipOval(
                child:
                    state.student?.data?.user?.image != null
                        ? Image.network(
                          '${ApiEndPoints.baseUrl}/uploads/${state.student?.data?.user?.image}',
                          width: 100.w,
                          height: 100.w,
                          fit: BoxFit.cover,
                        )
                        : CircleAvatar(
                      radius: 50.w,
                      backgroundColor: Colors.white,
                      child: Image.asset(
                        AppImages.maiya,
                        width: 32.w,
                        height: 32.w,
                        fit: BoxFit.cover,
                      ),
                    ),
              ),
            ),
            SizedBox(height: 30.h),
            Row(
              children: [
                Expanded(
                  child: Text(
                    state.student?.data?.user?.name ?? 'Unknown',
                    style: textTheme.headlineSmall,
                  ),
                ),
                SizedBox(width: 4.w),
              ],
            ),
            SizedBox(height: 4.h),

            /// Profession, organization
            Text(
              '${state.student?.data?.profession ?? 'Unknown'}, ${state.student?.data?.organization ?? ''}',
              style: textTheme.labelLarge,
            ),
            SizedBox(height: 10.h),

            /// Location
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: Colors.white,
                  size: 20.sp,
                ),
                SizedBox(width: 6.w),
                Text(
                  state.student?.data?.profession ?? 'Unknown',
                  style: textTheme.labelMedium,
                ),
              ],
            ),
            SizedBox(height: 10.h),

            /// Message button
            CommonWidget.primaryButton(
              context: context,
              onPressed: () async {
                final userId = await UserIdStorage().getUserId();

                context.push(
                  RouteName.inboxScreen,
                  extra: {
                    'image': state.student?.data?.user?.image ?? '',
                    'name': state.student?.data?.user?.name ?? '',
                    'userId': userId ?? '',
                    'recipientId': state.student?.data?.userId ?? '',
                  },
                );
              },
              text: "Message",
            ),
            SizedBox(height: 20.h),
            Text("Professional Bio", style: textTheme.headlineSmall),
            SizedBox(height: 10.h),
            ExpandableText(
              state.student?.data?.description ?? 'No Professional Bio',
              expandText: "Read More",
              collapseText: "Read Less",
              collapseOnTextTap: true,
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.secondaryTextColor,
              ),
              maxLines: 4,
              animation: true,
              expandOnTextTap: true,
              linkColor: AppColors.primary,
              animationDuration: const Duration(milliseconds: 300),
              animationCurve: Curves.linear,
            ),
            SizedBox(height: 20.h),
            Text("Session Details", style: textTheme.headlineSmall),
            SizedBox(height: 10.h),
            Text(
              notificationItem.meta.sessionDetails,
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.secondaryTextColor,
              ),
            ),
            Spacer(),
            Text(
              notificationItem.description,
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.secondaryTextColor,
              ),
            ),
            SizedBox(height: 8.h),

            /// actions
            if (notificationItem.actions.isNotEmpty)
              Row(
                spacing: 8.w,
                children: List.generate(notificationItem.actions.length, (index) {
                  return Expanded(
                    child: Consumer(
                        builder: (_, ref, __) {
                          return CommonWidget.primaryButton(
                              context: context,
                              onPressed: () async {
                                final actionUrl = notificationItem.actions[index].url;
                                final actionMethod = notificationItem.actions[index].reqMethod; // todo:- perform with this method
                                if (actionUrl == null || actionUrl.isEmpty) return;

                                if (notificationItem.actions[index].disabled) return;
                                await ref.read(acceptRejectBookingProvider.notifier).patchBookingAction(actionUrl);

                                final state = ref.read(acceptRejectBookingProvider);

                                state.when(
                                  data: (response) async {
                                    if (response?.success == true) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(response?.message ?? "Action successful")),
                                      );
                                      await ref.read(notificationsProvider.notifier).refreshNotifications();
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text("Action failed")),
                                      );
                                    }
                                  },
                                  loading: () {},
                                  error: (error, _) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Error: This booking has already been processed")),
                                    );
                                  },
                                );

                                ref.read(acceptRejectBookingProvider.notifier).reset();
                              },
                              text: notificationItem.actions[index].text,
                              backgroundColor: notificationItem.actions[index].bgPrimary && !notificationItem.actions[index].disabled ? AppColors.primary : Color(0xff4A4C56),
                              textStyle: buttonTextStyle
                          );
                        }
                    ),
                  );
                }),
              ),
            SizedBox(height: 4.h),
          ],
        ),
      ),
    );
  }
}
