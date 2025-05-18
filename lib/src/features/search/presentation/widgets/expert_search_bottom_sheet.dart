import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:e_learning_app/src/features/search/presentation/widgets/wrapper_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

Future<void> expertSearchBottomSheet({required BuildContext context}) async {
  final List<String> filterItems = [
    "Machine Learning",
    "System Design",
    "Cloud Architecture",
    "Data Science",
    "Frontend Development",
    "Cloud Architecture",
    "Data Science",
    "Backend Development",
    "Machine Learning",
    "System Design",
    "Software Engineering",
    "Mobile App Development",
    "Flutter App Development",
    "Cross Platform App Development",
    "Cross Platform App Development",
    "Machine Learning",
    "System Design",
    "Cross Platform App Development",
    "Cross Platform App Development",
    "Cloud Architecture",
    "Data Science",
    "Cross Platform App Development",
    "Cross Platform App Development",
    "Cross Platform App Development",
  ];

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: false,
    backgroundColor: Colors.transparent,
    barrierColor: Color(0xff0F0F0F).withValues(alpha: 0.7),

    builder: (context) {
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 32.h),

              /// Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Filter", style: Theme.of(context).textTheme.titleLarge),
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: Icon(Icons.close, color: Colors.white, size: 24.sp),
                  ),
                ],
              ),

              SizedBox(height: 20.h),

              WrapperList(contentList: filterItems),

              SizedBox(height: 32.h),
            ],
          ),
        ),
      );
    },
  );
}
