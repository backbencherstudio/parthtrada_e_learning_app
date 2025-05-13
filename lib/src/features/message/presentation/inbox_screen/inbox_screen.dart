import 'package:e_learning_app/core/constant/padding.dart';
import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:e_learning_app/src/data/chat/message_list.dart';
import 'package:e_learning_app/src/features/message/model/message_model.dart';
import 'package:e_learning_app/src/features/message/presentation/inbox_screen/widgets/inbox_screen_header_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({
    super.key,
    required this.image,
    required this.name,
    required this.userId,
  });

  final String image;
  final String name;
  final String userId;

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  final ScrollController _scrollController = ScrollController();
  late final List<MessageModel> chatMessages;

  @override
  void initState() {
    super.initState();
    chatMessages =
        messages
            .map((e) => MessageModel.fromJson(e))
            .where((msg) => msg.userId == widget.userId || msg.isMe)
            .toList();

    // Scroll to bottom after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(
          _scrollController.position.maxScrollExtent + 100.h,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppPadding.screenHorizontal,
          child: Column(
            children: [
              Column(
                children: [
                  InboxScreenHeaderWidget(
                    image: widget.image,
                    name: widget.name,
                  ),
                  Divider(),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: chatMessages.length,
                  itemBuilder: (_, index) {
                    final msg = chatMessages[index];
                    final isMe = msg.isMe;

                    return Align(
                      alignment:
                          isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (!isMe)
                                CircleAvatar(
                                  radius: 12.r,
                                  backgroundImage: NetworkImage(widget.image),
                                ),
                              Container(
                                constraints: BoxConstraints(
                                  maxWidth: ScreenUtil.defaultSize.width * 0.8,
                                ),
                                margin: const EdgeInsets.symmetric(
                                  vertical: 4,
                                  horizontal: 10,
                                ),
                                padding: const EdgeInsets.all(12),
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
                                child: Text(
                                  msg.message,
                                  style: textTheme.bodySmall,
                                ),
                              ),
                              if (isMe)
                                CircleAvatar(
                                  radius: 12.r,
                                  backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/10.jpg'),
                                ),
                            ],
                          ),
                          if (index == chatMessages.length - 1)
                            SizedBox(height: 50.h),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        //controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'Type here...',
                          fillColor: AppColors.secondary,
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
