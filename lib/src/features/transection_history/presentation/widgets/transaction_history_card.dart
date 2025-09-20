import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/theme_part/app_colors.dart';

class TransactionHistoryCard extends StatelessWidget {
  final bool isRefunded;
  const TransactionHistoryCard({super.key, required this.isRefunded});

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
                'Sarah Chen',
                style: textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),

              SizedBox(height: 2.h),

              Text(
                '08:30pm, 05/04/25',
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
            ],
          ),
          Text(
            '${getBalanceIcon()} \$150',
            style: textTheme.labelMedium!.copyWith(
              color: isRefunded ? AppColors.refundedColor : AppColors.error,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  String getBalanceIcon() {
    return isRefunded ? '+' : '-';
  }
}
