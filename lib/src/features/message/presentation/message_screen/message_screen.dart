import 'package:e_learning_app/core/constant/padding.dart';
import 'package:e_learning_app/core/utils/common_widget.dart';
import 'package:e_learning_app/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../riverpod/conversation_viewmodel.dart';
import 'widgets/chat_list_widget.dart';

class MessageScreen extends ConsumerWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(conversationViewModelProvider);
    final notifier = ref.read(conversationViewModelProvider.notifier);

    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Column(
        children: [
          CommonWidget.customAppBar(
            context: context,
            textTheme: textTheme,
            isNotification: true,
            title: 'Messages',
            subtitle: 'Chat with your connections',
          ),
          Expanded(
            child: Padding(
              padding: AppPadding.screenHorizontal,
              child: Builder(
                builder: (_) {
                  /// 1. Loading state
                  if (state.isLoadingConversation) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  /// 2. errorMessageConversation state
                  if (state.errorMessageConversation != null) {
                    return Center(
                      child: Text(
                        "errorMessageConversation: ${state.errorMessageConversation}",
                        style: textTheme.bodyMedium?.copyWith(color: Colors.red),
                      ),
                    );
                  }

                  /// 3. Empty state
                  final conversations = state.conversation?.data ?? [];
                  if (conversations.isEmpty) {
                    return const Center(child: Text("No conversations found"));
                  }

                  /// 4. Success state → show list
                  return RefreshIndicator(
                    onRefresh: () async {
                      await notifier.fetchConversation();
                    },
                    child: ListView.builder(
                      itemCount: conversations.length,
                      itemBuilder: (context, index) {
                        final convo = conversations[index];

                        // last message
                        final lastMsg = convo.messages?.isNotEmpty == true
                            ? convo.messages!.last.content
                            : "No messages yet";

                        // unread count
                        final unreadCount = convo.messages
                            ?.where((m) => m.readMessage == false)
                            .length ??
                            0;

                        return ChatListWidget(
                          textTheme: textTheme,
                          imageUrl: convo.sender?.image ?? "",
                          name: convo.sender?.name ?? "Unknown",
                          lastMessage: lastMsg ?? "",
                          time: Utils.formatDateTimeFromIso(convo.updatedAt.toString()) ?? "",
                          unreadCount: unreadCount,
                          userId: convo.id ?? "",
                          recipientRole: convo.recipientRole ?? '',
                          recipientId: convo.recipientId ?? '',

                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),


      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     notifier.fetchConversation();
      //   },
      //   child: const Icon(Icons.refresh),
      // ),
    );
  }
}
