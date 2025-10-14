import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/theme/theme_part/app_colors.dart';

class ExpertDetailsSummaryContainer extends StatelessWidget {
  const ExpertDetailsSummaryContainer({
    super.key,
    required this.headerText,
    required this.bodyText,
    required this.svgIconAssetPath,
  });
  final String headerText;
  final String bodyText;
  final String svgIconAssetPath;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.only(right: 6.w),
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: AppColors.secondary,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          spacing: 6.h,
          children: [
            Text(
              headerText,
              style: textTheme.labelMedium?.copyWith(color: AppColors.primary),
            ),

            Row(
              spacing: 4.w,
              children: [
                SvgPicture.asset(
                  svgIconAssetPath,
                  width: 20.w,
                  height: 20.h,
                  colorFilter: ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
                Expanded(
                  child: Text(
                    bodyText,
                    style: textTheme.bodyLarge?.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
