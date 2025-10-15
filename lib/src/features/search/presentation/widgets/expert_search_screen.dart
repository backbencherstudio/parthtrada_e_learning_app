import 'package:e_learning_app/src/features/search/presentation/widgets/search_bar.dart';
import 'package:e_learning_app/src/features/search/presentation/widgets/featured_experts_list.dart';
import 'package:e_learning_app/src/features/search/provider/expert_search_query_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/common_widget.dart';

class ExpertSearchScreen extends ConsumerStatefulWidget {
  const ExpertSearchScreen({super.key});

  @override
  ConsumerState<ExpertSearchScreen> createState() =>
      _ExpertSearchScreenState();
}

class _ExpertSearchScreenState extends ConsumerState<ExpertSearchScreen> {
  @override
  void dispose() {
    ref.read(expertSearchQueryProvider.notifier).state = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CommonWidget.customAppBar(
              textTheme: Theme.of(context).textTheme,
              isNotification: false,
              title: "Find Experts",
              subtitle: "Connect with Professionals",
            ),
            SizedBox(height: 24.h),
            const ExpertSearchBar(readOnly: false),
            SizedBox(height: 24.h),
            const Expanded(
              child: FeaturedExpertsList(isVerticalList: true),
            ),
          ],
        ),
      ),
    );
  }
}
