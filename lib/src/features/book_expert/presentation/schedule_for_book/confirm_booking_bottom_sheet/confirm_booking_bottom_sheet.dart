import 'package:e_learning_app/core/constant/icons.dart';
import 'package:e_learning_app/core/utils/common_widget.dart';
import 'package:e_learning_app/src/features/book_expert/rvierpod/session_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../core/constant/padding.dart';
import '../../../../../../core/theme/theme_part/app_colors.dart';
import '../../../../../../repository/api/expert/expert_booking.dart';
import '../../../model/session_model.dart';
import '../../../rvierpod/book_expert_riverpod.dart';
import '../payment_bottom_sheet.dart';
import 'confirm_book_details_card.dart';
import 'expert_booking_shimmer.dart';

Future<void> confirmAndPayBottomSheet({
  required BuildContext context,
  required List<String> availableTime,
}) async {
  await showModalBottomSheet(
    backgroundColor: Colors.transparent,
    useSafeArea: false,
    isScrollControlled: true,
    context: context,
    builder: (bottomSheetContext) {
      final textTheme = Theme.of(bottomSheetContext).textTheme;
      final buttonTextStyle = textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w700,
      );

      return Consumer(
        builder: (context, ref, _) {
          final sessionData = ref.read(sessionDataProvider);
          final bookExpertNotifier = ref.read(
            bookExpertRiverpod(availableTime).notifier,
          );
          final bookExpertState = ref.watch(bookExpertRiverpod(availableTime));

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
                    ? Center(
                      child: SizedBox(
                        width: double.infinity,
                        child: Shimmer.fromColors(
                          baseColor: AppColors.secondary,
                          highlightColor: AppColors.screenBackgroundColor,
                          child: ExpertBookingShimmer(),
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
                              fontWeight: FontWeight.w600
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
                                text: "Confirm & Pay",
                                onPressed: () async {
                                  await bookExpertNotifier.onConfirmBooking();
                                  debugPrint("Confirm Booking");

                                  Navigator.pop(bottomSheetContext);

                                  Future.delayed(
                                    const Duration(milliseconds: 200),
                                    () {
                                      paymentBottomSheet(context: context, availableTime: []);
                                    },
                                  );
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
