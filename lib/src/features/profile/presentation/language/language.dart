import 'package:e_learning_app/core/constant/icons.dart';
import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:e_learning_app/src/features/profile/presentation/language/Riverpod/checkbox_provider.dart';
import 'package:e_learning_app/src/features/profile/presentation/language/widgets/language_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../sub_feature/user profile/widget/custom_button.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        centerTitle: false,
        title: Text(
          "Language",
          style: Theme.of(
            context,
          ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.only(left: 24.w),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset(AppIcons.backlongArrow),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Divider(
                thickness: 1,
                color: Color(0xff2B2C31),
                indent: 6.w,
                endIndent: 6.w,
              ),
              SizedBox(height: 24.h),

              //from here the list will show up
              Consumer(
                builder: (context, ref, _) {
                  final checkboxes = ref.watch(checkboxListProvider);
                  final notifier = ref.read(checkboxListProvider.notifier);

                  return Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Suggested",
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium!.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      // here will go the container
                      LanguageContainer(
                        text: "English (US)",
                        isChecked: checkboxes[0],
                        onTap: () => notifier.selectOnly(0),
                      ),
                      SizedBox(height: 16.h),
                      LanguageContainer(
                        text: "English (UK)",
                        isChecked: checkboxes[1],
                        onTap: () => notifier.selectOnly(1),
                      ),
                      SizedBox(height: 16.h),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Others",
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium!.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      LanguageContainer(
                        text: "Mandarin",
                        isChecked: checkboxes[2],
                        onTap: () => notifier.selectOnly(2),
                      ),
                      SizedBox(height: 16.h),
                      LanguageContainer(
                        text: "Hindi",
                        isChecked: checkboxes[3],
                        onTap: () => notifier.selectOnly(3),
                      ),
                      SizedBox(height: 16.h),
                      LanguageContainer(
                        text: "Spanish",
                        isChecked: checkboxes[4],
                        onTap: () => notifier.selectOnly(4),
                      ),
                      SizedBox(height: 16.h),
                      LanguageContainer(
                        text: "Arabic",
                        isChecked: checkboxes[5],
                        onTap: () => notifier.selectOnly(5),
                      ),
                      SizedBox(height: 16.h),
                      LanguageContainer(
                        text: "Bengali",
                        isChecked: checkboxes[6],
                        onTap: () => notifier.selectOnly(6),
                      ),
                      SizedBox(height: 16.h),
                      LanguageContainer(
                        text: "Indonesia",
                        isChecked: checkboxes[7],
                        onTap: () => notifier.selectOnly(7),
                      ),
                      //same also here will also go the container
                    ],
                  );
                },
              ),
              SizedBox(height: 16.h),

              Mybutton(
                color: AppColors.primary,
                text: "Save",
                onTap: () {},
                width: 327.w,
              ),
              SizedBox(height: 20.h,)
            ],
          ),
        ),
      ),
    );
  }
}
