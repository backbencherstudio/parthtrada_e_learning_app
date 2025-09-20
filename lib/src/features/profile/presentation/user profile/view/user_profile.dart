import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:e_learning_app/repository/api/profile_api/fetch_me.dart';
import 'package:e_learning_app/src/features/onboarding/riverpod/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../sub_feature/user profile/widget/custom_button.dart';
import '../../../sub_feature/user profile/widget/headers.dart';

class UserProfile extends ConsumerStatefulWidget {
  const UserProfile({super.key});

  @override
  ConsumerState<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends ConsumerState<UserProfile> {
  late TextEditingController professionController;
  late TextEditingController organizationController;
  late TextEditingController locationController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    professionController = TextEditingController();
    organizationController = TextEditingController();
    locationController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final userInformation = ref.watch(aboutMeNotifierProvider);

    professionController.text = userInformation?.meta?.profession ?? '';
    organizationController.text = userInformation?.meta?.organization ?? '';
    locationController.text = userInformation?.meta?.location ?? '';
    descriptionController.text = userInformation?.meta?.description ?? '';
  }

  @override
  void dispose() {
    professionController.dispose();
    organizationController.dispose();
    locationController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final userInformation = ref.watch(aboutMeNotifierProvider);
    final authToken = ref.watch(authTokenProvider);

    if (userInformation == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 48.h),
              Headers(userInformation: userInformation),
              SizedBox(height: 24.h),
              Text(
                // userInformation!.name!,
                userInformation.name ?? "No Name Available",
                style: textStyle.titleSmall!.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Color(0xffffffff),
                ),
              ),
              Text(
                // userInformation.meta!.profession!,
                userInformation.meta?.profession ?? "No Profession Available",
                style: textStyle.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Color(0xffA5A5AB),
                ),
              ),
              SizedBox(height: 20.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Profession",
                  style: textStyle.bodyMedium!.copyWith(
                    color: Color(0xffffffff),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              TextFormField(
                controller: professionController,
                decoration: InputDecoration(hintText: "student"),
              ),
              SizedBox(height: 14.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Organization Name",
                  style: textStyle.bodyMedium!.copyWith(
                    color: Color(0xffffffff),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              TextFormField(
                controller: organizationController,
                decoration: InputDecoration(hintText: "Tesla"),
              ),

              SizedBox(height: 14.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Location",
                  style: textStyle.bodyMedium!.copyWith(
                    color: Color(0xffffffff),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              TextFormField(
                controller: locationController,
                decoration: InputDecoration(hintText: "USA"),
              ),
              SizedBox(height: 14.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Professional Bio",
                  style: textStyle.bodyMedium!.copyWith(
                    color: Color(0xffffffff),
                  ),
                ),
              ),
              SizedBox(height: 8.h),

              SizedBox(
                width: 326.w,
                height: 127.h,
                child: TextFormField(
                  controller: descriptionController,
                  expands: false,
                  maxLines: 5,
                  minLines: 3,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(hintText: "Description"),
                ),
              ),
              Row(
                children: [
                  Mybutton(
                    color: Color(0xff2B2C31),
                    text: "Discard",
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 8.w),
                  Mybutton(
                    color: AppColors.primary,
                    text: "Save",
                    // onTap: () async {
                    //   if (mounted) {
                    //     await saveUserProfile(authToken!);
                    //     Navigator.pop(context);
                    //   }
                    // },
                    onTap: () async {
                      if (mounted) {
                        await saveUserProfile(authToken!);
                        Future.delayed(Duration(milliseconds: 100), () {
                          if (mounted) {
                            Navigator.pop(context);
                          }
                        });
                      }
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

  Future<void> saveUserProfile(String token) async {
    final updatedProfileData = {
      'profession': professionController.text,
      'organization': organizationController.text,
      'location': locationController.text,
      'description': descriptionController.text,
    };
    await ref
        .read(aboutMeNotifierProvider.notifier)
        .updateUserProfile(updatedProfileData, token);
  }
}
