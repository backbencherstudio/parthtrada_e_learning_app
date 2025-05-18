import 'package:e_learning_app/core/constant/icons.dart';
import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:e_learning_app/src/features/profile/presentation/be%20a%20expert/Riverpod/time_selection_provider.dart';
import 'package:e_learning_app/src/features/profile/presentation/be%20a%20expert/session_details_bottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
                                        )
                                      ),
                                      SizedBox(width: 4.w),
                                      GestureDetector(
                                        onTap: () => notifier.toggleDay(day),
                                        child:  Icon(Icons.close, color: Colors.white, size: 16),
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
                                        )
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
                              text: "Done",
                              onTap: () {
                                Navigator.pop(context);
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
