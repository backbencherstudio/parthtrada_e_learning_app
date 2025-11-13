import 'package:e_learning_app/src/features/schedule/model/schedule_meeting_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../../../../../core/constant/icons.dart';
import '../../../../../../core/theme/theme_part/app_colors.dart';
import '../../../../../../core/utils/common_widget.dart';
import '../../../../notification/Riverpod/accept_reject_booking_riverpod.dart';
import '../../../../search/provider/user_type_provider.dart';
import '../../../riverpod/add_review_provider.dart';
import '../../../riverpod/cancel_meeting_provider.dart';
import '../../../riverpod/refund_riverpod.dart';
import '../../../riverpod/schedule_riverpod.dart';
import '../add_review_bottom_sheet/add_review_bottom_sheet.dart';

class ScheduleShowContainerFooter extends ConsumerWidget {
  final Booking meetingScheduleModel;

  const ScheduleShowContainerFooter({
    super.key,
    required this.meetingScheduleModel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final buttonTextStyle = textTheme.bodySmall?.copyWith(
      fontWeight: FontWeight.w800,
    );
    final role = ref.watch(userTypeProvider).asData?.value;
    debugPrint("Meeting Schedule User Role: $role");

    final reviewState = ref.watch(addReviewProvider);

    /// expert actions

    if (role == 'EXPERT' && meetingScheduleModel.roleInBooking == 'EXPERT') {
      return Column(
        spacing: 12.h,
        children: [
          Row(
            spacing: 8.w,
            children: [
              SvgPicture.asset(AppIcons.calendar),
              Text(
                DateFormat(
                  'yyyy-MM-dd, HH:mm',
                ).format(DateTime.parse(meetingScheduleModel.date.toString())),
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.secondaryTextColor,
                ),
              ),
            ],
          ),
          meetingScheduleModel.status == 'PENDING'
              ? Row(
                spacing: 8.w,
                children: [
                  Consumer(
                    builder: (context, ref, __) {
                      final bookingKey = "${meetingScheduleModel.id}_reject";
                      final state = ref.watch(
                        acceptRejectBookingProvider(bookingKey),
                      );
                      final isLoading = state is AsyncLoading;

                      return Expanded(
                        child: CommonWidget.primaryButton(
                          textStyle: buttonTextStyle,
                          context: context,
                          onPressed:
                              isLoading
                                  ? () {}
                                  : () async {
                                    final actionUrl =
                                        '/experts/bookings/actions/${meetingScheduleModel.id}/reject/${meetingScheduleModel.notificationId}';

                                    await ref
                                        .read(
                                          acceptRejectBookingProvider(
                                            bookingKey,
                                          ).notifier,
                                        )
                                        .patchBookingAction(actionUrl);

                                    final result = ref.read(
                                      acceptRejectBookingProvider(bookingKey),
                                    );
                                    result.when(
                                      data: (response) async {
                                        if (response?.success == true) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                response?.message ?? "Rejected",
                                              ),
                                            ),
                                          );
                                          await ref
                                              .read(scheduleProvider.notifier)
                                              .fetchMeetings(
                                                page: 1,
                                                isRefresh: true,
                                              );
                                        } else {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text("Action failed"),
                                            ),
                                          );
                                        }
                                      },
                                      error: (error, _) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text("Error: $error"),
                                          ),
                                        );
                                      },
                                      loading: () {},
                                    );

                                    ref
                                        .read(
                                          acceptRejectBookingProvider(
                                            bookingKey,
                                          ).notifier,
                                        )
                                        .reset();
                                  },
                          text: isLoading ? "Cancelling..." : "Cancel",
                          backgroundColor: const Color(0xff2B2C31),
                        ),
                      );
                    },
                  ),

                  Consumer(
                    builder: (context, ref, __) {
                      final bookingKey = "${meetingScheduleModel.id}_accept";
                      final state = ref.watch(
                        acceptRejectBookingProvider(bookingKey),
                      );
                      final isLoading = state is AsyncLoading;

                      return Expanded(
                        child: CommonWidget.primaryButton(
                          backgroundColor: AppColors.primary,
                          textStyle: buttonTextStyle?.copyWith(
                            color: Colors.white,
                          ),
                          context: context,
                          onPressed:
                              isLoading
                                  ? () {}
                                  : () async {
                                    final actionUrl =
                                        '/experts/bookings/actions/${meetingScheduleModel.id}/accept/${meetingScheduleModel.notificationId}';

                                    await ref
                                        .read(
                                          acceptRejectBookingProvider(
                                            bookingKey,
                                          ).notifier,
                                        )
                                        .patchBookingAction(actionUrl);

                                    final result = ref.read(
                                      acceptRejectBookingProvider(bookingKey),
                                    );
                                    result.when(
                                      data: (response) async {
                                        if (response?.success == true) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                response?.message ?? "Accepted",
                                              ),
                                            ),
                                          );
                                          await ref
                                              .read(scheduleProvider.notifier)
                                              .fetchMeetings(
                                                page: 1,
                                                isRefresh: true,
                                              );
                                        } else {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text("Action failed"),
                                            ),
                                          );
                                        }
                                      },
                                      error: (error, _) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text("Error: $error"),
                                          ),
                                        );
                                      },
                                      loading: () {},
                                    );

                                    ref
                                        .read(
                                          acceptRejectBookingProvider(
                                            bookingKey,
                                          ).notifier,
                                        )
                                        .reset();
                                  },
                          text: isLoading ? "Accepting..." : "Create Link",
                        ),
                      );
                    },
                  ),
                ],
              )
              : meetingScheduleModel.status == 'COMPLETED'
              ? Row(
                spacing: 8.w,
                children: [
                  Expanded(
                    child: CommonWidget.primaryButton(
                      backgroundColor: Color(0xff2B2C31),
                      textStyle: buttonTextStyle?.copyWith(color: Colors.white),
                      context: context,
                      onPressed: ()  {

                      },
                      text: "Completed",
                    ),
                  ),
                ],
              )
              : Row(
                spacing: 8.w,
                children: [
                  // Consumer(
                  //   builder: (context, ref, __) {
                  //     final bookingId = meetingScheduleModel.id;
                  //     final state = ref.watch(acceptRejectBookingProvider(bookingId));
                  //     final isLoading = state is AsyncLoading;
                  //
                  //     return Expanded(
                  //       child: CommonWidget.primaryButton(
                  //         textStyle: buttonTextStyle,
                  //         context: context,
                  //         onPressed: isLoading
                  //             ? (){}
                  //             : () async {
                  //           final actionUrl =
                  //               '/experts/bookings/actions/$bookingId/reject/${meetingScheduleModel.notificationId}';
                  //
                  //           await ref
                  //               .read(acceptRejectBookingProvider(bookingId).notifier)
                  //               .patchBookingAction(actionUrl);
                  //
                  //           final result = ref.read(acceptRejectBookingProvider(bookingId));
                  //           result.when(
                  //             data: (response) async {
                  //               if (response?.success == true) {
                  //                 ScaffoldMessenger.of(context).showSnackBar(
                  //                   SnackBar(content: Text(response?.message ?? "Rejected")),
                  //                 );
                  //                 await ref
                  //                     .read(scheduleProvider.notifier)
                  //                     .fetchMeetings(page: 1, isRefresh: true);
                  //               } else {
                  //                 ScaffoldMessenger.of(context).showSnackBar(
                  //                   const SnackBar(content: Text("Action failed")),
                  //                 );
                  //               }
                  //             },
                  //             error: (error, _) {
                  //               ScaffoldMessenger.of(context).showSnackBar(
                  //                 SnackBar(content: Text("This booking has already been processed")),
                  //               );
                  //             },
                  //             loading: () {},
                  //           );
                  //
                  //           ref.read(acceptRejectBookingProvider(bookingId).notifier).reset();
                  //         },
                  //         text: isLoading ? "Cancelling..." : "Cancel",
                  //         backgroundColor: const Color(0xff2B2C31),
                  //       ),
                  //     );
                  //   },
                  // ),
                  Expanded(
                    child: CommonWidget.primaryButton(
                      backgroundColor: AppColors.primary,
                      textStyle: buttonTextStyle?.copyWith(color: Colors.white),
                      context: context,
                      onPressed: () async {
                        if (meetingScheduleModel.meetingLink != null &&
                            meetingScheduleModel.meetingLink!
                                .trim()
                                .isNotEmpty) {
                          await Clipboard.setData(
                            ClipboardData(
                              text: meetingScheduleModel.meetingLink ?? '',
                            ),
                          );
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Link Copied to Clipboard"),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                              ),
                            );
                          }
                        } else {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Expert don't accept the booking yet",
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                              ),
                            );
                          }
                        }
                      },
                      text: "Copy Link",
                    ),
                  ),
                ],
              ),
        ],
      );
    }
    /// Student actions
    else {
      if (meetingScheduleModel.status == 'UPCOMING' ||
          meetingScheduleModel.status == 'PENDING') {
        return Column(
          spacing: 12.h,
          children: [
            Row(
              spacing: 8.w,
              children: [
                SvgPicture.asset(AppIcons.calendar),
                Text(
                  DateFormat('yyyy-MM-dd, HH:mm').format(
                    DateTime.parse(meetingScheduleModel.date.toString()),
                  ),
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.secondaryTextColor,
                  ),
                ),
              ],
            ),
            Row(
              spacing: 8.w,
              children: [
                if (meetingScheduleModel.status == "PENDING")
                  Consumer(
                    builder: (context, ref, __) {
                      final cancelState = ref.watch(
                        cancelScheduleNotifierProvider(meetingScheduleModel.id),
                      );
                      final notifier = ref.read(
                        cancelScheduleNotifierProvider(
                          meetingScheduleModel.id,
                        ).notifier,
                      );

                      return Expanded(
                        child: CommonWidget.primaryButton(
                          textStyle: buttonTextStyle,
                          context: context,
                          onPressed:
                              cancelState.isLoading
                                  ? () {}
                                  : () async {
                                    final success = await notifier
                                        .cancelMeeting(meetingScheduleModel.id);

                                    if (!context.mounted) return;

                                    final updatedState = ref.read(
                                      cancelScheduleNotifierProvider(
                                        meetingScheduleModel.id,
                                      ),
                                    );

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          updatedState.errorMessage ??
                                              'Unknown response',
                                        ),
                                      ),
                                    );

                                    if (success) {
                                      ref
                                          .read(scheduleProvider.notifier)
                                          .removeMeeting(
                                            meetingScheduleModel.id,
                                          );
                                      await ref
                                          .read(scheduleProvider.notifier)
                                          .fetchMeetings(
                                            page: 1,
                                            isRefresh: true,
                                          );
                                    }
                                  },
                          text:
                              cancelState.isLoading
                                  ? "Cancelling..."
                                  : "Cancel",
                          backgroundColor: const Color(0xff2B2C31),
                        ),
                      );
                    },
                  ),

                Expanded(
                  child: CommonWidget.primaryButton(
                    backgroundColor:
                        meetingScheduleModel.status == "PENDING"
                            ? Color(0xff4A4C56)
                            : AppColors.primary,
                    textStyle: buttonTextStyle?.copyWith(
                      color:
                          meetingScheduleModel.status == "PENDING"
                              ? Color(0xffA5A5AB)
                              : Colors.white,
                    ),
                    context: context,
                    onPressed: () async {
                      if (meetingScheduleModel.status == "UPCOMING" &&
                          (meetingScheduleModel.meetingLink != null &&
                              meetingScheduleModel.meetingLink!
                                  .trim()
                                  .isNotEmpty)) {
                        await Clipboard.setData(
                          ClipboardData(
                            text: meetingScheduleModel.meetingLink ?? '',
                          ),
                        );
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Link Copied to Clipboard"),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                            ),
                          );
                        }
                      } else {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Expert don't accept the booking yet",
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                            ),
                          );
                        }
                      }
                    },
                    text: "Copy Link",
                  ),
                ),
              ],
            ),
          ],
        );
      } else if (meetingScheduleModel.status == "REFUNDED") {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
            Text(meetingScheduleModel.refundReason ?? "Cancelled The Meeting"),

            SizedBox(
              width: double.infinity,
              child: CommonWidget.primaryButton(
                context: context,
                onPressed: () {},
                text: "Refunded",
                textStyle: buttonTextStyle,
                backgroundColor: Color(0xff2B2C31),
              ),
            ),
          ],
        );
      } else {
        if (meetingScheduleModel.shouldReview == false &&
            meetingScheduleModel.shouldRefund == true) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12.h,
            children: [
              Text(
                meetingScheduleModel.status == "CANCELLED"
                    ? meetingScheduleModel.refundReason ??
                        "Cancelled The Meeting"
                    : "No Response",
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.error,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(
                width: double.infinity,
                child: Consumer(
                  builder: (context, ref, _) {
                    final refundState = ref.watch(
                      refundProvider(meetingScheduleModel.id),
                    );
                    final refundNotifier = ref.read(
                      refundProvider(meetingScheduleModel.id).notifier,
                    );

                    final isLoading = refundState.isLoading;
                    final isSuccess = refundState.success;

                    return CommonWidget.primaryButton(
                      context: context,
                      onPressed:
                          isLoading
                              ? () {}
                              : () async {
                                if (meetingScheduleModel.transaction?.type !=
                                    'refund-request') {
                                  final success = await refundNotifier.refund(
                                    meetingScheduleModel.id,
                                  );
                                  final message =
                                      ref
                                          .read(
                                            refundProvider(
                                              meetingScheduleModel.id,
                                            ),
                                          )
                                          .error ??
                                      'Something went wrong';

                                  if (!context.mounted) return;

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(message)),
                                  );

                                  if (success) {
                                    await ref
                                        .read(scheduleProvider.notifier)
                                        .fetchMeetings(
                                          page: 1,
                                          isRefresh: true,
                                        );
                                  }
                                }
                              },
                      text:
                          isLoading
                              ? "Processing..."
                              : meetingScheduleModel.transaction?.refunded ??
                                  false
                              ? "Refunded"
                              : meetingScheduleModel.transaction?.type ==
                                  'refund-request'
                              ? 'Requested Refund'
                              : "Refund",
                      textStyle: buttonTextStyle,
                      backgroundColor:
                          meetingScheduleModel.transaction?.refunded == true ||
                                  (meetingScheduleModel.transaction?.refunded ==
                                          false &&
                                      meetingScheduleModel.transaction?.type ==
                                          'refund-request')
                              ? Color(0xff2B2C31)
                              : Colors.red,
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return Column(
            spacing: 12.h,
            children: [
              Row(
                spacing: 8.w,
                children: [
                  SvgPicture.asset(AppIcons.calendar),
                  Text(
                    DateFormat('yyyy-MM-dd, HH:mm').format(
                      DateTime.parse(meetingScheduleModel.date.toString()),
                    ),
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.secondaryTextColor,
                    ),
                  ),
                  Spacer(),
                  if (meetingScheduleModel.status == 'COMPLETED')
                    Text(
                      "${meetingScheduleModel.sessionDuration} Min",
                      style: textTheme.labelMedium?.copyWith(
                        color: Color(0xffD2D2D5),
                      ),
                    ),
                ],
              ),
              if (meetingScheduleModel.shouldReview == true)
                SizedBox(
                  width: double.infinity,
                  child: CommonWidget.primaryButton(
                    backgroundColor: Color(0xffFF7F48),
                    context: context,
                    onPressed: () async {
                      ref.read(addReviewProvider.notifier).state = reviewState
                          .copyWith(bookingId: meetingScheduleModel.id);
                      await addReviewBottomSheet(context: context);
                      await ref
                          .read(scheduleProvider.notifier)
                          .fetchMeetings(page: 1, isRefresh: true);
                    },
                    text: "Add Review",
                    textStyle: buttonTextStyle,
                  ),
                ),
              // SizedBox(
              //   width: double.infinity,
              //   child: CommonWidget.primaryButton(
              //     backgroundColor: Color(0xff2B2C31),
              //     context: context,
              //     onPressed: () {}, // view summary
              //     text: "View Summary",
              //     textStyle: buttonTextStyle,
              //   ),
              // ),
            ],
          );
        }
      }
    }
  }
}

/// this file is changed
/// refund is integrated
