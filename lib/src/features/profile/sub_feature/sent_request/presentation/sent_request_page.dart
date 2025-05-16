import 'package:e_learning_app/core/constant/padding.dart';
import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:flutter/material.dart';
import 'widgets/sent_request_card.dart';

class SentRequestPage extends StatelessWidget {
  const SentRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Sent Requests', style: textTheme.titleLarge),
        backgroundColor: AppColors.screenBackgroundColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: AppPadding.screenHorizontal,
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return SentRequestCard(textTheme: textTheme);
            },
          ),
        ),
      ),
    );
  }
}
