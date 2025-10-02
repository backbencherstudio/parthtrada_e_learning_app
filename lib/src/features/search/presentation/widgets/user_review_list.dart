import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constant/images.dart';
import '../../../../../core/services/api_services/api_end_points.dart';
import '../../provider/expert_review_provider.dart';

class UserReviewList extends ConsumerWidget {
  const UserReviewList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewsAsync = ref.watch(expertReviewProvider);

    return reviewsAsync.when(
      data: (reviews) {
        if (reviews.data == null || reviews.data!.isEmpty) {
          return const Center(child: Text("No Reviews Found"));
        }

        return SizedBox(
          height: 200, // adjust height as needed
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: reviews.data!.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final review = reviews.data![index];
              final student = review.student;

              return Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  width: 250, // width of each card
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ClipOval(
                            child:
                            review.student?.image != null
                                ? Image.network(
                              '${ApiEndPoints.baseUrl}/uploads/${review.student?.image}',
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
                          // CircleAvatar(
                          //   radius: 24,
                          //   backgroundImage: review.student?.image != null
                          //       ? NetworkImage(student!.image!)
                          //       : const NetworkImage(review.student?.image)
                          //   as ImageProvider,
                          // ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              student?.name ?? "Anonymous",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Text(
                          review.description ?? "",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Row(
                            children: List.generate(
                              5,
                                  (i) => Icon(
                                i < (review.rating ?? 0).round()
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.amber,
                                size: 16,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w,),
                          Text(review.rating.toString(), style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.amber, fontSize: 16.sp, fontWeight: FontWeight.w800))
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text("Error: $err")),
    );
  }
}
