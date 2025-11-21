// expert_ratings_summary.dart
import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../core/constant/icons.dart';
import '../../../model/expert_detail_model.dart';

class ExpertRatingsSummary extends StatelessWidget {
  final Stats? stats;
  const ExpertRatingsSummary({super.key, this.stats});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Reviews", style: textTheme.headlineSmall),
        SizedBox(height: 10.h),
        //Image.asset(AppImages.women, width: 32.w, height: 32.w, fit: BoxFit.cover),
        SizedBox(height: 30.h),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${stats?.averageRating ?? 0}",
                  style: textTheme.bodyMedium?.copyWith(fontSize: 56.sp),
                ),
                Row(
                  children: List.generate(
                    5, /// todo handle the stars in the future cause no data type is founded to handle this star count
                    (index) => SvgPicture.asset(
                      AppIcons.starFill,
                      colorFilter: const ColorFilter.mode(
                        Color(0xffF6A14B),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                Text(
                  "${stats?.totalReviews ?? 0} Reviews",
                  style: textTheme.labelMedium,
                ),
              ],
            ),
            SizedBox(width: 25.w),
            Expanded(
              child: Column(
                spacing: 2.h,
                children: List.generate(5, (index) {
                  final ratingData = stats?.ratingDistribution?[index];
                  final percentage = double.tryParse(ratingData?.percentage ?? '') ?? 0.0;
                  return Row(
                    children: [
                      Text(
                        (5 - index).toString(),
                        style: textTheme.labelMedium,
                      ),
                      SizedBox(width: 18.w),
                      Expanded(
                        child: LinearProgressIndicator(
                          borderRadius: BorderRadius.circular(20.r),
                          minHeight: 8.h,
                          value: percentage,
                          color: AppColors.primary,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
