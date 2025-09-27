import 'package:e_learning_app/core/routes/route_name.dart';
import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../data/viewmodels/profile_viewmodel.dart';
import '../../../sub_feature/user profile/widget/custom_button.dart';
import '../../../sub_feature/user profile/widget/headers.dart';

class UserProfile extends ConsumerStatefulWidget {
  const UserProfile({super.key});

  @override
  ConsumerState<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends ConsumerState<UserProfile> {
  late TextEditingController _professionController;
  late TextEditingController _organizationController;
  late TextEditingController _locationController;
  late TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers
    _professionController = TextEditingController();
    _organizationController = TextEditingController();
    _locationController = TextEditingController();
    _bioController = TextEditingController();

    // Fetch profile data after widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(profileViewmodel.notifier).getProfileInfo();
    });
  }

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    _professionController.dispose();
    _organizationController.dispose();
    _locationController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final profileState = ref.watch(profileViewmodel);

    // Update controllers with profile data when available
    if (profileState.isProfileSuccess && profileState.profileResponseData.data?.meta != null) {
      _professionController.text = profileState.profileResponseData.data!.meta!.profession ?? '';
      _organizationController.text = profileState.profileResponseData.data!.meta!.organization ?? '';
      _locationController.text = profileState.profileResponseData.data!.meta!.location ?? '';
      _bioController.text = profileState.profileResponseData.data!.meta!.description ?? '';
    }

    return Scaffold(
      body: profileState.isProfileLoding
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 48.h),
              const Headers(),
              SizedBox(height: 24.h),
              Text(
                profileState.profileResponseData.data?.name ?? "",
                style: textStyle.titleSmall!.copyWith(
                  fontWeight: FontWeight.w700,
                  color: const Color(0xffffffff),
                ),
              ),
              Text(
                profileState.profileResponseData.data?.activeProfile ?? "",
                style: textStyle.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w400,
                  color: const Color(0xffA5A5AB),
                ),
              ),
              SizedBox(height: 20.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Profession",
                  style: textStyle.bodyMedium!.copyWith(
                    color: const Color(0xffffffff),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              TextFormField(
                controller: _professionController,
                decoration: InputDecoration(
                  hintText: "Student",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
              SizedBox(height: 14.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Organization Name",
                  style: textStyle.bodyMedium!.copyWith(
                    color: const Color(0xffffffff),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              TextFormField(
                controller: _organizationController,
                decoration: InputDecoration(
                  hintText: "Tesla",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
              SizedBox(height: 14.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Location",
                  style: textStyle.bodyMedium!.copyWith(
                    color: const Color(0xffffffff),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  hintText: "USA",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
              SizedBox(height: 14.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Professional Bio",
                  style: textStyle.bodyMedium!.copyWith(
                    color: const Color(0xffffffff),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              SizedBox(
                width: 326.w,
                height: 127.h,
                child: TextFormField(
                  controller: _bioController,
                  expands: false,
                  maxLines: 5,
                  minLines: 3,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    hintText: "Description",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
              ),
              // if (profileState.profileErrorMessage.isNotEmpty)
              //   Padding(
              //     padding: EdgeInsets.only(top: 8.h),
              //     child: Text(
              //       profileState.profileErrorMessage,
              //       style: textStyle.bodySmall!.copyWith(
              //         color: Colors.red,
              //       ),
              //     ),
              //   ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Mybutton(
                    color: const Color(0xff2B2C31),
                    text: "Discard",
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 8.w),
                  Mybutton(

                    color: AppColors.primary,
                    text: profileState.isUpdateProfileLoading ? "Updating..." : "Save",
                    onTap: () async {

                     bool isUpdate = await ref.read(profileViewmodel.notifier).updateProfileInfo(_professionController.text, _organizationController.text, _locationController.text, _bioController.text);

                     if(isUpdate)
                       {
                         Navigator.pop(context);
                        // context.pushNamed(RouteName.profileScreen);
                       }
                      //
                      // // Placeholder for save functionality
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   const SnackBar(content: Text("Save functionality not implemented")),
                      // );
                    },
                  ),
                ],
              ),
              SizedBox(height: 100.h),
            ],
          ),
        ),
      ),
    );
  }
}