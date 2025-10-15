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
import '../../../riverpod/complete_meeting_provider.dart';
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
    debugPrint("meetingScheduleModel: $role");

    final reviewState = ref.watch(addReviewProvider);
    if (role == 'EXPERT') {
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
                      return Expanded(
                        child: CommonWidget.primaryButton(
                          textStyle: buttonTextStyle,
                          context: context,
                          onPressed: () async {
                            final actionUrl =
                                '/experts/bookings/actions/${meetingScheduleModel.id}/reject/${meetingScheduleModel.notificationId}';
                            debugPrint('action url: $actionUrl');
                            if (actionUrl == null || actionUrl.isEmpty) return;

                            await ref
                                .read(acceptRejectBookingProvider.notifier)
                                .patchBookingAction(actionUrl);

                            final state = ref.read(acceptRejectBookingProvider);

                            state.when(
                              data: (response) async {
                                if (response?.success == true) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        response?.message ??
                                            "Action successful",
                                      ),
                                    ),
                                  );
                                  await ref
                                      .read(scheduleProvider.notifier)
                                      .refreshMeetings();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Action failed"),
                                    ),
                                  );
                                }
                              },
                              loading: () {},
                              error: (error, _) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Error: This booking has already been processed",
                                    ),
                                  ),
                                );
                              },
                            );

                            ref
                                .read(acceptRejectBookingProvider.notifier)
                                .reset();
                          },
                          text: "Cancel",
                          backgroundColor: Color(0xff2B2C31),
                        ),
                      );
                    },
                  ),
                  Expanded(
                    child: CommonWidget.primaryButton(
                      backgroundColor: AppColors.primary,
                      textStyle: buttonTextStyle?.copyWith(color: Colors.white),
                      context: context,
                      onPressed: () async {
                        final actionUrl =
                            '/experts/bookings/actions/${meetingScheduleModel.id}/accept/${meetingScheduleModel.notificationId}';
                        debugPrint('action url: $actionUrl');
                        if (actionUrl == null || actionUrl.isEmpty) return;

                        await ref
                            .read(acceptRejectBookingProvider.notifier)
                            .patchBookingAction(actionUrl);

                        final state = ref.read(acceptRejectBookingProvider);

                        state.when(
                          data: (response) async {
                            if (response?.success == true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    response?.message ?? "Action successful",
                                  ),
                                ),
                              );
                              await ref
                                  .read(scheduleProvider.notifier)
                                  .refreshMeetings();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Action failed")),
                              );
                            }
                          },
                          loading: () {},
                          error: (error, _) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Error: This booking has already been processed",
                                ),
                              ),
                            );
                          },
                        );

                        ref.read(acceptRejectBookingProvider.notifier).reset();
                      },
                      text: "Create Link",
                    ),
                  ),
                ],
              )
              : Row(
                spacing: 8.w,
                children: [
                  Consumer(
                    builder: (context, ref, __) {
                      return Expanded(
                        child: CommonWidget.primaryButton(
                          textStyle: buttonTextStyle,
                          context: context,
                          onPressed: () async {
                            if (meetingScheduleModel.status == 'COMPLETED') {
                              /// Nothing
                              // final notifier = ref.read(
                              //   completeScheduleProvider.notifier,
                              // );
                              //
                              // await notifier.completeScheduleMeeting(
                              //   meetingScheduleModel.id,
                              // );
                              //
                              // final result = ref.read(completeScheduleProvider);
                              //
                              // result.when(
                              //   data: (message) {
                              //     if (message != null) {
                              //       ScaffoldMessenger.of(context).showSnackBar(
                              //         SnackBar(content: Text(message)),
                              //       );
                              //
                              //       ref
                              //       .read(scheduleProvider.notifier)
                              //       .refreshMeetings();
                              //     }
                              //   },
                              //   loading: () {},
                              //   error: (err, _) {
                              //     ScaffoldMessenger.of(context).showSnackBar(
                              //       SnackBar(content: Text("Error: $err")),
                              //     );
                              //   },
                              // );
                              //
                              // notifier.reset();
                            } else {
                              final actionUrl =
                                  '/experts/bookings/actions/${meetingScheduleModel.id}/reject';

                              if (actionUrl == null || actionUrl.isEmpty)
                                return;

                              await ref
                                  .read(acceptRejectBookingProvider.notifier)
                                  .patchBookingAction(actionUrl);

                              final state = ref.read(
                                acceptRejectBookingProvider,
                              );

                              state.when(
                                data: (response) async {
                                  if (response?.success == true) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          response?.message ??
                                              "Action successful",
                                        ),
                                      ),
                                    );
                                    await ref
                                        .read(scheduleProvider.notifier)
                                        .refreshMeetings();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Action failed"),
                                      ),
                                    );
                                  }
                                },
                                loading: () {},
                                error: (error, _) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Error: This booking has already been processed",
                                      ),
                                    ),
                                  );
                                },
                              );
                              ref
                                  .read(acceptRejectBookingProvider.notifier)
                                  .reset();
                            }
                          },
                          text:
                              meetingScheduleModel.status == "COMPLETED"
                                  ? "Completed"
                                  : "Cancel",
                          backgroundColor: Color(0xff2B2C31),
                        ),
                      );
                    },
                  ),
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
                                content: Text("Link Can Not be Copied!"),
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
    } else {
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
                Consumer(
                  builder: (context, ref, __) {
                    return Expanded(
                      child: CommonWidget.primaryButton(
                        textStyle: buttonTextStyle,
                        context: context,
                        onPressed: () async {
                          try {
                            final result = await ref.read(
                              cancelScheduleProvider(
                                meetingScheduleModel.id.toString(),
                              ).future,
                            );

                            if (context.mounted) {
                              if (result) {
                                ref
                                    .read(scheduleProvider.notifier)
                                    .removeMeeting(meetingScheduleModel.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Meeting Cancelled Successfully",
                                    ),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Meeting Cancel Failed"),
                                  ),
                                );
                              }
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Error: $e")),
                              );
                            }
                          }
                        },
                        text: "Cancel",
                        backgroundColor: Color(0xff2B2C31),
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
                              content: Text("Link Can Not be Copied!"),
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
      } else {
        if (meetingScheduleModel.shouldReview == false &&
            meetingScheduleModel.shouldRefund == true) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12.h,
            children: [
              Text(
                meetingScheduleModel.status == "CANCELLED"
                    ? "Cancelled The Meeting"
                    : "No Response",
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.error,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(
                width: double.infinity,
                child: CommonWidget.primaryButton(
                  context: context,
                  onPressed: () {}, // todo refund
                  text: "Refund",
                  textStyle: buttonTextStyle,
                  backgroundColor: AppColors.error,
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
                    },
                    text: "Add Review",
                    textStyle: buttonTextStyle,
                  ),
                ),
              SizedBox(
                width: double.infinity,
                child: CommonWidget.primaryButton(
                  backgroundColor: Color(0xff2B2C31),
                  context: context,
                  onPressed: () {}, // todo view summary
                  text: "View Summary",
                  textStyle: buttonTextStyle,
                ),
              ),
            ],
          );
        }
      }
    }
  }
}
