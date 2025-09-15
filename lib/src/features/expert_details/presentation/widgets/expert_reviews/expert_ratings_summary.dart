import 'package:e_learning_app/core/constant/icons.dart';
import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:e_learning_app/repository/linkedin_login_webview.dart';
import 'package:e_learning_app/src/features/expert_details/model/user_specific_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExpertRatingsSummary extends StatelessWidget {
  final Data? data;
  const ExpertRatingsSummary({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final length = data?.stats?.ratingDistribution?.length ?? 0;
    final user = data?.expert?.user;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Reviews", style: textTheme.headlineSmall),
        SizedBox(height: 10.h),
        user?.image != null
            ? CircleAvatar(
              radius: 20.r,
              backgroundImage: NetworkImage(
                "$baseUrl/uploads/${user!.image!.trim()}",
              ),
              backgroundColor: Colors.grey[200],
            )
            : CircleAvatar(radius: 20.r, backgroundColor: Colors.white60),
        SizedBox(height: 30.h),

        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${data?.stats?.averageRating ?? 0.0}",
                  style: textTheme.bodyMedium?.copyWith(fontSize: 56.sp),
                ),
                Row(
                  children: List.generate(5, (index) {
                    double rating = data?.stats?.averageRating ?? 0.0;
                    bool isFilled = index < rating.floor();
                    bool isHalf =
                        !isFilled &&
                        (rating - rating.floor()) >= 0.5 &&
                        index == rating.floor();

                    if (isFilled) {
                      return SvgPicture.asset(
                        AppIcons.starFill,
                        width: 24.0,
                        height: 24.0,
                        colorFilter: ColorFilter.mode(
                          Color(0xffF6A14B),
                          BlendMode.srcIn,
                        ),
                      );
                    } else if (isHalf) {
                      return SvgPicture.asset(
                        AppIcons.starHalf,
                        width: 24.0,
                        height: 24.0,
                        colorFilter: ColorFilter.mode(
                          Color(0xffF6A14B),
                          BlendMode.srcIn,
                        ),
                      );
                    } else {
                      return SvgPicture.asset(
                        AppIcons.starEmpty,
                        width: 24.0,
                        height: 24.0,
                        colorFilter: ColorFilter.mode(
                          Color(0xffF6A14B),
                          BlendMode.srcIn,
                        ),
                      );
                    }
                  }),
                ),

                Text(
                  "${data?.stats?.totalReviews ?? 0} Reviews",
                  style: textTheme.labelMedium,
                ),
              ],
            ),
            SizedBox(width: 25.w),
            Expanded(
              child: Column(
                spacing: 4.h,
                children: List.generate(
                  length,
                  (index) => Row(
                    children: [
                      Text(
                        (length - index).toString(),
                        style: textTheme.labelMedium,
                      ),
                      SizedBox(width: 18.w),
                      Expanded(
                        child: LinearProgressIndicator(
                          borderRadius: BorderRadius.circular(20.r),
                          minHeight: 8.h,
                          value:
                              data
                                  ?.stats
                                  ?.ratingDistribution![index]
                                  .percentage,
                          color: AppColors.primary,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
