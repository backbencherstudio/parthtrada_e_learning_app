import 'package:e_learning_app/core/constant/padding.dart';
import 'package:e_learning_app/core/utils/common_widget.dart';
import 'package:flutter/material.dart';

import '../../../../data/chat/chat_list.dart';
import '../../model/chat_model.dart';
import 'widgets/chat_list_widget.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Column(
        children: [
          CommonWidget.customAppBar(
            textTheme: textTheme,
            isNotification: true,
            title: 'Messages',
            subtitle: 'Chat with your connections',
          ),
          Expanded(
            child: Padding(
              padding: AppPadding.screenHorizontal,
              child: ListView.builder(
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  final chat = ChatItem.fromJson(chats[index]);
                  return ChatListWidget(
                    textTheme: textTheme,
                    imageUrl: chat.imageUrl,
                    name: chat.name,
                    lastMessage: chat.lastMessage,
                    time: chat.time,
                    unreadCount: chat.unreadCount,
                    userId: chat.userId,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
