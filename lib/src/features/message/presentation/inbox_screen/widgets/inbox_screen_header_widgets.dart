import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/services/api_services/api_end_points.dart';
import '../../../../../../core/theme/theme_part/app_colors.dart';

class InboxScreenHeaderWidget extends StatelessWidget {
  final String image;
  final String name;

  const InboxScreenHeaderWidget({
    super.key,
    required this.image,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_outlined,
            size: 24,
            color: AppColors.onSecondary,
          ),
        ),
        const SizedBox(width: 12),

        /// Avatar with fallback icon if image is empty
        CircleAvatar(
          radius: 26.r,
          backgroundColor: AppColors.primary.withOpacity(0.2),
          backgroundImage: image.isNotEmpty ? NetworkImage("${ApiEndPoints.baseUrl}/uploads/$image") : null,
          child: image.isEmpty
              ? Icon(Icons.person, color: AppColors.primary, size: 24.sp)
              : null,
        ),

        const SizedBox(width: 12),
        Expanded(
          child: Text(
            name,
            style: textTheme.titleMedium,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
