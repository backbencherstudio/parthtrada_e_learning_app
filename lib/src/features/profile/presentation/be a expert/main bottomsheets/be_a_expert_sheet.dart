import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:e_learning_app/core/utils/common_widget.dart';
import 'package:e_learning_app/src/features/profile/presentation/be%20a%20expert/Riverpod/skill_selection_provider.dart';
import 'package:e_learning_app/src/features/profile/presentation/be%20a%20expert/main%20bottomsheets/session_details_bottomSheet.dart'
    show sessionDetailstBottomSheet;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../sub_feature/user profile/widget/custom_button.dart';
import '../sub bottomsheets/select_skills_sheet.dart';

Future<void> showBeExpertBottomSheet(BuildContext context) async {
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
                    child: CommonWidget.closeButton(context: context),
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
                    "Professional Skills",
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
                        child: Icon(Icons.add),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  //eikahne provider condition jaibo
                  Consumer(
                    builder: (context, ref, _) {
                      final selectedSkills = ref.watch(skillSelectionProvider);

                      return Wrap(
                        spacing: 8.w,
                        runSpacing: 8.h,
                        children:
                            selectedSkills.map((skill) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 6.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      skill,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium!.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.sp,
                                        color: Color(0xffD2D2D5),
                                      ),
                                    ),
                                    SizedBox(width: 6.w),
                                    GestureDetector(
                                      onTap: () {
                                        ref
                                            .read(
                                              skillSelectionProvider.notifier,
                                            )
                                            .remove(skill);
                                      },

                                      child: Icon(Icons.close),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                      );
                    },
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Hourly Rate",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Color(0xffffffff),
                    ),
                  ),
                  TextFormField(decoration: InputDecoration(hintText: "\$150")),
                  SizedBox(height: 16.h),
                  Text(
                    "Professional Bio",
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
                            sessionDetailstBottomSheet(context);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
