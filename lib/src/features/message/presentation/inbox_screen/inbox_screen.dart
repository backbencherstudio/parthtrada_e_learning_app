import 'package:e_learning_app/core/services/local_storage_services/user_id_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constant/padding.dart';
import '../../../../../core/theme/theme_part/app_colors.dart';
import '../../model/message_model.dart';
import '../../riverpod/conversation_viewmodel.dart';
import 'widgets/inbox_screen_header_widgets.dart';
import 'widgets/message_card_widget.dart';
import 'widgets/message_writing_widget.dart';

class InboxScreen extends ConsumerStatefulWidget {
  const InboxScreen({
    super.key,
    required this.image,
    required this.name,
    required this.userId,
    required this.recipientId,
    // required this.recipientRole,
  });

  final String image;
  final String name;
  final String userId;
  final String recipientId;
  //final String recipientRole;

  @override
  ConsumerState<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends ConsumerState<InboxScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch messages and initialize message service after frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(conversationViewModelProvider.notifier)
          .fetchMessages(widget.userId, "1", "100", context: context);
      ref
          .read(conversationViewModelProvider.notifier)
          .initializeMessageService(context);
    });
  }

  @override
  void dispose() {
    ref.read(conversationViewModelProvider.notifier).disposeMessageService();
    // ScrollController is now managed by ViewModel, no need to dispose here
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final state = ref.watch(conversationViewModelProvider);
    // Use ScrollController from ViewModel
    final scrollController = ref.read(conversationViewModelProvider.notifier).scrollController;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppPadding.screenHorizontal,
          child: Column(
            children: [
              /// Header
              Column(
                children: [
                  InboxScreenHeaderWidget(
                    image: widget.image,
                    name: widget.name,
                  ),
                  Divider(color: AppColors.secondaryStrokeColor),
                ],
              ),

              /// Messages
              Expanded(
                child: state.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : state.error != null
                    ? Center(child: Text(state.error!))
                    : ListView.builder(
                  key: const ValueKey('message_list'),
                  controller: scrollController,
                  itemCount: state.messages?.data?.length ?? 0,
                  itemBuilder: (_, index) {
                    final Data msg = state.messages!.data![index];
                    return MessageCardWidget(
                      key: ValueKey(msg.id),
                      isMe: msg.me ?? false,
                      widget: widget,
                      msg: msg,
                      textTheme: textTheme,
                      chatMessages: state.messages!.data!,
                      index: index,
                    );
                  },
                ),
              ),

              /// Typing Indicator
              if (state.typingUserId != null)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Text(
                    '${state.typingUserId} is typing...',
                    style: textTheme.bodySmall!.copyWith(color: Colors.grey),
                  ),
                ),

              /// Message input
              MessageWritingWidget(
                textTheme: textTheme,
                userId: widget.userId,
                recipientId: widget.recipientId,
               // recipientRole: widget.recipientRole,
              ),
            ],
          ),
        ),
      ),
    );
  }
}