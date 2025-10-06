import 'package:e_learning_app/src/features/profile/data/viewmodels/past_call_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/constant/padding.dart';
import '../../../../../../core/theme/theme_part/app_colors.dart';
import 'widgets/past_call_card.dart';

class PastCall extends ConsumerStatefulWidget {
  const PastCall({super.key});

  @override
  ConsumerState<PastCall> createState() => _PastCallState();
}

class _PastCallState extends ConsumerState<PastCall> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMoreData);
  }

  void _loadMoreData() {
    final state = ref.read(pastCallsProvider);
    if (!state.isLoadingMore && state.pagination?.hasNextPage == true) {
      if (_scrollController.position.extentAfter < 300) {
        ref.read(pastCallsProvider.notifier).loadMorePastCalls();
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
    final pastCallsState = ref.watch(pastCallsProvider);
    final pastCalls = pastCallsState.pastCalls;
    final textTheme = Theme.of(context).textTheme;

    if (pastCallsState.isLoading && pastCalls.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (pastCallsState.error != null && pastCalls.isEmpty) {
      return Scaffold(
        body: Center(child: Text('No past calls found', style: textTheme.bodyLarge)),
      );
    }

    if (pastCalls.isEmpty) {
      return Scaffold(
        body: Center(child: Text('No past calls found', style: textTheme.bodyLarge)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Past Calls', style: textTheme.titleLarge),
        backgroundColor: AppColors.screenBackgroundColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: AppPadding.screenHorizontal,
          child: RefreshIndicator(
            onRefresh: () async {
              await ref.read(pastCallsProvider.notifier).refreshPastCalls();
            },
            child: ListView.builder(
              controller: _scrollController,
              itemCount: pastCalls.length + (pastCallsState.isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < pastCalls.length) {
                  final pastCall = pastCalls[index];
                  return PastCallCard(pastCall: pastCall);
                } else {
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
