import 'package:flutter/material.dart';

import '../../../../core/constant/padding.dart';
import '../../../../core/theme/theme_part/app_colors.dart';
import 'widgets/transaction_history_card.dart';

class TransactionHistory extends StatelessWidget {
  const TransactionHistory({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Transaction History', style: textTheme.titleLarge),
        backgroundColor: AppColors.screenBackgroundColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: AppPadding.screenHorizontal,
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              bool isRefunded = false;
              if (index % 2 == 0) {
                isRefunded = true;
              }
              return TransactionHistoryCard(isRefunded: isRefunded);
            },
          ),
        ),
      ),
    );
  }
}
