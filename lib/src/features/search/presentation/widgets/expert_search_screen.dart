import 'package:e_learning_app/src/features/search/presentation/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/routes/route_name.dart';
import '../../../../../core/utils/common_widget.dart';
import 'featured_experts_list.dart';

class ExpertSearchScreen extends StatelessWidget {
  const ExpertSearchScreen({super.key, required this.availableTime});

  final List<String> availableTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CommonWidget.customAppBar(
              textTheme: Theme.of(context).textTheme,
              isNotification: false,
              title: "Find Experts",
              subtitle: "Connect with Professionals",
            ),

            SizedBox(height: 24.h),

            /// Search Container
            ExpertSearchBar(
              readOnly: false,
            ),

            SizedBox(height: 24.h),

            /// Featured Experts list
            FeaturedExpertsList(
              isVerticalList: true,
            ),
          ],
        ),
      ),
    );
  }
}
