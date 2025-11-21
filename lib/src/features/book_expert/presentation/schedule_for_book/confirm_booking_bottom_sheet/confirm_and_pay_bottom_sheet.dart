import 'package:e_learning_app/core/constant/icons.dart';
import 'package:e_learning_app/core/utils/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../core/constant/padding.dart';
import '../../../../../../core/theme/theme_part/app_colors.dart';
import '../../../rvierpod/book_expert_riverpod.dart';
import '../../../rvierpod/session_provider.dart';
import 'confirm_book_details_card.dart';
import 'expert_booking_shimmer.dart';

Future<void> confirmBookingBottomSheet({
  required BuildContext context,
  required List<String> availableTime,
}) async {
  await showModalBottomSheet(
    backgroundColor: Colors.transparent,
    useSafeArea: true,
    isScrollControlled: true,
    context: context,
    builder: (bottomSheetContext) {
      final textTheme = Theme.of(bottomSheetContext).textTheme;
      final buttonTextStyle = textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w700,
        color: Colors.white,
      );

      return Consumer(
        builder: (context, ref, _) {
          final sessionData = ref.watch(sessionDataProvider);
          final bookExpertState = ref.watch(bookExpertRiverpod(availableTime));
          final bookExpertNotifier = ref.read(
            bookExpertRiverpod(availableTime).notifier,
          );

          return Container(
            constraints: BoxConstraints(maxHeight: 585.h, minHeight: 440.h),
            padding: AppPadding.screenHorizontal,
            decoration: BoxDecoration(
              color: AppColors.screenBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32.r),
                topRight: Radius.circular(32.r),
              ),
            ),
            child:
                bookExpertState.isConfirmLoading
                    ? Container(
                      constraints: BoxConstraints(
                        maxHeight: 400.h,
                        minHeight: 300.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.screenBackgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32.r),
                          topRight: Radius.circular(32.r),
                        ),
                      ),
                      child: Center(
                        child: Shimmer.fromColors(
                          baseColor: AppColors.secondary,
                          highlightColor: AppColors.screenBackgroundColor,
                          child: const ExpertBookingShimmer(),
                        ),
                      ),
                    )
                    : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 16.h),
                          Align(
                            alignment: Alignment.topRight,
                            child: CommonWidget.closeButton(
                              context: bottomSheetContext,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Container(
                            padding: EdgeInsets.all(20.r),
                            margin: EdgeInsets.only(bottom: 12.h),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.secondaryStrokeColor,
                            ),
                            child: SvgPicture.asset(
                              AppIcons.circleTikMarkFill,
                              width: 31.w,
                              height: 31.h,
                            ),
                          ),
                          Text(
                            "Confirm Booking",
                            style: textTheme.headlineSmall,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "Your session with ${sessionData.expertName} is scheduled",
                            style: textTheme.bodyMedium?.copyWith(
                              color: AppColors.secondaryTextColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 12.h),
                          ConfirmBookDetailsCard(),
                          SizedBox(height: 32.h),
                          SafeArea(
                            child: SizedBox(
                              width: double.infinity,
                              child: CommonWidget.primaryButton(
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                textStyle: buttonTextStyle,
                                context: bottomSheetContext,
                                text: "Done",
                                backgroundColor: AppColors.primary,
                                onPressed: () {
                                  bottomSheetContext.pop();
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 28.h),
                        ],
                      ),
                    ),
          );
        },
      );
    },
  );
}
