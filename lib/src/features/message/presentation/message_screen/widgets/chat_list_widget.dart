import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/routes/route_name.dart';
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
  });

  final TextTheme textTheme;
  final String userId;
  final String imageUrl;
  final String name;
  final String lastMessage;
  final String time;
  final int unreadCount;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => context.push(
            RouteName.inboxScreen,
            extra: {'image': imageUrl, 'name': name, 'userId': userId},
          ),

      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: ListTile(
          leading: CircleAvatar(
            radius: 24.r,
            backgroundColor: AppColors.primary,
            backgroundImage: NetworkImage(imageUrl),
          ),
          title: Text(name, style: textTheme.titleMedium),
          subtitle: Text(
            lastMessage,
            style: unreadCount > 0 ? textTheme.bodySmall : textTheme.labelLarge,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Column(
            children: [
              Text(time, style: textTheme.labelLarge),
              SizedBox(height: 4.h),
              unreadCount > 0
                  ? ClipOval(
                    child: Container(
                      height: 24.h,
                      width: 24.w,
                      color: AppColors.primary,
                      child: Center(
                        child: Text(
                          unreadCount.toString(),
                          style: textTheme.bodySmall!.copyWith(
                            color: AppColors.onPrimary,
                          ),
                        ),
                      ),
                    ),
                  )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
