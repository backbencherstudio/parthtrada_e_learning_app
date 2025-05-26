import 'package:e_learning_app/core/utils/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../../core/constant/icons.dart';
import '../../../../../../../core/theme/theme_part/app_colors.dart';

class ScheduleContainerFooterForExpertRole extends StatelessWidget {
  const ScheduleContainerFooterForExpertRole({
    super.key,
    this.isMeetingCreated = true,
  });

  final bool isMeetingCreated;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final buttonTextStyle = textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.w800,
    );
    return Column(
      spacing: 12.h,
      children: [
        Row(
          spacing: 8.w,
          children: [
            SvgPicture.asset(AppIcons.calendar),
            Text(
              "June 1 Monday 02:00 PM",
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.secondaryTextColor,
              ),
            ),
          ],
        ),

        Row(
          spacing: 8.w,
          children: [
            Expanded(
              child: CommonWidget.primaryButton(
                textStyle: buttonTextStyle,
                context: context,
                onPressed: () {},
                text: isMeetingCreated ? "Completed" : "Cancel",
                backgroundColor: Color(0xff2B2C31),
              ),
            ),

            Expanded(
              child: CommonWidget.primaryButton(
                textStyle: buttonTextStyle,
                context: context,
                onPressed: () {},
                text: isMeetingCreated ? "Copy Link" : "Create Meeting",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
