import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:e_learning_app/src/features/profile/presentation/be%20a%20expert/Riverpod/time_selection_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../sub_feature/user profile/widget/custom_button.dart';
import '../main bottomsheets/date_time_selection_sheet.dart';

void availabilityBottomSheet(BuildContext context) {
  final List<String> timeSlot = [
    "08:00 AM", "08:30 AM", "09:00 AM", "09:30 AM", "10:00 AM", "10:30 AM",
    "11:00 AM", "11:30 AM", "03:00 PM", "03:30 PM", "04:00 PM", "04:30 PM",
    "05:00 PM", "05:30 PM", "06:00 PM", "06:30 PM"
  ];

  final List<String> days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri"];

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Consumer(
        builder: (context, ref, _) {
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
                        "Availability",
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                      ),
                      const Divider(thickness: 1, color: Color(0xff2B2C31)),
                      SizedBox(height: 16.h),
                      Text("Available Days",
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              )),
                      SizedBox(height: 12.h),
                      Wrap(
                        spacing: 4.w,
                        runSpacing: 12.h,
                        children: days.map((day) {
                          final isSelected = availability.days.contains(day);
                          return GestureDetector(
                            onTap: () => notifier.toggleDay(day),
                            child: Container(
                              height: 36.h,
                              width: 75.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(41.r),
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.secondaryButtonBgColor,
                              ),
                              child: Center(
                                child: Text(
                                  day,
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 16.h),
                      Text("Available Times",
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              )),
                      SizedBox(height: 12.h),



                      Wrap(
                        spacing: 4.w,
                        runSpacing: 12.h,
                        children: timeSlot.map((slot) {
                          final isSelected = availability.times.contains(slot);
                          return GestureDetector(
                            onTap: () => notifier.toggleTime(slot),
                            child: Container(
                              height: 36.h,
                              width: 75.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(41.r),
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.secondaryButtonBgColor,
                              ),
                              child: Center(
                                child: Text(
                                  slot,
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 15.h),
                      Row(
                        children: [
                          Expanded(
                            child: Mybutton(
                              color: const Color(0xff2B2C31),
                              text: "Back",
                              onTap: () {
                                Navigator.pop(context);
                                timeDateSelectionBottomSheet(context);
                              },
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Mybutton(
                              color: AppColors.primary,
                              text: "Done",
                              onTap: () {
                                final selectedDays = availability.days;
                                final selectedTimes = availability.times;
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
    },
  );
}
