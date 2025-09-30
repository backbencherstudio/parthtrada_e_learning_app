import 'package:e_learning_app/core/constant/padding.dart';
import 'package:e_learning_app/core/services/api_services/api_end_points.dart';
import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:e_learning_app/core/utils/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../repository/linkedin_login_webview.dart';

class ExpertDetailsHeader extends StatelessWidget {
  final String name;
  final String rating;
  final String profession;
  final String organization;
  final String location;
  final String? imageUrl;

  const ExpertDetailsHeader({
    super.key,
    required this.name,
    required this.rating,
    required this.profession,
    required this.location,
    this.imageUrl, required this.organization,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: AppPadding.screenHorizontal,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => context.pop(),
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                ),
                const Spacer(),
              ],
            ),
            Center(
              child: ClipOval(
                child:
                    imageUrl != null && imageUrl!.isNotEmpty
                        ? Image.network(
                          '${ApiEndPoints.baseUrl}/uploads/$imageUrl',
                          width: 56.w,
                          height: 56.w,
                          fit: BoxFit.cover,
                        )
                        : CircleAvatar(
                          radius: 28.w,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.person,
                            color: Colors.grey,
                            size: 28.w,
                          ),
                        ),
              ),
            ),
            SizedBox(height: 30.h),
            Row(
              children: [
                Expanded(child: Text(name, style: textTheme.headlineSmall)),
                Icon(Icons.star, color: AppColors.primary, size: 20.sp),
                SizedBox(width: 4.w),
                Text(rating, style: textTheme.bodyLarge),
              ],
            ),
            SizedBox(height: 4.h),

            /// Profession, organization
            Text('$profession, $organization', style: textTheme.labelLarge),
            SizedBox(height: 10.h),

            /// Location
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: Colors.white,
                  size: 20.sp,
                ),
                SizedBox(width: 6.w),
                Text(location, style: textTheme.labelMedium),
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
