import 'package:e_learning_app/core/constant/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/theme/theme_part/app_colors.dart';
import '../riverpod/scroll_riverpod.dart';
import 'widgets/policy_card.dart';


class PrivacyPolicy extends ConsumerWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollModel = ref.watch(scrollProvider);
    final notifier = ref.read(scrollProvider.notifier);

    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Privacy Policy', style: textTheme.titleLarge),
        backgroundColor: AppColors.screenBackgroundColor,
      ),
      body: Padding(
        padding: AppPadding.screenHorizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Effective Date: December 20, 2024',
                    style: textTheme.headlineMedium,
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ListView.builder(
                            controller: scrollModel.scrollController,
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return PolicyCard(textTheme: textTheme);
                            },
                          ),
                        ),
                        SizedBox(width: 8.w,),
                        Container(
                          height: scrollModel.scrollBarHeight,
                          width: scrollModel.scrollBarWidth,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade900,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top:
                                scrollModel.indicatorPosition,
                                child: Container(
                                  width: scrollModel.scrollBarWidth,
                                  height: scrollModel.indicatorHeight,
                                  decoration: BoxDecoration(
                                    color: Colors.tealAccent.shade700,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
