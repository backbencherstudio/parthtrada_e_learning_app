import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/routes/route_name.dart';
import '../../../../../../core/services/api_services/api_end_points.dart';
import '../../../../../../core/theme/theme_part/app_colors.dart';

class ChatListWidget extends StatelessWidget {
  const ChatListWidget({
    super.key,
    required this.textTheme,
    required this.imageUrl,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
    required this.userId,
    required this.recipientRole,
    required this.recipientId,
  });

  final TextTheme textTheme;
  final String userId;
  final String imageUrl;
  final String name;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final String recipientId;
  final String recipientRole;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(
        RouteName.inboxScreen,
        extra: {
          'image': imageUrl,
          'name': name,
          'userId': userId,
          'recipientId' : recipientId,
          'recipientRole' : recipientRole,


        },
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Avatar with fallback
            CircleAvatar(
              radius: 26.r,
              backgroundColor: AppColors.primary.withOpacity(0.2),
              backgroundImage: imageUrl.isNotEmpty
                  ? NetworkImage("${ApiEndPoints.baseUrl}/uploads/$imageUrl")
                  : null,
              child: imageUrl.isEmpty
                  ? Icon(Icons.person, color: AppColors.primary, size: 24.sp)
                  : null,
            ),
            SizedBox(width: 12.w),

            /// Name + Last Message
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    lastMessage,
                    style: textTheme.bodySmall?.copyWith(
                      color: unreadCount > 0
                          ? AppColors.primary
                          : AppColors.onSecondary.withOpacity(0.7),
                      fontWeight: unreadCount > 0 ? FontWeight.w600 : FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            SizedBox(width: 8.w),

            /// Time + Unread badge
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  time,
                  style: textTheme.labelSmall?.copyWith(
                    color: AppColors.onSecondary.withOpacity(0.6),
                    fontSize: 10.sp,
                  ),
                ),
                SizedBox(height: 6.h),
                // if (unreadCount > 0)
                //   Container(
                //     padding: EdgeInsets.all(6.r),
                //     decoration: BoxDecoration(
                //       color: AppColors.primary,
                //       shape: BoxShape.circle,
                //     ),
                //     child: Text(
                //       unreadCount.toString(),
                //       style: textTheme.bodySmall?.copyWith(
                //         color: AppColors.onPrimary,
                //         fontWeight: FontWeight.bold,
                //         fontSize: 10.sp,
                //       ),
                //     ),
                //   ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


