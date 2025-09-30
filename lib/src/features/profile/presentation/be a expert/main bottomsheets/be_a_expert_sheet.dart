import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:e_learning_app/core/utils/common_widget.dart';
import 'package:e_learning_app/src/features/profile/presentation/be%20a%20expert/Riverpod/skill_selection_provider.dart';
import 'package:e_learning_app/src/features/profile/presentation/be%20a%20expert/main%20bottomsheets/session_details_bottomSheet.dart'
    show sessionDetailstBottomSheet;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/models/user_profile.dart';
import '../../../sub_feature/user profile/widget/custom_button.dart';
import '../sub bottomsheets/select_skills_sheet.dart';

void showBeExpertBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return ProviderScope(
        child: BeExpertBottomSheet(),
      );
    },
  );
}

class BeExpertBottomSheet extends ConsumerStatefulWidget {
  @override
  ConsumerState<BeExpertBottomSheet> createState() => _BeExpertBottomSheetState();
}

class _BeExpertBottomSheetState extends ConsumerState<BeExpertBottomSheet> {
  final TextEditingController hourlyRateController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String? errorMessage;

  @override
  void dispose() {
    hourlyRateController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void onSave() {
    final hourlyRate = int.tryParse(hourlyRateController.text.trim());
    final description = descriptionController.text.trim();
    final selectedSkills = ref.read(skillSelectionProvider);

    if (selectedSkills.isEmpty) {
      setState(() {
        errorMessage = 'Please select at least one skill';
      });
      return;
    }
    if (hourlyRate == null || hourlyRate <= 0) {
      setState(() {
        errorMessage = 'Please enter a valid hourly rate';
      });
      return;
    }
    if (description.isEmpty) {
      setState(() {
        errorMessage = 'Please enter a description';
      });
      return;
    }

    ref.read(skillSelectionProvider.notifier).updateProfileData(
      UserProfile(
        hourlyRate: hourlyRate,
        description: description,
        skills: selectedSkills.toList(),
      ),
    );

    Navigator.pop(context);
    sessionDetailstBottomSheet(context);
  }

  @override
  Widget build(BuildContext context) {
    final selectedSkills = ref.watch(skillSelectionProvider);
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
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: CommonWidget.closeButton(context: context),
                ),
                Text(
                  "Session Details",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xffffffff),
                  ),
                ),
                const Divider(thickness: 1, color: Color(0xff2B2C31)),
                SizedBox(height: 16.h),
                Text(
                  "Professional Skills",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: const Color(0xffffffff),
                  ),
                ),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Select Skills",
                    suffixIcon: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        selectSkillsBottomSheet(context);
                      },
                      child: const Icon(Icons.add),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: selectedSkills.map((skill) {
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
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,
                              color: const Color(0xffD2D2D5),
                            ),
                          ),
                          SizedBox(width: 6.w),
                          GestureDetector(
                            onTap: () {
                              ref.read(skillSelectionProvider.notifier).remove(skill);
                            },
                            child: const Icon(Icons.close),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16.h),
                Text(
                  "Hourly Rate",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: const Color(0xffffffff),
                  ),
                ),
                TextFormField(
                  controller: hourlyRateController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: "\$150",
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  "Professional Bio",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: const Color(0xffffffff),
                  ),
                ),
                SizedBox(
                  width: 326.w,
                  height: 127.h,
                  child: TextFormField(
                    controller: descriptionController,
                    expands: false,
                    maxLines: 5,
                    minLines: 3,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: const InputDecoration(
                      hintText: "Description",
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                if (errorMessage != null) ...[
                  Text(
                    errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                  SizedBox(height: 10.h),
                ],
                Row(
                  children: [
                    Expanded(
                      child: Mybutton(
                        color: const Color(0xff2B2C31),
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
                        onTap: onSave,
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
  }
}