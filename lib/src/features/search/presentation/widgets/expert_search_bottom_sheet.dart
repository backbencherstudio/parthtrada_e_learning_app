import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:e_learning_app/src/features/search/presentation/widgets/wrapper_list.dart';
import 'package:e_learning_app/src/features/search/provider/skills_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

Future<void> expertSearchBottomSheet({
  required BuildContext context,
  required String? authToken,
  required ValueChanged<List<String>> onSkillsChanged,
}) async {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: false,
    backgroundColor: Colors.transparent,
    barrierColor: Color(0xff0F0F0F).withValues(alpha: 0.7),

    builder: (context) {
      return Consumer(
        builder: (context, ref, _) {
          final skillsAsync = ref.watch(expertSkillsProvider(authToken ?? ""));
          return Container(
            height: 530.h,
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32.r),
                topRight: Radius.circular(32.r),
              ),
            ),
            child: skillsAsync.when(
              data:
                  (skills) => SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 32.h),

                        /// Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Filter",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            IconButton(
                              onPressed: () => context.pop(),
                              icon: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 24.sp,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20.h),

                        WrapperList(
                          contentList: skills,
                          onSkillSelected: (selectedSkill) {
                            onSkillsChanged([
                              selectedSkill,
                            ]); 
                            context
                                .pop();
                          },
                        ),

                        SizedBox(height: 32.h),
                      ],
                    ),
                  ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text("Error: $err")),
            ),
          );
        },
      );
    },
  );
}
