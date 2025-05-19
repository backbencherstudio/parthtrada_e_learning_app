import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:e_learning_app/src/features/profile/presentation/be%20a%20expert/main%20bottomsheets/be_a_expert_sheet.dart';
import 'package:e_learning_app/src/features/profile/presentation/be%20a%20expert/main%20bottomsheets/date_time_selection_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../user profile/widget/custom_button.dart';

void sessionDetailstBottomSheet(BuildContext context) {
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
              padding: EdgeInsets.only(left: 8.w, right: 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: ClipOval(
                      child: SizedBox(
                        height: 22.h,
                        width: 22.w,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            showBeExpertBottomSheet(context);
                          },
                          child: CircleAvatar(
                            backgroundColor: AppColors.secondaryStrokeColor,
                            child: Icon(Icons.close),
                          ),
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
                  Divider(thickness: 1, color: Color(0xff2B2C31)),
                  SizedBox(height: 16.h),
                  Text(
                    "Profession",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Color(0xffffffff),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Senior Data Scientist",
                    ),
                  ),
                

                  SizedBox(height: 16.h),
                  Text(
                    "Organization Name",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Color(0xffffffff),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Google"),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Location",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Color(0xffffffff),
                    ),
                  ),
                  TextFormField(decoration: InputDecoration(hintText: "USA")),
                  SizedBox(height: 15.h),
                  Row(
                    children: [
                      Expanded(
                        child: Mybutton(
                          color: Color(0xff2B2C31),
                          text: "Discard",
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Mybutton(
                          color: AppColors.primary,
                          text: "Save",
                          onTap: () {
                            Navigator.pop(context);
                            timeDateSelectionBottomSheet(context);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
