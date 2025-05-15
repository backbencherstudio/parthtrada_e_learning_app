// ignore_for_file: deprecated_member_use

import 'package:e_learning_app/core/constant/icons.dart';
import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../user profile/widget/custom_button.dart';
import 'time_availability_sheet.dart';

void timeDateSelectionBottomSheet(BuildContext context) {
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
                  Divider(thickness: 1, color: Color(0xff2B2C31)),
                  SizedBox(height: 16.h),
                  Text(
                    "Experience",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Color(0xffffffff),
                    ),
                  ),
                  TextFormField(decoration: InputDecoration(hintText: "4")),

                  //eikahne provider condition jaibo
                  SizedBox(height: 16.h),
                  Text(
                    "Available Time",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Color(0xffffffff),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Select Time",
                      suffixIcon: GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              availabilityBottomSheet(context);
                            },
                            child: SvgPicture.asset(AppIcons.calender,
                            color: Color(0xfffffffff),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),

                  Row(
                    children: [
                      Expanded(
                        child: Mybutton(
                          color: Color(0xff2B2C31),
                          text: "Back",
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Mybutton(
                          color: AppColors.primary,
                          text: "Done",
                          onTap: () {},
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
