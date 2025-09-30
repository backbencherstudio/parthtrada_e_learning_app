import 'package:e_learning_app/core/constant/icons.dart';
import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:e_learning_app/src/features/expert_details/model/expert_review_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key, required this.review});

  final ReviewItem review;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.only(bottom: 22.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Picture - Safely access the image URL
          ClipOval(
            child: review.student.image != null
                ? Image.network(
              review.student.image!,
              width: 24.w,
              height: 24.w,
              fit: BoxFit.cover,
            )
                : Icon(Icons.person, size: 24.w),
          ),

          SizedBox(width: 6.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      review.student.name,
                      style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Spacer(),

                    Row(
                      children: List.generate(
                        review.rating,
                            (index) => SvgPicture.asset(
                          AppIcons.starFill,
                          width: 14.w,
                          height: 14.w,
                          colorFilter: ColorFilter.mode(
                            Color(0xffF6A14B),
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Text(
                      review.rating.toString(),
                      style: textTheme.bodySmall!,
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Text(
                  review.description,
                  style: textTheme.bodyMedium?.copyWith(color: AppColors.secondaryTextColor),
                ),
                SizedBox(height: 8.h),
                Text(
                  "${review.student.email} - 1 day ago",
                  style: textTheme.labelMedium?.copyWith(color: Color(0xffA5A5AB)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
