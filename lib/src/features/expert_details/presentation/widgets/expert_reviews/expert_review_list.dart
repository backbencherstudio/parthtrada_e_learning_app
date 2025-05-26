import 'package:e_learning_app/src/features/expert_details/presentation/widgets/expert_reviews/review_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../riverpod/expert_riverpod.dart';

class ExpertReviewList extends StatelessWidget {
  const ExpertReviewList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, ref, _) {
        final expertState = ref.watch(expertRiverpod);
        return expertState.expertReviewList == null
            ? Center(child: CircularProgressIndicator())
            : Column(
              children: [
                ListView.builder(
                  itemCount:
                      !expertState.isFullReviewShow
                          ? 3
                          : expertState.expertReviewList!.length,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final review = expertState.expertReviewList![index];
                    return ReviewCard(review: review);
                  },
                ),

                SizedBox(height: 20.h),

                if (expertState.expertReviewList!.length > 3)
                  TextButton(
                    onPressed:
                        () =>
                            ref.read(expertRiverpod.notifier).showFullReview(),
                    child: Text(
                      expertState.isFullReviewShow
                          ? "View less reviews"
                          : "View more reviews (${expertState.expertReviewList!.length - 3})",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            );
      },
    );
  }
}
