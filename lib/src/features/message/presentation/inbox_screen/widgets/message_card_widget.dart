import 'package:e_learning_app/core/constant/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/services/api_services/api_end_points.dart';
import '../../../../../../core/theme/theme_part/app_colors.dart';
import '../../../model/message_model.dart';
import '../inbox_screen.dart';

class MessageCardWidget extends StatelessWidget {
  const MessageCardWidget({
    super.key,
    required this.isMe,
    required this.widget,
    required this.msg,
    required this.textTheme,
    required this.chatMessages,
    required this.index,
  });

  final bool isMe;
  final InboxScreen widget;
  final Data msg; // single message
  final TextTheme textTheme;
  final List<Data> chatMessages;
  final int index;

  @override
  Widget build(BuildContext context) {
    final String? imageUrl = isMe ? msg.sender?.image : msg.sender?.image;
    final String displayName =
    isMe ? (msg.sender?.name ?? "Me") : (msg.sender?.name ?? widget.name);

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
        isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Receiver avatar
              if (!isMe)
                _buildAvatar(imageUrl ?? ""),

              /// Message bubble
              Flexible(
                child: Column(
                  crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// Name above message
                    Padding(
                      padding: EdgeInsets.only(left: 10.w, right: 10.w),
                      child: Text(
                        displayName,
                        style: textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),

                    /// Bubble
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: 260.w,
                        minWidth: ScreenUtil.defaultSize.width * 0.25,
                      ),
                      margin: EdgeInsets.symmetric(
                        vertical: 4.h,
                        horizontal: 10.w,
                      ),
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                        color: isMe
                            ? AppColors.primary
                            : Colors.grey.shade200, // lighter for received
                        borderRadius: isMe
                            ? BorderRadius.only(
                          bottomLeft: Radius.circular(16.r),
                          bottomRight: Radius.circular(16.r),
                          topLeft: Radius.circular(16.r),
                        )
                            : BorderRadius.only(
                          bottomLeft: Radius.circular(16.r),
                          bottomRight: Radius.circular(16.r),
                          topRight: Radius.circular(16.r),
                        ),
                      ),
                      child: Text(
                        msg.content ?? "",
                        style: textTheme.bodySmall?.copyWith(
                          color: isMe ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),

                    /// Time
                    Padding(
                      padding: EdgeInsets.only(left: 10.w, right: 10.w),
                      child: Text(
                        msg.createdAt ?? "",
                        style: textTheme.labelSmall?.copyWith(
                          color: Colors.grey,
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// Sender avatar (me)
              if (isMe) _buildAvatar(imageUrl ?? ""),
            ],
          ),

          SizedBox(height: 13.h),

          /// Gap after last message
          if (index == chatMessages.length - 1) SizedBox(height: 50.h),
        ],
      ),
    );
  }

  /// Avatar widget with fallback handling
  Widget _buildAvatar(String imageUrl) {
    return CircleAvatar(
      radius: 26.r,
      backgroundColor: AppColors.primary.withOpacity(0.2),
      backgroundImage: imageUrl.isNotEmpty ? NetworkImage("${ApiEndPoints.baseUrl}/uploads/$imageUrl") : null,
      child: imageUrl.isEmpty
          ? Icon(Icons.person, color: AppColors.primary, size: 24.sp)
          : null,
    );
  }
}
