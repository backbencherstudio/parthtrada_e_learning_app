import 'package:e_learning_app/core/constant/padding.dart';
import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:e_learning_app/core/utils/common_widget.dart';
import 'package:e_learning_app/repository/linkedin_login_webview.dart';
import 'package:e_learning_app/src/features/expert_details/model/user_specific_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ExpertDetailsHeader extends StatelessWidget {
  final Data? data;
  const ExpertDetailsHeader({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final expert = data?.expert;
    final user = expert?.user;

    return Padding(
      padding: AppPadding.screenHorizontal,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Profile Picture and Back button
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      width: 24.w,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => context.pop(),
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 24.sp,
                        ),
                      ),
                    ),
                  ),
                ),

                ClipOval(
                  child:
                      user?.image != null && user!.image!.isNotEmpty
                          ? Image.network(
                            '$baseUrl/uploads/${user.image!}',
                            width: 140.w,
                            height: 140.h,
                            fit: BoxFit.cover,
                          )
                          : SizedBox(
                            width: 140.w,
                            height: 140.h,
                            child: CircleAvatar(
                              // AppImages.women, // Placeholder image
                              // width: 140.w,
                              // height: 140.h,
                              // fit: BoxFit.cover,
                              backgroundColor: Colors.white,
                            ),
                          ),
                ),

                Expanded(child: SizedBox()),
              ],
            ),
            SizedBox(height: 30.h),

            /// Name and Rating
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(user?.name ?? '', style: textTheme.headlineSmall),
                ),
                Icon(Icons.star, color: AppColors.primary, size: 20.sp),
                SizedBox(width: 4.w),
                Text(
                  data?.stats?.averageRating?.toString() ?? '0.0',
                  style: textTheme.bodyLarge,
                ),
              ],
            ),
            SizedBox(height: 4.h),

            /// Designation
            Text(
              expert?.profession?.toString() ?? 'N/A',
              style: textTheme.labelMedium,
            ),
            SizedBox(height: 10.h),

            /// Location
            Row(
              spacing: 6.w,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: Colors.white,
                  size: 20.sp,
                ),
                Text(
                  expert?.location?.toString() ?? 'N/A',
                  style: textTheme.labelMedium,
                ),
              ],
            ),
            SizedBox(height: 10.h),

            /// Message button
            CommonWidget.primaryButton(
              context: context,
              onPressed: () {},
              text: "Message",
            ),
          ],
        ),
      ),
    );
  }
}
