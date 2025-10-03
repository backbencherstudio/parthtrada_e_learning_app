import 'package:e_learning_app/core/constant/padding.dart';
import 'package:e_learning_app/core/utils/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/theme/theme_part/app_colors.dart';
import '../../../rvierpod/session_notifier.dart';
import '../../../rvierpod/session_provider.dart';
import '../select_duration_for_booking_bottom_sheet/select_duration_for_booking_bottom_sheet.dart';

Future<void> answerSessionDetailsForBook({
  required BuildContext context,
  required List<String> availableTime,
  required WidgetRef ref,
  required SessionDataNotifier sessionDataNotifier,
}) async {
  final TextEditingController textEditingController = TextEditingController();

  await showModalBottomSheet(
    backgroundColor: Colors.transparent,
    useSafeArea: false,
    isScrollControlled: true,
    context: context,
    builder: (context) {
      final textTheme = Theme.of(context).textTheme;

      return StatefulBuilder(
        builder: (_, StateSetter setState) {
          return DraggableScrollableSheet(
            expand: true,
            minChildSize: 0.3,
            maxChildSize: 0.8,
            initialChildSize: 0.7,
            builder: (_, scrollController) {
              return Container(
                margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                decoration: BoxDecoration(
                  color: AppColors.screenBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32.r),
                    topRight: Radius.circular(32.r),
                  ),
                ),
                child: Padding(
                  padding: AppPadding.screenHorizontal,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 32.h),
                        Text("Session Details", style: textTheme.headlineSmall),
                        Text(
                          "Help us prepare for your session",
                          style: textTheme.bodyMedium?.copyWith(color: AppColors.secondaryTextColor),
                        ),
                        SizedBox(height: 12.h),
                        Divider(color: AppColors.secondary, height: 2, thickness: 2),
                        SizedBox(height: 12.h),

                        /// Question Input
                        Text("What Specific topic would you like to discuss?", style: textTheme.titleMedium),
                        TextFormField(
                          controller: textEditingController,
                          maxLines: 2,
                          decoration: InputDecoration(
                            hintText: "E.g., Implementing machine learning models in production",
                          ),
                        ),

                        SizedBox(height: 32.h),

                        /// Cancel & Next Buttons
                        SafeArea(
                          child: Row(
                            children: [
                              // Expanded(
                              //   child: CommonWidget.primaryButton(
                              //     padding: EdgeInsets.symmetric(vertical: 16.h),
                              //     textStyle: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                              //     context: context,
                              //     onPressed: () {
                              //       context.pop();
                              //     },
                              //     text: "Cancel",
                              //     backgroundColor: AppColors.secondaryStrokeColor,
                              //   ),
                              // ),
                              // SizedBox(width: 10.w),
                              Expanded(
                                child: CommonWidget.primaryButton(
                                  padding: EdgeInsets.symmetric(vertical: 16.h),
                                  textStyle: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                                  context: context,
                                  onPressed: () async {
                                    final inputText = textEditingController.text.trim();
                                    if (inputText.isEmpty) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Please enter a topic to discuss')),
                                      );
                                      return;
                                    }
                                    sessionDataNotifier.setSessionDetails(textEditingController.text.trim());
                                    context.pop();
                                    await Future.delayed(const Duration(milliseconds: 200));

                                    await selectSessionTimeForBook(
                                      context: context,
                                      availableTime: availableTime,
                                    );
                                  },
                                  text: "Next",
                                  backgroundColor: textEditingController.text.isEmpty ? AppColors.secondaryStrokeColor : AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 28.h),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      );
    },
  );
}
