import 'package:e_learning_app/core/constant/images.dart';
import 'package:e_learning_app/core/utils/common_widget.dart';
import 'package:e_learning_app/src/features/profile/data/models/profile_response_data.dart';
import 'package:e_learning_app/src/features/profile/data/viewmodels/profile_viewmodel.dart';
import 'package:e_learning_app/src/features/profile/sub_feature/widgets/widget_List.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch profile data when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(profileViewmodel.notifier).getProfileInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    // Watch the profileViewmodel for reactive updates
    final profileState = ref.watch(profileViewmodel);
    final profileData = profileState.profileResponseData.data;

    return Scaffold(
      body: profileState.isProfileLoding
          ? Center(
        child: CircularProgressIndicator(),
      )
          : profileState.isProfileSuccess && profileData != null
          ? SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 24.w, right: 24.w),
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
                        Expanded(child: SizedBox()),
                        Expanded(child: SizedBox()),
                        Center(
                          child: profileData.image != null
                              ? Image.network(
                            profileData.image!,
                            height: 140.h,
                            width: 140.w,
                            errorBuilder: (context, error, stackTrace) => Image.asset(
                              AppImages.maiya,
                              height: 140.h,
                              width: 140.w,
                            ),
                          )
                              : Image.asset(
                            AppImages.maiya,
                            height: 140.h,
                            width: 140.w,
                          ),
                        ),
                        Expanded(child: SizedBox()),
                        Flexible(
                          child: CommonWidget.notificationWidget(context),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    profileData.name ?? "Unknown User",
                    style: textStyle.titleSmall!.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Color(0xffffffff),
                    ),
                  ),
                  Text(
                    profileData.email ?? "No email available",
                    style: textStyle.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Color(0xffA5A5AB),
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
                    color: Color(0xffffffff),
                  ),
                ),
              ),
              SizedBox(height: 18.h),
              ...callContainerGeneral(context),
              SizedBox(height: 28.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Preferences",
                  style: textStyle.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Color(0xffffffff),
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
              style: textStyle.bodyMedium!.copyWith(
                color: Colors.red,
              ),
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: () => ref.read(profileViewmodel.notifier).getProfileInfo(),
              child: Text("Retry"),
            ),
          ],
        ),
      ),
    );
  }
}