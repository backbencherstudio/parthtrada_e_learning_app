import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/theme_part/app_colors.dart';
import '../../../../../core/utils/common_widget.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({super.key, required this.textStyle});

  final TextTheme textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 16.h,
        left: 24.w,
        right: 24.w,
        bottom: 24.h,
      ),
      color: AppColors.secondary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Jenny Wilson', style: textStyle.titleMedium),
          RichText(
            text: TextSpan(
              style: textStyle.bodySmall!.copyWith(
                color: AppColors.onSurface,
              ), // Default text style
              children: <TextSpan>[
                TextSpan(
                  text:
                      'Wants to take your consultation on June 13th at 3 PM. For ',
                ),
                TextSpan(
                  text: '30', // This is the text that will be white
                  style: textStyle.bodySmall!.copyWith(
                    color: AppColors.onPrimary,
                  ), // Default text style
                ),
                TextSpan(text: ' Min'),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: CommonWidget.primaryButton(
                  context: context,
                  onPressed: () {},
                  text: 'Decline',
                  backgroundColor: AppColors.secondaryStrokeColor,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: CommonWidget.primaryButton(
                  context: context,
                  onPressed: () {},
                  text: 'Accept',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
