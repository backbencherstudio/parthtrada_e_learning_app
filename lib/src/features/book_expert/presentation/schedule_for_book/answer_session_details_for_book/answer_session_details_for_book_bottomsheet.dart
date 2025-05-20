import 'package:e_learning_app/core/constant/padding.dart';
import 'package:e_learning_app/core/utils/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/theme/theme_part/app_colors.dart';

Future<void> answerSessionDetailsForBook({required BuildContext context}) async {
  await showModalBottomSheet(
    backgroundColor: Colors.transparent,
    useSafeArea: false,
    isScrollControlled: true,
    context: context,
    builder: (_){
      final textTheme = Theme.of(context).textTheme;
      return Container(
        decoration: BoxDecoration(
          color: AppColors.screenBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32.r),
            topRight: Radius.circular(32.r),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: AppPadding.screenHorizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 32.h,),
                Text("Session Details",style: textTheme.headlineSmall,),
                Text("Help us prepare for your session with Sarah Chen",style: textTheme.bodyMedium?.copyWith(color: AppColors.secondaryTextColor),),
                SizedBox(height: 12.h,),
                Divider(color: AppColors.secondary,height: 2,thickness: 2,),

                ListView.builder(
                  itemCount: 3,
                    padding: EdgeInsets.only(top: 16.h),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index){
                    return Column(
                      spacing: 12.h,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("What Specific topic would you like to discuss?",style: textTheme.titleMedium,),
                        TextFormField(
                          maxLines : 2,
                          decoration: InputDecoration(
                            hintText: "E.g., Implementing machine learning models in production",
                          ),
                        ),
                        SizedBox(height: 12.h,),
                      ],
                    );
                    }
                ),

                SizedBox(height: 32.h,),

                SafeArea(
                  child: Row(
                    spacing: 10.w,
                    children: [
                      Expanded(
                        child: CommonWidget.primaryButton(context: context, onPressed: (){
                          context.pop();
                        }, text: "Cancel", textStyle: textTheme.titleMedium,backgroundColor: AppColors.secondaryStrokeColor),
                      ),

                      Expanded(
                        child: CommonWidget.primaryButton(context: context, onPressed: (){}, text: "Next", textStyle: textTheme.titleMedium,),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 28.h,),
              ],
            ),
          ),
        ),
      );
    }
  );
}