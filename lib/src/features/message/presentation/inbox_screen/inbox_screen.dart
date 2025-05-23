import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constant/padding.dart';
import '../../../../../core/theme/theme_part/app_colors.dart';
import '../../../../data/chat/message_list.dart';
import '../../model/message_model.dart';
import 'widgets/inbox_screen_header_widgets.dart';
import 'widgets/message_card_widget.dart';
import 'widgets/message_writing_widget.dart';

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
                  Divider(color: AppColors.secondaryStrokeColor,),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: chatMessages.length,
                  itemBuilder: (_, index) {
                    final msg = chatMessages[index];
                    final isMe = msg.isMe;

                    return MessageCardWidget(
                      isMe: isMe,
                      widget: widget,
                      msg: msg,
                      textTheme: textTheme,
                      chatMessages: chatMessages,
                      index: index,
                    );
                  },
                ),
              ),
              MessageWritingWidget(textTheme: textTheme),
            ],
          ),
        ),
      ),
    );
  }
}

