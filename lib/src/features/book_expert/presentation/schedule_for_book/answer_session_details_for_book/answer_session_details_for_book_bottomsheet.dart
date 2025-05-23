import 'package:e_learning_app/core/constant/padding.dart';
import 'package:e_learning_app/core/utils/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/theme/theme_part/app_colors.dart';
import '../select_duration_for_booking_bottom_sheet/select_duration_for_booking_bottom_sheet.dart';

Future<void> answerSessionDetailsForBook({required BuildContext context}) async {
  await showModalBottomSheet(
    backgroundColor: Colors.transparent,
    useSafeArea: false,
    isScrollControlled: true,
    context: context,
    builder: (_){
      final textTheme = Theme.of(context).textTheme;
      return DraggableScrollableSheet(
        expand: true,
        minChildSize: 0.3,
        maxChildSize: 0.8,
        initialChildSize: 0.7,

        builder: (_, scrollController) {
          return Container(
            margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            decoration: BoxDecoration(
              color: AppColors.screenBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32.r),
                topRight: Radius.circular(32.r),
              ),
            ),
            child: Padding(
              padding: AppPadding.screenHorizontal,
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 32.h,),
                    Text("Session Details",style: textTheme.headlineSmall,),
                    Text("Help us prepare for your session with Sarah Chen",style: textTheme.bodyMedium?.copyWith(color: AppColors.secondaryTextColor),),
                    SizedBox(height: 12.h,),
                    Divider(color: AppColors.secondary,height: 2,thickness: 2,),
                    SizedBox(height: 12.h,),

                    /// Listview of question answer
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

                    /// Cancel or Next Button
                    SafeArea(
                      child: Row(
                        spacing: 10.w,
                        children: [
                          Expanded(
                            child: CommonWidget.primaryButton(
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                textStyle: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                                context: context, onPressed: (){
                              context.pop();
                            }, text: "Cancel", backgroundColor: AppColors.secondaryStrokeColor),
                          ),

                          Expanded(
                            child: CommonWidget.primaryButton(
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              textStyle: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                              context: context,
                              onPressed: () async {
                                context.pop();
                               await selectSessionTimeForBook(context: context);
                              },
                              text: "Next",
                              ),
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
  );
}