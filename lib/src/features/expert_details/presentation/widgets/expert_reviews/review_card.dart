import 'package:e_learning_app/core/constant/icons.dart';
import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:e_learning_app/repository/linkedin_login_webview.dart';
import 'package:e_learning_app/src/features/expert_details/model/expert_review_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ReviewCard extends StatelessWidget {
  final Items review;
  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    final student = review.student!;
    final textTheme = Theme.of(context).textTheme;
    String timeString = review.createdAt!;
    DateTime createdAt = DateTime.parse(timeString);
    DateTime now = DateTime.now();
    Duration difference = now.difference(createdAt);
    int daysDifference = difference.inDays;

    return Container(
      margin: EdgeInsets.only(bottom: 22.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child:
                student.image != null
                    ? CircleAvatar(
                      radius: 20.r,
                      child: Image.network('$baseUrl/uploads/${student.image}'),
                    )
                    : CircleAvatar(
                      radius: 24.r,
                      backgroundColor: Colors.white54,
                    ),
          ),

          SizedBox(width: 6.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(student.name ?? 'Unknown User'),
                    Spacer(),

                    Row(
                      children: List.generate(
                        review.rating!,
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
                    Text(review.rating.toString(), style: textTheme.bodySmall!),
                  ],
                ),
                SizedBox(height: 2.h),
                Text(
                  review.description ?? '',
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.secondaryTextColor,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "${student.email} - $daysDifference day ago",
                  style: textTheme.labelMedium?.copyWith(
                    color: Color(0xffA5A5AB),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
