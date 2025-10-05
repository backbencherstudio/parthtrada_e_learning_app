import 'package:e_learning_app/core/utils/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/constant/padding.dart';
import '../../../../../../core/theme/theme_part/app_colors.dart';
import '../../rvierpod/get_card_notifier.dart';
import '../../rvierpod/payment_provider.dart';
import 'confirm_booking_bottom_sheet/confirm_and_pay_bottom_sheet.dart';

class PaymentConstants {
  static const selectPaymentMethod = "Select your payment method to proceed";
  static const noCardsFound = "No cards found";
  static const paymentProcessing = "Processing...";
  static const paymentProceed = "Proceed with Payment";
  static const paymentFailed = "Payment failed. Please try again.";
}

Future<void> paymentBottomSheet({
  required BuildContext context,
  required List<String> availableTime,
}) async {
  await showModalBottomSheet(
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    context: context,
    builder: (bottomSheetContext) {
      final textTheme = Theme.of(bottomSheetContext).textTheme;
      final buttonTextStyle = textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w700,
      );

      return Consumer(
        builder: (context, ref, _) {
          final cardState = ref.watch(cardProvider);

          // Fetch cards once if not yet fetched
          if (!cardState.isLoading &&
              cardState.cardsResponse == null &&
              cardState.error == null) {
            Future.microtask(() => ref.read(cardProvider.notifier).fetchCards());
          }

          final selectedMethodId = ref.watch(selectedCardMethodIdProvider);

          return Container(
            constraints: BoxConstraints(maxHeight: 400.h, minHeight: 300.h),
            padding: AppPadding.screenHorizontal,
            decoration: BoxDecoration(
              color: AppColors.screenBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32.r),
                topRight: Radius.circular(32.r),
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 16.h),
                Text(
                  PaymentConstants.selectPaymentMethod,
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.secondaryTextColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.h),

                // Card List
                Expanded(
                  child: cardState.isLoading
                      ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  )
                      : cardState.error != null
                      ? Center(
                    child: Text(
                      cardState.error!,
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.error,
                      ),
                    ),
                  )
                      : (cardState.cardsResponse?.data.isEmpty ?? true)
                      ? Center(
                    child: Text(
                      PaymentConstants.noCardsFound,
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.secondaryTextColor,
                      ),
                    ),
                  )
                      : ListView.builder(
                    itemCount:
                    cardState.cardsResponse?.data.length ?? 0,
                    itemBuilder: (context, index) {
                      final card =
                      cardState.cardsResponse!.data[index];
                      final isSelected =
                          selectedMethodId == card.methodId;

                      return GestureDetector(
                        onTap: () {
                          ref
                              .read(selectedCardMethodIdProvider
                              .notifier)
                              .state = card.methodId;
                          debugPrint(
                              'Selected card: ${card.methodId}');
                        },
                        child: Container(
                          height: 50.h,
                          width: double.infinity,
                          margin: EdgeInsets.only(bottom: 16.h),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius:
                            BorderRadius.circular(10.r),
                            border: isSelected
                                ? Border.all(
                              color: AppColors.primary,
                              width: 2,
                            )
                                : null,
                          ),
                          child: Center(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '**** **** **** ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      height: 1.2,
                                    ),
                                  ),
                                  TextSpan(
                                    text: card.last4,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: 16.h),
                SizedBox(
                  width: double.infinity,
                  child: CommonWidget.primaryButton(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    textStyle: buttonTextStyle,
                    context: bottomSheetContext,
                    text: ref.watch(paymentNotifierProvider).isLoading
                        ? PaymentConstants.paymentProcessing
                        : PaymentConstants.paymentProceed,
                    onPressed: () => _handlePayment(
                      ref,
                      bottomSheetContext,
                      context,
                      availableTime,
                    ),
                  ),
                ),
                SizedBox(height: 28.h),
              ],
            ),
          );
        },
      );
    },
  );
}

Future<void> _handlePayment(
    WidgetRef ref,
    BuildContext bottomSheetContext,
    BuildContext context,
    List<String> availableTime,
    ) async {
  final notifier = ref.read(paymentNotifierProvider.notifier);

  try {
    final success = await notifier.confirmPayment();

    if (success && bottomSheetContext.mounted) {
      Navigator.of(bottomSheetContext).pop();
      await Future.delayed(const Duration(milliseconds: 200));

      if (context.mounted) {
        await confirmBookingBottomSheet(
          context: context,
          availableTime: availableTime,
        );
      }
    } else if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(PaymentConstants.paymentFailed),
        ),
      );
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }
}