import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/theme_part/app_colors.dart';
import '../../../../../core/utils/common_widget.dart';

class ExpertDetailsBottomBackButton extends StatelessWidget{
  const ExpertDetailsBottomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 24.w,right: 24.w,bottom: 16.h,top: 16.h),
      decoration: BoxDecoration(
          color: AppColors.secondary
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: CommonWidget.primaryButton(
              padding: EdgeInsets.all(16.r),
              context: context,
              onPressed: (){
                debugPrint("\nExpert\n");
              },
              text: "Book \$150/hour"),
        ),
      ),
    );
  }
}