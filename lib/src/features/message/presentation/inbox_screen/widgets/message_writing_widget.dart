import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/constant/icons.dart';
import '../../../../../../core/theme/theme_part/app_colors.dart';
class MessageWritingWidget extends StatelessWidget {
  const MessageWritingWidget({
    super.key,
    required this.textTheme,
  });

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 16.w,
      children: [
        Expanded(
          child: TextField(
            style: textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w400),
            decoration: InputDecoration(
              hintText: 'Type here...',
              fillColor: AppColors.secondary,
              filled: true,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.w
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(10.r)
          ),
          child: SvgPicture.asset(AppIcons.sendIcon),
        )
      ],
    );
  }
}