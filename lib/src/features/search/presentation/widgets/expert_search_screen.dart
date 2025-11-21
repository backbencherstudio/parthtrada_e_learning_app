import 'package:e_learning_app/src/features/search/presentation/widgets/search_bar.dart';
import 'package:e_learning_app/src/features/search/presentation/widgets/featured_experts_list.dart';
import 'package:e_learning_app/src/features/search/provider/expert_search_query_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/common_widget.dart';
import '../../provider/expert_provider.dart';
import '../../provider/selected_skill_provider.dart';

class ExpertSearchScreen extends ConsumerStatefulWidget {
  const ExpertSearchScreen({super.key});

  @override
  ConsumerState<ExpertSearchScreen> createState() =>
      _ExpertSearchScreenState();
}

class _ExpertSearchScreenState extends ConsumerState<ExpertSearchScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ref.read(expertSearchQueryProvider.notifier).state = '';
        ref.read(selectedSkillsProvider.notifier).clear();
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CommonWidget.customAppBar(
                  textTheme: Theme.of(context).textTheme,
                  isNotification: false,
                  title: "Find Experts",
                  subtitle: "Connect with Professionals",
                  context: context,
                  showBackButton: true

                ),
                SizedBox(height: 24.h),
                const ExpertSearchBar(readOnly: false),
                SizedBox(height: 24.h),
                const Expanded(child: FeaturedExpertsList(isVerticalList: true)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
