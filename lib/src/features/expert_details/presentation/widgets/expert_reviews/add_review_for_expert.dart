import 'package:e_learning_app/core/constant/icons.dart';
import 'package:e_learning_app/core/constant/images.dart';
import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:e_learning_app/core/utils/common_widget.dart';
import 'package:e_learning_app/src/features/expert_details/model/expert_review_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../riverpod/expert_riverpod.dart';

class AddReviewForExpert extends StatefulWidget {
  const AddReviewForExpert({super.key});

  @override
  State<AddReviewForExpert> createState() => _AddReviewForExpertState();
}

class _AddReviewForExpertState extends State<AddReviewForExpert> {

  late final TextEditingController reviewTextEditingController;

  @override
  void initState() {
    reviewTextEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    reviewTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("+ Add Your Review", style: textTheme.headlineSmall),
        SizedBox(height: 30.h),

        Text("Rate this", style: textTheme.titleLarge),
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
                  onTap: ()=>expertNotifier.onRating(ratings: index+1),
                  child: SvgPicture.asset(
                    AppIcons.starOutline,
                    width: 30.w,
                    height: 30.w,
                    colorFilter: ColorFilter.mode(
                       index+1 <= expertState.starRating ? AppColors.primary : Colors.white, BlendMode.srcIn),
                  ),
                );
              }
            ),
          ),
        ),

        SizedBox(height: 18.h),
        /// Comments review
        Text("Write a review",style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),),
        SizedBox(height: 10.h,),

        TextFormField(
          controller: reviewTextEditingController,
          maxLines: 4,
          style: textTheme.bodySmall,
          decoration: InputDecoration(
            hintText: "Write a review"
          )
        ),
        SizedBox(height: 18.h,),
        Consumer(
          builder: (_,ref, _) {
            final expertNotifier = ref.read(expertRiverpod.notifier);
            final expertState = ref.watch(expertRiverpod);
            return CommonWidget.primaryButton(
              context: context,
              onPressed: (){
                if(reviewTextEditingController.text.isNotEmpty){
                  expertNotifier.addReviews(userReview: ExpertReviewModel(
                    userName: "Olivia Rhye",
                    eMail: "Olivi****@gmail.com",
                    profilePicture: AppImages.women,
                    ratings: expertState.starRating,
                    reviews: reviewTextEditingController.text,
                  ));
                }

              },
              text: "Submit",
            textStyle: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),);
          }
        )
      ],
    );
  }
}
