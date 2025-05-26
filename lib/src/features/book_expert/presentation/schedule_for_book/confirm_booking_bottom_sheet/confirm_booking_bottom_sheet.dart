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
import 'confirm_book_details_card.dart';
import 'expert_booking_shimmer.dart';

Future<void> confirmBookingBottomSheet({required BuildContext context}) async {
  await showModalBottomSheet(
    backgroundColor: Colors.transparent,
    useSafeArea: false,
    isScrollControlled: true,
    context: context,
    builder: (_) {
      final textTheme = Theme.of(context).textTheme;
      final buttonTextStyle = textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w700,
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

        child: Consumer(
          builder: (_, ref, _) {
            final bookExpertNotifier = ref.read(bookExpertRiverpod.notifier);
            final bookExpertState = ref.watch(bookExpertRiverpod);
            return bookExpertState.isConfirmLoading
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
                      Align(
                        alignment: Alignment.topRight,
                        child: CommonWidget.closeButton(context: context),
                      ),
                      SizedBox(height: 12.h),

                      if (bookExpertState.isSuccessfullyBooked)
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

                      Align(
                        alignment:
                            bookExpertState.isSuccessfullyBooked
                                ? Alignment.center
                                : Alignment.centerLeft,
                        child: Text(
                          "Confirm Booking",
                          style: textTheme.headlineSmall,
                        ),
                      ),

                      if (bookExpertState.isSuccessfullyBooked)
                        Column(
                          children: [
                            SizedBox(height: 8.h),
                            Text(
                              "Your season with Sarah Chen is Scheduled for Wed 10 am",
                              style: textTheme.bodyMedium?.copyWith(
                                color: AppColors.secondaryTextColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
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
                            context: context,
                            onPressed: () {
                              if (bookExpertState.isSuccessfullyBooked) {
                                context.pop();
                              }
                              bookExpertNotifier.onConfirmBooking();
                            },
                            text:
                                bookExpertState.isSuccessfullyBooked
                                    ? "Done"
                                    : "Confirm & Pay",
                          ),
                        ),
                      ),

                      SizedBox(height: 28.h),
                    ],
                  ),
                );
          },
        ),
      );
    },
  );
}
