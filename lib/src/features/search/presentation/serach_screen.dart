import 'package:e_learning_app/src/features/search/presentation/widgets/search_bar.dart';
import 'package:e_learning_app/src/features/search/presentation/widgets/search_footer/search_footer.dart';
import 'package:e_learning_app/src/features/search/presentation/widgets/user_review_list.dart';
import '../../../../core/utils/common_widget.dart';
import './widgets/featured_experts_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header
            CommonWidget.customAppBar(
              textTheme: Theme.of(context).textTheme,
              isNotification: false,
              title: "Find Experts",
              subtitle: "Connect with Professionals",
            ),

            SizedBox(height: 24.h),

            /// Search Container
            ExpertSearchBar(),

            SizedBox(height: 24.h),

            /// Featured Experts list
            FeaturedExpertsList(),

            SizedBox(height: 24.h),

            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20),
              child: UserReviewList(),
            ),

            SizedBox(height: 24.h),

            SearchFooter(),

            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
