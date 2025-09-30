import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:e_learning_app/src/features/profile/presentation/be%20a%20expert/main%20bottomsheets/be_a_expert_sheet.dart';
import 'package:e_learning_app/src/features/profile/presentation/be%20a%20expert/main%20bottomsheets/date_time_selection_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/models/user_profile.dart';
import '../../../sub_feature/user profile/widget/custom_button.dart';
import '../Riverpod/skill_selection_provider.dart';

void sessionDetailstBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Consumer(
        builder: (context, ref, _) {
          return _SessionDetailsBottomSheet();
        },
      );
    },
  );
}

class _SessionDetailsBottomSheet extends ConsumerStatefulWidget {
  @override
  ConsumerState<_SessionDetailsBottomSheet> createState() => _SessionDetailsBottomSheetState();
}

class _SessionDetailsBottomSheetState extends ConsumerState<_SessionDetailsBottomSheet> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController universityController = TextEditingController();
  final TextEditingController professionController = TextEditingController();
  final TextEditingController organizationController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  String? errorMessage;

  @override
  void dispose() {
    nameController.dispose();
    universityController.dispose();
    professionController.dispose();
    organizationController.dispose();
    locationController.dispose();
    super.dispose();
  }

  void onSave() {
    final name = nameController.text.trim();
    final university = universityController.text.trim();
    final profession = professionController.text.trim();
    final organization = organizationController.text.trim();
    final location = locationController.text.trim();

    if (name.isEmpty) {
      setState(() {
        errorMessage = 'Please enter your name';
      });
      return;
    }
    if (university.isEmpty) {
      setState(() {
        errorMessage = 'Please enter your university';
      });
      return;
    }
    if (profession.isEmpty) {
      setState(() {
        errorMessage = 'Please enter your profession';
      });
      return;
    }
    if (organization.isEmpty) {
      setState(() {
        errorMessage = 'Please enter your organization';
      });
      return;
    }
    if (location.isEmpty) {
      setState(() {
        errorMessage = 'Please enter your location';
      });
      return;
    }

    ref.read(skillSelectionProvider.notifier).updateProfileData(
      UserProfile(
        name: name,
        university: university,
        profession: profession,
        organization: organization,
        location: location,
      ),
    );

    Navigator.pop(context);
    timeDateSelectionBottomSheet(context);
  }

  @override
  Widget build(BuildContext context) {
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
                  "Session Details",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Color(0xffffffff),
                  ),
                ),
                Divider(thickness: 1, color: Color(0xff2B2C31)),
                SizedBox(height: 16.h),
                Text(
                  "Name",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Color(0xffffffff),
                  ),
                ),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "John Doe",
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  "University",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Color(0xffffffff),
                  ),
                ),
                TextFormField(
                  controller: universityController,
                  decoration: InputDecoration(
                    hintText: "Stanford University",
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  "Profession",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Color(0xffffffff),
                  ),
                ),
                TextFormField(
                  controller: professionController,
                  decoration: InputDecoration(
                    hintText: "Senior Data Scientist",
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  "Organization Name",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Color(0xffffffff),
                  ),
                ),
                TextFormField(
                  controller: organizationController,
                  decoration: InputDecoration(hintText: "Google"),
                ),
                SizedBox(height: 16.h),
                Text(
                  "Location",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Color(0xffffffff),
                  ),
                ),
                TextFormField(
                  controller: locationController,
                  decoration: InputDecoration(hintText: "USA"),
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
                        onTap: onSave,
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