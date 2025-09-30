import 'package:e_learning_app/core/constant/icons.dart';
import 'package:e_learning_app/core/constant/padding.dart';
import 'package:e_learning_app/core/routes/route_name.dart';
import 'package:e_learning_app/core/services/api_services/api_end_points.dart';
import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:e_learning_app/core/utils/common_widget.dart';
import 'package:e_learning_app/core/utils/utils.dart';
import 'package:e_learning_app/repository/linkedin_login_webview.dart';
import 'package:e_learning_app/src/features/search/presentation/widgets/wrap_item_container.dart';
import 'package:e_learning_app/src/features/search/provider/expert_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../book_expert/presentation/schedule_for_book/schedule_for_book.dart';

class FeaturedExpertsList extends ConsumerWidget {
  const FeaturedExpertsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    final expertData = ref.watch(expertProvider);

    return expertData.when(
      data: (expertModel) {
        final experts = expertModel.data ?? [];
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

            SizedBox(
              height: 308.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: experts.length,
                padding: EdgeInsets.symmetric(horizontal: 24.w),

                itemBuilder: (_, index) {
                  final expert = experts[index];
                  return FittedBox(
                    child: GestureDetector(
                      onTap: () {
                        context.push(
                          RouteName.expertDetailsScreen,
                          extra: expert.id,
                        );
                      },
                      child: Container(
                        width: 274.w,
                        margin: EdgeInsets.only(right: 12.w),
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 16.h,
                        ),
                        decoration: Utils.commonBoxDecoration(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipOval(
                              child:
                                  expert.user?.image != null &&
                                          expert.user!.image!.isNotEmpty
                                      ? Image.network(
                                        '${ApiEndPoints.baseUrl}/uploads/${expert.user!.image!}',
                                        width: 56.w,
                                        height: 56.w,
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
                            Text(
                              expert.user!.name.toString(),
                              style: textTheme.titleLarge,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              expert.profession.toString(),
                              style: textTheme.bodyMedium?.copyWith(
                                color: AppColors.secondaryTextColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),

                            SizedBox(height: 7.h),

                            Row(
                              spacing: 4.w,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: AppColors.primary,
                                  size: 20.sp,
                                ),
                                Text(expert.rating!.avg.toString()),
                                SizedBox(width: 4.w),
                                Text(
                                  "(${expert.rating!.total.toString()} reviews)",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.copyWith(
                                    color: AppColors.secondaryTextColor,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 7.h),

                            Row(
                              spacing: 8.w,
                              children: [
                                ...expert.skills!
                                    .take(2)
                                    .map(
                                      (skill) => Expanded(
                                        child: WrapItemContainer(text: skill),
                                      ),
                                    ),
                                if (expert.skills!.length > 2)
                                  WrapItemContainer(
                                    text: "+${expert.skills!.length - 2}",
                                    isRemainingItemShow: true,
                                  ),
                              ],
                            ),

                            SizedBox(height: 7.h),

                            // Row(
                            //   spacing: 8.w,
                            //   children: [
                            //     SvgPicture.asset(
                            //       AppIcons.calendar,
                            //       width: 20.w,
                            //       height: 20.h,
                            //     ),
                            //     Text(
                            //       "Next available: Mon 2pm...",
                            //       style: Theme.of(
                            //         context,
                            //       ).textTheme.bodyMedium?.copyWith(
                            //         color: AppColors.secondaryTextColor,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            SizedBox(height: 12.h),

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
}
