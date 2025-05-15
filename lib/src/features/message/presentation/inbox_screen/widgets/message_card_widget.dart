import 'package:e_learning_app/core/constant/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  final MessageModel msg;
  final TextTheme textTheme;
  final List<MessageModel> chatMessages;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ///for message & profile image
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isMe)
                CircleAvatar(
                  radius: 12.r,
                  backgroundImage: NetworkImage(widget.image),
                ),
              Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
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
                      color:
                          isMe
                              ? AppColors.primary
                              : AppColors.secondaryButtonBgColor,
                      borderRadius:
                          isMe
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
                    child: Column(
                      children: [Text(msg.message, style: textTheme.bodySmall)],
                    ),
                  ),
                  Padding(
                    padding: AppPadding.screenHorizontal,
                    child: Text(msg.time, style: textTheme.labelSmall),
                  ),
                ],
              ),
              if (isMe)
                CircleAvatar(
                  radius: 12.r,
                  backgroundImage: NetworkImage(
                    'https://randomuser.me/api/portraits/men/10.jpg',
                  ),
                ),
            ],
          ),
          SizedBox(height: 13.w),

          ///if last message gap 50.h
          if (index == chatMessages.length - 1) SizedBox(height: 50.h),
        ],
      ),
    );
  }
}
