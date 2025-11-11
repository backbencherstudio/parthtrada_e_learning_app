import 'package:e_learning_app/core/utils/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../core/constant/padding.dart';
import '../../../../../../core/theme/theme_part/app_colors.dart';
import '../../../rvierpod/book_expert_riverpod.dart';
import '../../../rvierpod/session_provider.dart';
import '../payment_bottom_sheet.dart';
import 'confirm_book_details_card.dart';
import 'expert_booking_shimmer.dart';

Future<void> confirmAndPayBottomSheet({
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
                          Text(
                            "Confirm Booking",
                            style: textTheme.bodyMedium?.copyWith(
                              color: AppColors.textColor,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
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
                                textStyle: textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                                context: bottomSheetContext,
                                text: "Confirm & Pay",
                                backgroundColor: AppColors.primary,
                                onPressed: () {
                                  Future.microtask(() async {
                                    await bookExpertNotifier.onConfirmBooking();
                                    if (bottomSheetContext.mounted) {
                                      bottomSheetContext.pop();
                                      await Future.delayed(
                                        const Duration(milliseconds: 200),
                                      );
                                      if (bottomSheetContext.mounted) {
                                        await paymentBottomSheet(
                                          context: bottomSheetContext,
                                          availableTime: availableTime,
                                        );
                                      }
                                    }
                                  });
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
