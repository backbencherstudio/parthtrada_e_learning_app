import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/constant/logos.dart';
import '../../../../../../core/utils/utils.dart';

class AppMentorsShow extends StatelessWidget {
  const AppMentorsShow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      width: double.infinity,
      decoration: Utils.commonBoxDecoration(),
      child: FittedBox(
        child: Column(
          spacing: 16.h,
          children: [
            Text("Our mentors are from"),
            Row(
              spacing: 30.w,
              children: [
                Image.asset(AppLogos.google, width: 58.w),
                Image.asset(AppLogos.meta, width: 30.w),
                Image.asset(AppLogos.tesla, width: 19.w, height: 19.h),
                Image.asset(AppLogos.microsoft, width: 94.w),

                //  ...mentorsLogoPath.map((logoPath) => Image.asset(logoPath,),),
              ],
            ),
            Text(
              "and many more",
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}
