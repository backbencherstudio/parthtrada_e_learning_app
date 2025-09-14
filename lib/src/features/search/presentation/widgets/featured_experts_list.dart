import 'package:e_learning_app/core/constant/icons.dart';
import 'package:e_learning_app/core/constant/padding.dart';
import 'package:e_learning_app/core/routes/route_name.dart';
import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:e_learning_app/core/utils/common_widget.dart';
import 'package:e_learning_app/core/utils/utils.dart';
import 'package:e_learning_app/repository/linkedin_login_webview.dart';
import 'package:e_learning_app/src/features/search/model/data_model.dart';
import 'package:e_learning_app/src/features/search/presentation/widgets/wrap_item_container.dart';
import 'package:e_learning_app/src/features/search/provider/expert_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../book_expert/presentation/schedule_for_book/schedule_for_book.dart';

class FeaturedExpertsList extends ConsumerWidget {
  final bool isSearching;
  final List<DataModel>? searchedExperts;

  const FeaturedExpertsList({
    super.key,
    this.isSearching = false,
    this.searchedExperts,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final expertData = ref.watch(expertProvider);

    return expertData.when(
      data: (expertModel) {
        final experts =
            isSearching && searchedExperts != null
                ? searchedExperts!
                : expertModel.data ?? [];

        if (experts.isEmpty) {
          return Padding(
            padding: AppPadding.screenHorizontal,
            child: const Text("No experts found"),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: AppPadding.screenHorizontal,
              child: Text(
                "Featured Experts",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            SizedBox(height: 16.h),

            /// If searching → vertical list
            if (isSearching)
              Expanded(
                child: ListView.builder(
                  itemCount: experts.length,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemBuilder: (_, index) {
                    final expert = experts[index];
                    return buildExpertCard(
                      context,
                      expert,
                      textTheme,
                      isSearching,
                    );
                  },
                ),
              )
            /// Default → horizontal carousel
            else
              SizedBox(
                height: 340.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: experts.length,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemBuilder: (_, index) {
                    final expert = experts[index];
                    return buildExpertCard(
                      context,
                      expert,
                      textTheme,
                      isSearching,
                    );
                  },
                ),
              ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text("Error: $err")),
    );
  }

  Widget buildExpertCard(
    BuildContext context,
    DataModel expert,
    TextTheme textTheme,
    bool isSearching,
  ) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: isSearching ? 16.h : 0,
        right: isSearching ? 0 : 12.w,
      ),
      child: GestureDetector(
        onTap: () {
          context.push(RouteName.expertDetailsScreen, extra: expert.id);
        },
        child: Container(
          width: isSearching ? double.infinity : 274.w,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
          decoration: Utils.commonBoxDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Profile picture
              ClipOval(
                child:
                    expert.user?.image != null && expert.user!.image!.isNotEmpty
                        ? Image.network(
                          '$baseUrl/uploads/${expert.user!.image!}',
                          width: 56.r,
                          height: 56.r,
                          fit: BoxFit.cover,
                        )
                        : CircleAvatar(
                          radius: 28.w,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.person,
                            color: Colors.grey,
                            size: 28.w,
                          ),
                        ),
              ),
              SizedBox(height: 16.h),

              /// Name
              Text(
                expert.user?.name ?? "",
                style: textTheme.titleLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4.h),

              /// Profession
              Text(
                expert.profession ?? "",
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.secondaryTextColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 7.h),

              /// Rating
              Row(
                spacing: 4.w,
                children: [
                  Icon(Icons.star, color: AppColors.primary, size: 20.sp),
                  Text(expert.rating?.avg.toString() ?? "0"),
                  SizedBox(width: 4.w),
                  Text(
                    "(${expert.rating?.total.toString() ?? "0"} reviews)",
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.secondaryTextColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 7.h),

              /// Skills
              Row(
                spacing: 8.w,
                children: [
                  ...expert.skills!
                      .take(2)
                      .map(
                        (skill) =>
                            Expanded(child: WrapItemContainer(text: skill)),
                      )
                      .toList(),
                  if (expert.skills!.length > 2)
                    WrapItemContainer(
                      text: "+${expert.skills!.length - 2}",
                      isRemainingItemShow: true,
                    ),
                ],
              ),
              SizedBox(height: 7.h),

              /// Availability
              Row(
                spacing: 8.w,
                children: [
                  SvgPicture.asset(
                    AppIcons.calendar,
                    width: 20.w,
                    height: 20.h,
                  ),
                  Text(
                    "Next available: Mon 2pm...",
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.secondaryTextColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),

              /// Book button
              SizedBox(
                width: double.infinity,
                child: CommonWidget.primaryButton(
                  context: context,
                  onPressed: () async {
                    await scheduleForBook(context: context);
                  },
                  text: "Book \$${expert.hourlyRate}/hour",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
