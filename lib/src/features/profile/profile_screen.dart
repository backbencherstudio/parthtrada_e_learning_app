import 'package:e_learning_app/core/constant/images.dart';
import 'package:e_learning_app/core/utils/common_widget.dart';
import 'package:e_learning_app/src/features/profile/data/viewmodels/profile_viewmodel.dart';
import 'package:e_learning_app/src/features/profile/sub_feature/widgets/widget_List.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/services/api_services/api_end_points.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = Theme.of(context).textTheme;
    final profileState = ref.watch(profileViewmodel);

    // Automatically trigger data load only if not loaded yet
    ref.listen(profileViewmodel, (previous, next) {
      if (previous == null && !next.isProfileLoding && !next.isProfileSuccess) {
        ref.read(profileViewmodel.notifier).getProfileInfo();
      }
    });

    final profileData = profileState.profileResponseData.data;

    return Scaffold(
      body:
          profileState.isProfileLoding
              ? const Center(child: CircularProgressIndicator())
              : profileState.isProfileSuccess && profileData != null
              ? SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 67.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Expanded(child: SizedBox()),
                                const Expanded(child: SizedBox()),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(90.r),
                                  child: Center(
                                    child: Container(
                                      height: 120.h,
                                      width: 120.w,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: ClipOval(
                                        child:
                                            profileData.image != null
                                                ? Image.network(
                                                  "${ApiEndPoints.baseUrl}/uploads/${profileData.image!}",
                                                  height: 120.h,
                                                  width: 120.w,
                                                  fit: BoxFit.cover,
                                                  // Ensures image fills circle
                                                  errorBuilder: (
                                                    context,
                                                    error,
                                                    stackTrace,
                                                  ) {
                                                    return Image.asset(
                                                      AppImages.maiya,
                                                      height: 120.h,
                                                      width: 120.w,
                                                      fit: BoxFit.cover,
                                                    );
                                                  },
                                                  loadingBuilder: (
                                                    context,
                                                    child,
                                                    loadingProgress,
                                                  ) {
                                                    if (loadingProgress == null)
                                                      return child;
                                                    return const Center(
                                                      child: CircularProgressIndicator(
                                                        strokeWidth: 2,
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                              Color
                                                            >(Colors.grey),
                                                      ),
                                                    );
                                                  },
                                                )
                                                : Image.asset(
                                                  AppImages.maiya,
                                                  height: 120.h,
                                                  width: 120.w,
                                                  fit: BoxFit.cover,
                                                ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Expanded(child: SizedBox()),
                                Flexible(
                                  child: CommonWidget.notificationWidget(
                                    context,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            profileData.name ?? "Unknown User",
                            style: textStyle.titleSmall!.copyWith(
                              fontWeight: FontWeight.w700,
                              color: const Color(0xffffffff),
                            ),
                          ),
                          Text(
                            profileData.email ?? "No email available",
                            style: textStyle.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w400,
                              color: const Color(0xffA5A5AB),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "General",
                          style: textStyle.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: const Color(0xffffffff),
                          ),
                        ),
                      ),
                      SizedBox(height: 18.h),
                      FutureBuilder<List<Widget>>(
                        future: callContainerGeneral(context),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text(
                              "Error loading general options",
                              style: textStyle.bodyMedium!.copyWith(
                                color: Colors.red,
                              ),
                            );
                          } else if (snapshot.hasData) {
                            return Column(children: snapshot.data!);
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                      SizedBox(height: 28.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Preferences",
                          style: textStyle.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: const Color(0xffffffff),
                          ),
                        ),
                      ),
                      SizedBox(height: 18.h),
                      ...callContainerPreferencess(context),
                      SizedBox(height: 18.h),
                    ],
                  ),
                ),
              )
              : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      profileState.profileErrorMessage.isNotEmpty
                          ? profileState.profileErrorMessage
                          : "Failed to load profile",
                      style: textStyle.bodyMedium!.copyWith(color: Colors.red),
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      onPressed:
                          () =>
                              ref
                                  .read(profileViewmodel.notifier)
                                  .getProfileInfo(),
                      child: const Text("Retry"),
                    ),
                  ],
                ),
              ),
    );
  }
}
