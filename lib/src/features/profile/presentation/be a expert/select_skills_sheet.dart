import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:e_learning_app/src/features/profile/presentation/be%20a%20expert/session_details_bottomSheet.dart';
import 'package:e_learning_app/src/features/profile/presentation/be%20a%20expert/sub%20widgets/custom_skill_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../user profile/widget/custom_button.dart';
import 'be_a_expert_sheet.dart';
import 'date_time_selection_sheet.dart';

void selectSkillsBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return IntrinsicHeight(
        child: ClipPath(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: AppColors.screenBackgroundColor,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(32),
                bottom: Radius.circular(32),
              ),
            ),
            child: Padding(
              padding:  EdgeInsets.only(left: 8.w, right: 8.w),            
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: ClipOval(
                      child: SizedBox(
                        height: 22.h,
                        width: 22.w,
                        child: CircleAvatar(
                          backgroundColor: AppColors.secondaryStrokeColor,
                          child: Icon(Icons.close),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Select Skills",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Color(0xffffffff),
                    ),
                  ),
                 Column(
                   children: [
                    CustomSkillCheck( text:"Machine Learning", onTap: (){}),
                    CustomSkillCheck( text:"System Design", onTap: (){}),
                    CustomSkillCheck( text:"Cloud Architecture", onTap: (){}),
                    CustomSkillCheck( text:"Frontend Development", onTap: (){}),

                   ], 
                 ),
                
              SizedBox(height: 15.h,),
               Center(
                 child: Mybutton(color: AppColors.primary, text: "Done", onTap: () {
                   Navigator.pop(context);
                    showBeExpertBottomSheet(context);
                 },),
               ),
              
              SizedBox(height: 15.h,)
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}