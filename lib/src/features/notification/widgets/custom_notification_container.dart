import 'package:e_learning_app/core/routes/route_name.dart';
import 'package:e_learning_app/core/utils/common_widget.dart';
import 'package:e_learning_app/src/features/notification/data/model/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constant/images.dart';
import '../../../../core/services/api_services/api_end_points.dart';
import '../../../../core/theme/theme_part/app_colors.dart';
import '../Riverpod/accept_reject_booking_riverpod.dart';
import '../Riverpod/get_student_details_provider.dart';
import '../Riverpod/notification_provider.dart';
import '../data/model/wrapper_model.dart';

class CustomNotificationContainer extends ConsumerWidget {
  final NotificationItem item;

  const CustomNotificationContainer({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final buttonTextStyle = textTheme.bodySmall?.copyWith(
      fontWeight: FontWeight.w800,
    );
    return GestureDetector(
      onTap: () async {
        final studentId = item.id;
        if (studentId == null || studentId.isEmpty) return;

        await ref.read(studentProvider.notifier).fetchStudent(studentId);

        final state = ref.read(studentProvider);

        if (state.isLoading) {
          // Optionally show loader
        } else if (state.student != null) {
          context.push(
            RouteName.studentDetailsScreen,
            extra: StudentNotificationArgs(
              studentData: state.student!.data!,
              notificationItem: item,
            ),
          );
        } else if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error!)),
          );
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          left: 12.w,
          right: 12.w,
          top: 16.h,
          bottom: 16.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: const Color(0xff191919),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            /// Profile Picture
            ClipOval(
              child:
                  item.img != null && item.img!.isNotEmpty
                      ? Image.network(
                        '${ApiEndPoints.baseUrl}/uploads/$item.img',
                        width: 56.w,
                        height: 56.w,
                        fit: BoxFit.cover,
                      )
                      : CircleAvatar(
                    radius: 28.w,
                    backgroundColor: Colors.white,
                    child: Image.asset(
                      AppImages.maiya,
                      width: 32.w,
                      height: 32.w,
                      fit: BoxFit.cover,
                    ),
                  ),
            ),

            SizedBox(height: 16.h),

            /// User Name
            Text(item.title, style: textTheme.titleMedium),

            SizedBox(height: 4.h),

            /// Designation
            Text(
              item.description,
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.secondaryTextColor,
              ),
            ),
            SizedBox(height: 8.h),

            /// actions
            if (item.actions.isNotEmpty)
              Row(
                spacing: 8.w,
                children: List.generate(item.actions.length, (index) {
                  return Expanded(
                    child: Consumer(
                      builder: (_, ref, __) {
                        return CommonWidget.primaryButton(
                          context: context,
                            onPressed: () async {
                              final actionUrl = item.actions[index].url;
                              final actionMethod = item.actions[index].reqMethod; // todo:- perform with this method
                              if (actionUrl == null || actionUrl.isEmpty) return;

                              if (item.actions[index].disabled) return;
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
                          text: item.actions[index].text,
                          backgroundColor: item.actions[index].bgPrimary && !item.actions[index].disabled ? AppColors.primary : Color(0xff4A4C56),
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
