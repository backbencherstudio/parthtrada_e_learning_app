import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../user profile/widget/custom_button.dart';
import 'select_skills_sheet.dart';
import 'session_details_bottomSheet.dart';
void showBeExpertBottomSheet(BuildContext context) {
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
                    "Session Details",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Color(0xffffffff),
                    ),
                  ),
                  Divider(thickness: 1,
                    color: Color(0xff2B2C31),
                  ),
                  SizedBox(height: 16.h),
                  Text("Professional Skills",
                   style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Color(0xffffffff),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Select Skills",
                      suffixIcon: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          selectSkillsBottomSheet(context);
                          //new bottomSheet

                        },
                        child: Icon(Icons.add))
                    ),
                  ),
                  //eikahne provider condition jaibo

                  SizedBox(height: 16.h),
                  Text("Hourly Rate",
                   style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Color(0xffffffff),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "\$150",
                    ),
                  ),
                   SizedBox(height: 16.h),
                  Text("Professional Bio",
                   style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Color(0xffffffff),
                    ),
                  ),
                  SizedBox(
                width: 326.w,
                height: 127.h,
                child: TextFormField(
                  expands: false,
                  maxLines: 5,
                  minLines: 3,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(hintText: "Description"),
                ),
              ),
              SizedBox(height: 15.h,),
               Row(
                children: [
                  Expanded(
                    child: Mybutton(color: Color(0xff2B2C31), text: "Discard", onTap: () {
                      Navigator.pop(context);
                    },),
                  ),
                  SizedBox(width: 8.w,),
                  Expanded(
                    child: Mybutton(color:AppColors.primary , text: "Save", onTap: () {
                    Navigator.pop(context);
                    sessionDetailsBottomSheet(context);
                    },),
                  )
                ],
              ),
              SizedBox(height: 10.h,)
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
