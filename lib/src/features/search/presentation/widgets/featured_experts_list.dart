import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:e_learning_app/src/features/search/model/expert_model.dart';
import 'package:e_learning_app/src/features/splash/riverpod/user_role_provider.dart';
import 'package:e_learning_app/core/utils/common_widget.dart';
import 'package:e_learning_app/core/utils/utils.dart';
import 'package:e_learning_app/core/services/api_services/api_end_points.dart';
import 'package:e_learning_app/core/constant/images.dart';
import 'package:e_learning_app/src/features/book_expert/rvierpod/session_provider.dart';
import 'package:e_learning_app/src/features/book_expert/presentation/schedule_for_book/schedule_for_book.dart';
import 'package:e_learning_app/src/features/search/presentation/widgets/wrap_item_container.dart';
import 'package:e_learning_app/src/features/search/provider/expert_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_name.dart';

class FeaturedExpertsList extends ConsumerStatefulWidget {
  const FeaturedExpertsList({super.key, required this.isVerticalList});
  final bool isVerticalList;

  @override
  ConsumerState<FeaturedExpertsList> createState() =>
      _FeaturedExpertsListState();
}

class _FeaturedExpertsListState extends ConsumerState<FeaturedExpertsList> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200) {
          ref.read(expertPaginationProvider.notifier).loadMoreExperts();
        }
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final expertsAsync = ref.watch(expertPaginationProvider);
    final userType = ref.watch(userRoleProvider);

    return expertsAsync.when(
      data: (experts) {
        if (experts.isEmpty) {
          return const Center(child: Text("No Experts Found"));
        }

        return SizedBox(
          height: widget.isVerticalList ? 550.h : 308.h,
          child: ListView.separated(
            controller: _scrollController,
            scrollDirection:
            widget.isVerticalList ? Axis.vertical : Axis.horizontal,
            itemCount: experts.length + 1,
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            itemBuilder: (_, index) {
              final notifier = ref.read(expertPaginationProvider.notifier);

              if (index == experts.length) {
                return notifier.hasNextPage
                    ? const Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(child: CircularProgressIndicator()),
                )
                    : const SizedBox.shrink();
              }

              final expert = experts[index];
              return _expertCard(
                context,
                textTheme,
                expert,
                userType ?? '',
                widget.isVerticalList,
                ref,
              );
            },
            separatorBuilder: (_, __) => SizedBox(
              height: widget.isVerticalList ? 12.h : 0.h,
              width: widget.isVerticalList ? 0.w : 12.w,
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text("Error: $err")),
    );
  }

  Widget _expertCard(BuildContext context, TextTheme textTheme, Data expert,
      String userType, bool isVerticalList, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        context.push(
          RouteName.expertDetailsScreen,
          extra: {
            'id': expert.id,
            'userName': expert.user?.name,
            'userId': expert.userId,
            'hourlyRate': expert.hourlyRate,
            'availableTime': expert.availableTime,
            'availableDays': expert.availableDays,
          },
        );
      },
      child: Container(
        width: isVerticalList ? double.infinity : 274.w,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
        decoration: Utils.commonBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipOval(
              child: expert.user?.image != null &&
                  (expert.user!.image?.isNotEmpty ?? false)
                  ? Image.network(
                '${ApiEndPoints.baseUrl}/uploads/${expert.user!.image!}',
                width: 56.w,
                height: 56.w,
                fit: BoxFit.cover,
              )
                  : CircleAvatar(
                radius: 28.w,
                backgroundColor: Colors.white,
                child: Image.asset(
                  AppImages.maiya,
                  width: 32.w,
                  height: 32.w,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              expert.user?.name ?? '',
              style: textTheme.titleLarge,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4.h),
            Text(
              expert.profession ?? '',
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.secondaryTextColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 7.h),
            Row(
              children: [
                Icon(Icons.star, color: AppColors.primary, size: 20.sp),
                SizedBox(width: 4.w),
                Text(expert.rating?.avg?.toString() ?? '0'),
                SizedBox(width: 4.w),
                Text(
                  "(${expert.rating?.total ?? 0} reviews)",
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.secondaryTextColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 7.h),
            Row(
              children: [
                ...expert.skills!.take(2).map(
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
            SizedBox(height: 12.h),
            SizedBox(
              width: double.infinity,
              child: CommonWidget.primaryButton(
                context: context,
                onPressed: () async {
                  if (userType == 'EXPERT') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('You are already an expert'),
                      ),
                    );
                  } else {
                    final sessionDataNotifier =
                    ref.read(sessionDataProvider.notifier);
                    sessionDataNotifier.setExpertId(expert.userId ?? '');
                    sessionDataNotifier.setExpertName(expert.user?.name ?? '');
                    sessionDataNotifier
                        .setHourlyRate(expert.hourlyRate.toString());
                    await scheduleForBook(
                      ref: ref,
                      context: context,
                      availableTime: expert.availableTime ?? [],
                      availableDays: expert.availableDays ?? [],
                    );
                  }
                },
                text: "Book \$${expert.hourlyRate}/hour",
                backgroundColor: userType == 'EXPERT'
                    ? AppColors.secondaryStrokeColor
                    : AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
