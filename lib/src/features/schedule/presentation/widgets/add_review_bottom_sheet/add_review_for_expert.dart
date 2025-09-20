import 'package:e_learning_app/core/constant/icons.dart';
import 'package:e_learning_app/core/constant/images.dart';
import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:e_learning_app/core/utils/common_widget.dart';
import 'package:e_learning_app/src/features/expert_details/model/expert_review_model.dart';
import 'package:e_learning_app/src/features/expert_details/riverpod/expert_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class AddReviewForExpert extends StatefulWidget {
  const AddReviewForExpert({super.key});

  @override
  State<AddReviewForExpert> createState() => _AddReviewForExpertState();
}

class _AddReviewForExpertState extends State<AddReviewForExpert> {
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            5,
            (index) => Consumer(
              builder: (_, ref, _) {
                final expertState = ref.watch(expertRiverpod);
                final expertNotifier = ref.read(expertRiverpod.notifier);
                return GestureDetector(
                  onTap: () => expertNotifier.onRating(ratings: index + 1),
                  child: SvgPicture.asset(
                    AppIcons.starOutline,
                    width: 30.w,
                    height: 30.w,
                    colorFilter: ColorFilter.mode(
                      index + 1 <= expertState.starRating
                          ? AppColors.primary
                          : Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                );
              },
            ),
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
                    final expertNotifier = ref.read(expertRiverpod.notifier);
                    final expertState = ref.watch(expertRiverpod);
                    return CommonWidget.primaryButton(
                      context: context,
                      onPressed: () {
                        if (_reviewTextEditingController.text.isNotEmpty) {
                          expertNotifier.addReviews(
                            userReview: ExpertReviewModel(
                              userName: "Olivia Rhye",
                              eMail: "Olivi****@gmail.com",
                              profilePicture: AppImages.women,
                              ratings: expertState.starRating,
                              reviews: _reviewTextEditingController.text,
                            ),
                          );
                          context.pop();
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
