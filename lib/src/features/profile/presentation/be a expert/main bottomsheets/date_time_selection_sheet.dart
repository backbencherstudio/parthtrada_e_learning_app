import 'package:e_learning_app/core/constant/icons.dart';
import 'package:e_learning_app/core/routes/route_name.dart';
import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:e_learning_app/src/features/profile/presentation/be%20a%20expert/Riverpod/time_selection_provider.dart';
import 'package:e_learning_app/src/features/profile/presentation/be%20a%20expert/main%20bottomsheets/session_details_bottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../data/models/user_profile.dart';
import '../../../sub_feature/user profile/widget/custom_button.dart';
import '../sub bottomsheets/time_availability_sheet.dart';
import '../Riverpod/skill_selection_provider.dart';

void timeDateSelectionBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Consumer(
        builder: (context, ref, _) {
          return _TimeDateSelectionBottomSheet();
        },
      );
    },
  );
}

class _TimeDateSelectionBottomSheet extends ConsumerStatefulWidget {
  @override
  ConsumerState<_TimeDateSelectionBottomSheet> createState() => _TimeDateSelectionBottomSheetState();
}

class _TimeDateSelectionBottomSheetState extends ConsumerState<_TimeDateSelectionBottomSheet> {
  final TextEditingController experienceController = TextEditingController();
  String? errorMessage;
  bool isSaving = false;

  @override
  void dispose() {
    experienceController.dispose();
    super.dispose();
  }

  Future<void> onDone() async {
    final experience = experienceController.text.trim();
    final availability = ref.read(availabilityProvider);

    if (experience.isEmpty) {
      setState(() {
        errorMessage = 'Please enter your experience';
      });
      return;
    }
    if (availability.days.isEmpty) {
      setState(() {
        errorMessage = 'Please select at least one available day';
      });
      return;
    }
    if (availability.times.isEmpty) {
      setState(() {
        errorMessage = 'Please select at least one available time';
      });
      return;
    }

    setState(() {
      isSaving = true;
      errorMessage = null;
    });

    ref.read(skillSelectionProvider.notifier).updateProfileData(
      UserProfile(
        experience: experience,
        availableDays: availability.days.toList(),
        availableTime: availability.times.toList(),
      ),
    );

    final success = await ref.read(skillSelectionProvider.notifier).saveExpertProfile();

    setState(() {
      isSaving = false;
    });

    if (success) {
      Navigator.pop(context);
      context.pushReplacement(RouteName.splash);
    } else {
      setState(() {
        errorMessage = ref.read(skillSelectionProvider.notifier).errorMessage ?? 'Failed to save profile';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availability = ref.watch(availabilityProvider);
    final notifier = ref.read(availabilityProvider.notifier);

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
            padding: EdgeInsets.symmetric(horizontal: 8.w),
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
                        },
                        child: CircleAvatar(
                          backgroundColor: AppColors.secondaryStrokeColor,
                          child: const Icon(Icons.close),
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  "Session Details",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const Divider(thickness: 1, color: Color(0xff2B2C31)),
                SizedBox(height: 16.h),
                Text(
                  "Experience",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                TextFormField(
                  controller: experienceController,
                  decoration: const InputDecoration(hintText: "4"),
                ),
                SizedBox(height: 16.h),
                Text(
                  "Available Time",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Select Time",
                    suffixIcon: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        availabilityBottomSheet(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset(
                          AppIcons.calender,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                if (availability.days.isNotEmpty || availability.times.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 12.h),
                      // Days
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: availability.days.map((day) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(41.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  day,
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                GestureDetector(
                                  onTap: () => notifier.toggleDay(day),
                                  child: Icon(Icons.close, color: Colors.white, size: 16),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 12.h),
                      // Times
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: availability.times.map((time) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(41.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  time,
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                GestureDetector(
                                  onTap: () => notifier.toggleTime(time),
                                  child: Icon(Icons.close, color: Colors.white, size: 16),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
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
                        text: "Back",
                        onTap: () {
                          Navigator.pop(context);
                          sessionDetailstBottomSheet(context);
                        },
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Mybutton(
                        color: AppColors.primary,
                        text: isSaving ? "Saving..." : "Done",
                        onTap: isSaving ? null : onDone,
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
  }
}