import 'package:e_learning_app/core/constant/icons.dart';
import 'package:e_learning_app/core/constant/images.dart';
import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:e_learning_app/core/utils/common_widget.dart';
import 'package:e_learning_app/src/features/expert_details/model/expert_review_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../repository/api/schedule/add_review_repository.dart';
import '../../../../expert_details/model/temp/temp_expert_review_model.dart';
import '../../../../expert_details/riverpod/expert_riverpod.dart';
import '../../../riverpod/add_review_provider.dart';

class AddReviewForExpert extends ConsumerStatefulWidget {
  const AddReviewForExpert({super.key});

  @override
  ConsumerState<AddReviewForExpert> createState() => _AddReviewForExpertState();
}

class _AddReviewForExpertState extends ConsumerState<AddReviewForExpert> {
  late final TextEditingController _reviewTextEditingController;
  late final FocusNode _focusNode;

  @override
  void initState() {
    _reviewTextEditingController = TextEditingController();
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _reviewTextEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final reviewState = ref.watch(addReviewProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(height: 32.h),

        Text("Rate this Expert", style: textTheme.titleLarge),
        SizedBox(height: 4.h),
        Text(
          "Click according to your satisfaction.",
          style: textTheme.bodySmall?.copyWith(
            color: AppColors.secondaryTextColor,
          ),
        ),

        SizedBox(height: 12.h),

        /// Star ratings
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            5, (index) {
              final isFilled = index < reviewState.rating;
              return GestureDetector(
                onTap: () {
                  ref.read(addReviewProvider.notifier).state =
                      reviewState.copyWith(rating: index + 1);
                },
                child: SvgPicture.asset(
                  isFilled ? AppIcons.starFill : AppIcons.starOutline,
                  width: 30.w,
                  height: 30.w,
                ),
              );
            },
          ),
        ),

        SizedBox(height: 18.h),

        /// Comments review
        Text(
          "Write a review",
          style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 10.h),

        TextFormField(
          controller: _reviewTextEditingController,
          focusNode: _focusNode,
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
          maxLines: 4,
          style: textTheme.bodySmall,
          decoration: InputDecoration(hintText: "Write a review"),
          onChanged: (val) {
            ref.read(addReviewProvider.notifier).state =
                reviewState.copyWith(description: val);
          },
        ),
        SizedBox(height: 18.h),
        SafeArea(
          child: Row(
            spacing: 10.w,
            children: [
              Expanded(
                child: CommonWidget.primaryButton(
                  context: context,
                  onPressed: () => context.pop(),
                  text: "Cancel",
                  backgroundColor: AppColors.secondary,
                  textStyle: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              Expanded(
                child: Consumer(
                  builder: (_, ref, _) {
                    return CommonWidget.primaryButton(
                      context: context,
                      onPressed: () async {
                        final review = ref.read(addReviewProvider);
                        if (_reviewTextEditingController.text.isEmpty || review.rating == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Please add rating and review")),
                          );
                          return;
                        }
                        ref.read(addReviewProvider.notifier).state = review.copyWith(
                          description: _reviewTextEditingController.text,
                        );
                        try {
                          final success = await AddReviewRepository().addReview(
                            review: ref.read(addReviewProvider),
                          );

                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Review submitted successfully!")),
                            );
                            context.pop();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Failed to submit review")),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Error: $e")),
                          );
                        }
                      },
                      text: "Submit",
                      textStyle: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 28.h),
      ],
    );
  }
}
