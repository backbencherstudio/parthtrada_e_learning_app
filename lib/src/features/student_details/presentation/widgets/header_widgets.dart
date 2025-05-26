import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constant/icons.dart';
import '../../../../../core/constant/images.dart';
import '../../../../../core/utils/common_widget.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key, required this.textStyle});

  final TextTheme textStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: GestureDetector(
                  onTap: () => context.pop(),

                  child: SvgPicture.asset(AppIcons.backlongArrow),
                ),
              ),
              Expanded(child: SizedBox()),
              Expanded(child: SizedBox()),
              Expanded(child: SizedBox()),
              Center(
                child: Image.asset(
                  AppImages.maiya,
                  height: 140.h,
                  width: 140.w,
                ),
              ),
              Expanded(child: SizedBox()),
              Expanded(child: SizedBox()),
              Expanded(child: SizedBox()),
              Expanded(child: SizedBox()),
            ],
          ),
        ),
        SizedBox(height: 20.h),
        Text(
          "Jenny Wilson",
          style: textStyle.titleSmall!.copyWith(
            fontWeight: FontWeight.w700,
            color: Color(0xffffffff),
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          "Student at Dhaka University",
          style: textStyle.bodyMedium!.copyWith(
            fontWeight: FontWeight.w400,
            color: Color(0xffA5A5AB),
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            SvgPicture.asset(AppIcons.locationPin),
            SizedBox(width: 6.w),
            Text('USA', style: textStyle.labelSmall),
          ],
        ),
        SizedBox(height: 10.h),
        CommonWidget.primaryButton(
          context: context,
          onPressed: () {},
          text: 'Message',
        ),
      ],
    );
  }
}
