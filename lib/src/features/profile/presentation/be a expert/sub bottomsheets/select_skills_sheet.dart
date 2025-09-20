import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:e_learning_app/repository/api/expert/fetch_skills.dart';
import 'package:e_learning_app/src/features/onboarding/riverpod/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../sub_feature/be a expert/sub widgets/custom_skill_check.dart';
import '../../../sub_feature/user profile/widget/custom_button.dart';
import '../main bottomsheets/be_a_expert_sheet.dart';

void selectSkillsBottomSheet(BuildContext context, WidgetRef? ref) {
  final token = ref?.watch(authTokenProvider);
  ref?.read(skillsProvider.notifier).fetchSkills(token!);

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
                    "Select Skills",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Color(0xffffffff),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Consumer(
                    builder: (context, ref, _) {
                      final skills = ref.watch(skillsProvider);
                      if (skills?.success == true) {
                        final skillsList = skills?.data ?? [];
                        final selectedSkills =
                            ref
                                .watch(skillsProvider.notifier)
                                .getSelectedSkills();

                        return Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children:
                              skillsList.map((skill) {
                                return CustomSkillCheck(
                                  text: skill,
                                  isSelected: selectedSkills.contains(skill),
                                  onTap: () {
                                    ref
                                        .read(skillsProvider.notifier)
                                        .toggleSkill(skill);
                                  },
                                );
                              }).toList(),
                        );
                      } else {
                        final errorMessage =
                            skills?.message ??
                            "An error occurred while fetching skills";
                        return Center(child: Text(errorMessage));
                      }
                    },
                  ),

                  SizedBox(height: 119.h),
                  Center(
                    child: Mybutton(
                      color: AppColors.primary,
                      text: "Done",
                      onTap: () {
                        Navigator.pop(context);
                        showBeExpertBottomSheet(context);
                      },
                      width: 327.w,
                    ),
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
