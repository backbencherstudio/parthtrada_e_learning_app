import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../../core/theme/theme_part/app_colors.dart';
import '../../data/model/transaction_history_response.dart';

class TransactionHistoryCard extends StatelessWidget {
  final bool isRefunded;
  final bool isWithdraw;
  final Data transaction;
  final bool isExpert;

  const TransactionHistoryCard({
    super.key,
    required this.isRefunded,
    required this.isWithdraw,
    required this.transaction,
    required this.isExpert,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transaction.name ?? 'Unknown',
                style: textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                DateFormat('yyyy-MM-dd, hh:mm a').format(
                    DateTime.parse(transaction.createdAt ?? DateTime.now().toIso8601String())),
                style: textTheme.labelSmall!.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 2.h),
              if (isRefunded)
                Text(
                  'Refunded',
                  style: textTheme.labelSmall!.copyWith(
                    color: AppColors.refundedColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              if (isWithdraw)
                Text(
                  'Withdrawn',
                  style: textTheme.labelSmall!.copyWith(
                    color: AppColors.error,
                    fontWeight: FontWeight.w800,
                  ),
                ),
            ],
          ),
          Text(
            '${getBalanceIcon()} \$${transaction.amount?.toStringAsFixed(2) ?? '0.00'}',
            style: textTheme.labelMedium!.copyWith(
              color: isWithdraw
                  ? AppColors.error
                  : isRefunded
                  ? AppColors.refundedColor
                  : isExpert
                  ? AppColors.primary
                  : AppColors.error,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  String getBalanceIcon() {
    if (isWithdraw) return '-';
    return isExpert ? (isRefunded ? '-' : '+') : (isRefunded ? '+' : '-');
  }
}