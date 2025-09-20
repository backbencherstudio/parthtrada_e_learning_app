import 'package:e_learning_app/src/features/expert_details/presentation/widgets/expert_reviews/review_card.dart';
import 'package:e_learning_app/src/features/expert_details/riverpod/expert_riverpod1.dart';
import 'package:e_learning_app/src/features/onboarding/riverpod/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpertReviewList extends ConsumerStatefulWidget {
  final String id;
  const ExpertReviewList({super.key, required this.id});

  @override
  ConsumerState<ExpertReviewList> createState() => _ExpertReviewListState();
}

class _ExpertReviewListState extends ConsumerState<ExpertReviewList> {
  @override
  void initState() {
    super.initState();
    final authToken = ref.read(authTokenProvider);
    if (authToken != null) {
      ref
          .read(expertReviewListProvider.notifier)
          .fetchReviews(page: 1, id: widget.id, token: authToken);
    }
  }

  @override
  Widget build(BuildContext context) {
    final reviewsState = ref.watch(expertReviewListProvider);
    final expertReviewNotifier = ref.read(expertReviewListProvider.notifier);

    if (reviewsState == null) {
      return Center(child: CircularProgressIndicator());
    }

    final expertReviewList = reviewsState.items ?? [];

    if (expertReviewList.isEmpty) {
      return Center(child: Text('No reviews available.'));
    }

    return Column(
      children: [
        ListView.builder(
          itemCount:
              !expertReviewNotifier.isFullReviewShow
                  ? 3
                  : expertReviewList.length,
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            if (index >= expertReviewList.length) {
              return SizedBox.shrink();
            }
            final review = expertReviewList[index];
            return ReviewCard(review: review);
          },
        ),

        SizedBox(height: 20.h),

        if (expertReviewList.length > 3)
          TextButton(
            onPressed: () {
              expertReviewNotifier.showFullReview();
            },
            child: Text(
              expertReviewNotifier.isFullReviewShow
                  ? "View less reviews"
                  : "View more reviews (${expertReviewList.length - 3})",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
      ],
    );
  }
}
