import 'package:e_learning_app/src/features/splash/riverpod/user_role_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constant/padding.dart';
import '../../../../core/theme/theme_part/app_colors.dart';
import '../viewmodel/transaction_history_viewmodel.dart';
import 'widgets/transaction_history_card.dart';

class TransactionHistory extends ConsumerStatefulWidget {
  const TransactionHistory({super.key});

  @override
  _TransactionHistoryState createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends ConsumerState<TransactionHistory> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Add listener to ScrollController for infinite scroll
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent * 0.9 &&
          !ref.read(transactionHistoryViewModelProvider).isLoading) {
        final transactionState = ref.read(transactionHistoryViewModelProvider);
        if (transactionState.history?.pagination?.hasNextPage == true) {
          ref.read(transactionHistoryViewModelProvider.notifier).fetchTransactionHistory(
            page: transactionState.history!.pagination!.page! + 1,
            perPage: transactionState.history!.pagination!.perPage!,
          );
        }
      }
    });

    // Fetch initial data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final transactionState = ref.read(transactionHistoryViewModelProvider);
      if (transactionState.history == null && transactionState.error == null) {
        ref.read(transactionHistoryViewModelProvider.notifier).fetchTransactionHistory();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final transactionState = ref.watch(transactionHistoryViewModelProvider);
    final role = ref.watch(userRoleProvider);

    debugPrint('====== Role: $role ======');

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Transaction History', style: textTheme.titleLarge),
        backgroundColor: AppColors.screenBackgroundColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: AppPadding.screenHorizontal,
          child: transactionState.isLoading && transactionState.history == null
              ? const Center(child: CircularProgressIndicator())
              : transactionState.error != null
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  transactionState.error!,
                  style: textTheme.bodyMedium!.copyWith(
                    color: AppColors.error,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(transactionHistoryViewModelProvider.notifier)
                        .fetchTransactionHistory();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          )
              : transactionState.history?.data == null ||
              transactionState.history!.data!.isEmpty
              ? Center(
            child: Text(
              'No transactions found',
              style: textTheme.bodyMedium,
            ),
          )
              : ListView.builder(
            controller: _scrollController, // Attach ScrollController
            itemCount: transactionState.history!.data!.length +
                (transactionState.isLoading ? 1 : 0), // Add loading indicator
            itemBuilder: (context, index) {
              if (index == transactionState.history!.data!.length) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              final transaction = transactionState.history!.data![index];
              bool isRefunded =
                  transaction.status?.toLowerCase() == 'refunded';
              bool isWithdraw = transaction.withdraw ?? false;
              return TransactionHistoryCard(
                isRefunded: isRefunded,
                isWithdraw: isWithdraw,
                transaction: transaction,
                isExpert: role == 'EXPERT',
              );
            },
          ),
        ),
      ),
    );
  }
}