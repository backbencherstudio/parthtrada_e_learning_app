import 'package:flutter/material.dart';

import '../../../../../../core/constant/padding.dart';
import '../../../../../../core/theme/theme_part/app_colors.dart';
import 'widgets/past_call_card.dart';

class PastCall extends StatelessWidget {
  const PastCall({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Past Calls', style: textTheme.titleLarge),
        backgroundColor: AppColors.screenBackgroundColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: AppPadding.screenHorizontal,
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return PastCallCard();
            },
          ),
        ),
      ),
    );
  }
}
