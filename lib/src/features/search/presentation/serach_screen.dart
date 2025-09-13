// import 'package:e_learning_app/src/features/search/presentation/widgets/search_bar.dart';
// import 'package:e_learning_app/src/features/search/presentation/widgets/search_footer/search_footer.dart';
// import 'package:e_learning_app/src/features/search/presentation/widgets/user_review_list.dart';
// import '../../../../core/utils/common_widget.dart';
// import './widgets/featured_experts_list.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class SearchScreen extends StatelessWidget {
//   const SearchScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [

//             /// Header
//             CommonWidget.customAppBar(
//               textTheme: Theme.of(context).textTheme,
//               isNotification: false,
//               title: "Find Experts",
//               subtitle: "Connect with Professionals",
//             ),

//             SizedBox(height: 24.h),

//             /// Search Container
//             ExpertSearchBar(),

//             SizedBox(height: 24.h),

//             /// Featured Experts list
//             FeaturedExpertsList(),

//             SizedBox(height: 24.h,),

//             UserReviewList(),

//             SizedBox(height: 24.h,),

//             SearchFooter(),

//             SizedBox(height: 24.h,),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:e_learning_app/src/features/onboarding/riverpod/login_state.dart';
import 'package:e_learning_app/src/features/search/presentation/widgets/search_bar.dart';
import 'package:e_learning_app/src/features/search/presentation/widgets/search_footer/search_footer.dart';
import 'package:e_learning_app/src/features/search/presentation/widgets/user_review_list.dart';
import 'package:e_learning_app/src/features/search/provider/expert_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/common_widget.dart';
import './widgets/featured_experts_list.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  bool isSearching = false;
  String searchQuery = '';

  void updateSearching(String value) {
    setState(() {
      searchQuery = value;
      isSearching = value.isNotEmpty;
    });

    if (isSearching) {
      final authToken = ref.watch(authTokenProvider);
      ref
          .read(mExpertProvider.notifier)
          .fetchExperts(name: value, authToken: authToken);
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchedExpertState = ref.watch(mExpertProvider);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header
          CommonWidget.customAppBar(
            textTheme: Theme.of(context).textTheme,
            isNotification: false,
            title: "Find Experts",
            subtitle: "Connect with Professionals",
          ),
          SizedBox(height: 24.h),

          /// Search bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: ExpertSearchBar(onQueryChanged: updateSearching),
          ),
          SizedBox(height: 24.h),

          /// If searching → show results
          if (isSearching)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: searchedExpertState.when(
                  data:
                      (experts) => FeaturedExpertsList(
                        isSearching: true,
                        searchedExperts: experts,
                      ),
                  loading:
                      () => const Center(child: CircularProgressIndicator()),
                  error: (err, _) => Center(child: Text("Error: $err")),
                ),
              ),
            )
          /// Else → default home content
          else
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: FeaturedExpertsList(isSearching: false),
                    ),
                    SizedBox(height: 24.h),
                    UserReviewList(),
                    SizedBox(height: 24.h),
                    SearchFooter(),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
