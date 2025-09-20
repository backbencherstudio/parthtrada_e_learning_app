import 'package:e_learning_app/core/constant/padding.dart';
import 'package:e_learning_app/core/routes/route_name.dart';
import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class OnboardingPageWidget extends StatelessWidget {
  const OnboardingPageWidget({
    super.key,
    required this.heading,
    required this.bodyText,
    required this.imagePath,
    required this.tabController,
    required this.buttonText,
  });

  final TabController tabController;
  final String heading;
  final String bodyText;
  final String imagePath;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: AppPadding.screenHorizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 16.h,
        children: [
          /// Top gap of header
          SizedBox(height: 50.h,),

          /// Heading
          Text(heading, style: textTheme.headlineMedium),
          Text(
            bodyText,
            style: textTheme.bodyMedium?.copyWith(
              color: AppColors.onBoardingSecondaryTextColor,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 30.h),

          /// Body Image and button
          SizedBox(
            width: 327.w,height: 410.h,
            child: Stack(
              children: [
                Image.asset(imagePath,width: 327.w,height: 400.h,),

                Positioned(
                  left: 30.w,
                  right: 30.w,
                  bottom: 0.h,
                  child: ElevatedButton(
                    onPressed: () {
                      final int nextIndex = tabController.index + 1;
                      if(tabController.index == tabController.length - 1){
                        context.go(RouteName.authenticationScreen);
                      }
                      else{
                        tabController.animateTo(
                          nextIndex,
                          duration: Duration(milliseconds: 2000),
                          //    curve: curve
                        );
                      }

                    },
                    child: Text(buttonText,style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700
                    ),),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
