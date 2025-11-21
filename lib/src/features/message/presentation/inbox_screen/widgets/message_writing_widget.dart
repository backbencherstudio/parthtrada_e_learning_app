import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/constant/icons.dart';
import '../../../../../../core/theme/theme_part/app_colors.dart';
import '../../../riverpod/conversation_viewmodel.dart';

class MessageWritingWidget extends ConsumerStatefulWidget {
  const MessageWritingWidget({
    super.key,
    required this.textTheme,
    required this.userId,
    required this.recipientId,
    //required this.recipientRole,
  });

  final TextTheme textTheme;
  final String userId;
  final String recipientId;
  //final String recipientRole;

  @override
  ConsumerState<MessageWritingWidget> createState() => _MessageWritingWidgetState();
}

class _MessageWritingWidgetState extends ConsumerState<MessageWritingWidget> {
  final TextEditingController _controller = TextEditingController();
  Timer? _typingTimer;

  @override
  void dispose() {
    _controller.dispose();
    _typingTimer?.cancel();
    super.dispose();
  }

  void _handleTyping() {
    ref.read(conversationViewModelProvider.notifier).emitTyping(widget.userId);
    _typingTimer?.cancel();
    _typingTimer = Timer(const Duration(seconds: 1), () {
      ref.read(conversationViewModelProvider.notifier).emitStopTyping(widget.userId);
    });
  }

  void _sendMessage() {
    final content = _controller.text.trim();
    if (content.isNotEmpty) {
      ref.read(conversationViewModelProvider.notifier).sendMessage(
        recipientId: widget.recipientId,
        //recipientRole: widget.recipientRole,
        content: content,
        context: context, // Pass BuildContext to sendMessage
      );
      _controller.clear();
      ref.read(conversationViewModelProvider.notifier).emitStopTyping(widget.userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            style: widget.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w400),
            decoration: InputDecoration(
              hintText: 'Type here...',
              fillColor: AppColors.secondary,
              filled: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.w,
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
            onChanged: (value) {
              if (value.isNotEmpty) {
                _handleTyping();
              }
            },
            onSubmitted: (_) => _sendMessage(),
          ),
        ),
        GestureDetector(
          onTap: _sendMessage,
          child: Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: SvgPicture.asset(AppIcons.sendIcon),
          ),
        ),
      ],
    );
  }
}