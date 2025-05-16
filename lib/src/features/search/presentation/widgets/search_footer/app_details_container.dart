import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/constant/icons.dart';
import '../../../../../../core/theme/theme_part/app_colors.dart';
import '../../../../../../core/utils/utils.dart';

class AppDetailsContainer extends StatelessWidget{
  const AppDetailsContainer({super.key});


  Widget appSuccessColumnMaker({
    required BuildContext context,
    required String iconPath,
    required String title,
    required String subTitle,
  })
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 4.h,
      children: [
        SvgPicture.asset(iconPath, width: 20.w, height: 20.h),
        Text(title, style: Theme.of(context).textTheme.bodyMedium),
        Text(subTitle, style: Theme.of(context).textTheme.labelMedium),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return           /// App Details
      Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        width: double.infinity,
        decoration: Utils.commonBoxDecoration(),
        child: FittedBox(
          child: Row(
            spacing: 18.w,
            children: [
              appSuccessColumnMaker(
                context: context,
                iconPath: AppIcons.trophyOutline,
                title: "2K+",
                subTitle: "Mentors",
              ),

              SizedBox(
                height: 43.h,
                width: 2.w,
                child: VerticalDivider(color: AppColors.dividerColor),
              ),

              appSuccessColumnMaker(
                context: context,
                iconPath: AppIcons.targetBoardOutline,
                title: "100K+",
                subTitle: "Sessions",
              ),

              SizedBox(
                height: 43.h,
                width: 2.w,
                child: VerticalDivider(color: AppColors.dividerColor),
              ),
              appSuccessColumnMaker(
                context: context,
                iconPath: AppIcons.usersOutline,
                title: "50K+",
                subTitle: "Users",
              ),

              SizedBox(
                height: 43.h,
                width: 2.w,
                child: VerticalDivider(color: AppColors.dividerColor),
              ),

              appSuccessColumnMaker(
                context: context,
                iconPath: AppIcons.starOutline,
                title: "4.9",
                subTitle: "Rating",
              ),
            ],
          ),
        ),
      );
  }
}