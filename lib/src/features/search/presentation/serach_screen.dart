import 'package:e_learning_app/core/routes/route_name.dart';
import 'package:e_learning_app/src/features/search/presentation/widgets/search_footer/search_footer.dart';
import 'package:e_learning_app/src/features/search/presentation/widgets/user_review_list.dart';
import 'package:e_learning_app/src/features/search/presentation/widgets/featured_experts_list.dart';
import 'package:e_learning_app/src/features/search/provider/expert_search_query_provider.dart';
import 'package:e_learning_app/src/features/search/provider/expert_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constant/icons.dart';
import '../../../../core/constant/padding.dart';
import '../../../../core/theme/theme_part/app_colors.dart';
import '../../../../core/utils/common_widget.dart';
import '../../../../core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

            Padding(
              padding: EdgeInsets.all(16.h),
              child: GestureDetector(
                onTap: () async {
                  await context.push(RouteName.expertSearchScreen);

                  ref.read(expertSearchQueryProvider.notifier).state = '';
                  await ref
                      .read(expertPaginationProvider.notifier)
                      .fetchExperts(reset: true);
                },
                child: SizedBox(
                  height: 48.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.fillColor,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.w,
                                  vertical: 14.h,
                                ),
                                child: SvgPicture.asset(
                                  AppIcons.search,
                                  colorFilter: const ColorFilter.mode(
                                    Colors.white,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                              const Text('Search by expert name'),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      GestureDetector(
                        child: Container(
                          padding: EdgeInsets.all(14.r),
                          decoration: Utils.commonBoxDecoration(),
                          child: SvgPicture.asset(AppIcons.filter),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 24.h),

            Padding(
              padding: AppPadding.screenHorizontal,
              child: Row(
                children: [
                  Text(
                    "Featured Experts",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () async {
                      await context.push(RouteName.expertSearchScreen);
                      ref.read(expertSearchQueryProvider.notifier).state = '';
                      await ref
                          .read(expertPaginationProvider.notifier)
                          .fetchExperts(reset: true);
                    },
                    child: Text(
                      "View all",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            FeaturedExpertsList(isVerticalList: false),

            SizedBox(height: 24.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
