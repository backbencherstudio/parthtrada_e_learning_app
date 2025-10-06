import 'package:e_learning_app/core/constant/padding.dart';
import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/viewmodels/send_request_riverpod.dart';
import 'widgets/sent_request_card.dart';

class SentRequestPage extends ConsumerStatefulWidget {
  const SentRequestPage({super.key});

  @override
  ConsumerState<SentRequestPage> createState() => _SentRequestPageState();
}

class _SentRequestPageState extends ConsumerState<SentRequestPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMoreData);
  }

  void _loadMoreData() {
    final state = ref.read(sendRequestProvider);
    if (!state.isLoadingMore && state.pagination?.hasNextPage == true) {
      if (_scrollController.position.extentAfter < 300) {
        ref.read(sendRequestProvider.notifier).loadMoreSendRequests();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sendRequestState = ref.watch(sendRequestProvider);
    final sendRequests = sendRequestState.sendRequests;
    final textTheme = Theme.of(context).textTheme;

    if (sendRequestState.isLoading && sendRequests.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (sendRequestState.error != null && sendRequests.isEmpty) {
      return Scaffold(
        body: Center(child: Text('No send requests found', style: textTheme.bodyLarge)),
      );
    }

    if (sendRequests.isEmpty) {
      return Scaffold(
        body: Center(child: Text('No sent requests found', style: textTheme.bodyLarge)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Sent Requests', style: textTheme.titleLarge),
        backgroundColor: AppColors.screenBackgroundColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: AppPadding.screenHorizontal,
          child: RefreshIndicator(
            onRefresh: () async {
              await ref.read(sendRequestProvider.notifier).refreshSendRequests();
            },
            child: ListView.builder(
              controller: _scrollController,
              itemCount: sendRequests.length + (sendRequestState.isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < sendRequests.length) {
                  final sendRequest = sendRequests[index];
                  return SentRequestCard(
                    sendRequest: sendRequest,
                    textTheme: textTheme,
                  );
                } else {
                  // Loading indicator at the bottom while loading more
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
