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
  });

  final String image;
  final String name;
  final String userId;

  @override
  ConsumerState<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends ConsumerState<InboxScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Fetch messages from ViewModel when screen is opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(conversationViewModelProvider.notifier)
          .fetchMessages(widget.userId, "1", "20");
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final state = ref.watch(conversationViewModelProvider);

    // Auto scroll after messages load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(
          _scrollController.position.maxScrollExtent + 100.h,
        );
      }
    });

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
                  controller: _scrollController,
                  itemCount: state.messages?.data?.length ?? 0,
                  itemBuilder: (_, index) {
                    final Data msg = state.messages!.data![index];
                    return MessageCardWidget(
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

              /// Message input
              MessageWritingWidget(textTheme: textTheme),
            ],
          ),
        ),
      ),
    );
  }
}
