import 'package:e_learning_app/src/features/expert_details/model/expert_detail_model.dart';
import 'package:e_learning_app/src/features/expert_details/presentation/widgets/expert_bottom_book_button.dart';
import 'package:e_learning_app/src/features/expert_details/presentation/widgets/expert_details_body.dart';
import 'package:e_learning_app/src/features/expert_details/presentation/widgets/expert_details_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../book_expert/rvierpod/book_expert_riverpod.dart';
import '../riverpod/expert_details_provider.dart';

class ExpertDetailsScreen extends ConsumerWidget {
  final String id;
  final String userName;
  final String userId;
  final String hourlyRate;
  final List<String> availableTime;
  final List<String> availableDays;
  const ExpertDetailsScreen({
    super.key,
    required this.id,
    required this.userName,
    required this.userId,
    required this.hourlyRate,
    required this.availableTime,
    required this.availableDays,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expertDetailAsync = ref.watch(expertDetailProvider(userId));

    return Scaffold(
      bottomNavigationBar: ExpertDetailsBottomBookButton(
        username: userName,
        userId: userId,
        hourlyRate: hourlyRate,
        availableTime: availableTime,
        availableDays: availableDays,
      ),
      body: expertDetailAsync.when(
        data: (expertDetail) {
          final expert = expertDetail.data?.expert;
          if (expert == null) {
            return const Center(child: Text("Expert details not found"));
          }
          final bookingController = ref.watch(
            bookExpertRiverpod(expertDetail.data?.expert?.availableTime ?? []),
          );

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExpertDetailsHeader(
                  name: expert.user?.name ?? "Unknown",
                  rating: (expertDetail.data?.stats?.averageRating ?? 0.0)
                      .toStringAsFixed(1),
                  profession: expert.profession ?? "N/A",
                  location: expert.location ?? "Unknown",
                  imageUrl: expert.user?.image,
                  organization: expert.organization ?? "",
                  recipientId: expert.user?.id ?? '',
                ),

                SizedBox(height: 24.h),

                ExpertDetailsBody(
                  description: expert.description ?? "",
                  skills: expert.skills ?? [],
                  availableDays: expert.availableDays ?? [],
                  availableTime: expert.availableTime ?? [],
                  stats: expertDetail.data?.stats,
                  experience: expertDetail.data?.expert?.experience.toString() ?? '0',
                  expertId: userId,
                  availability: expertDetail.data?.expert?.availability ?? Availability(),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Failed to load details: $err")),
      ),
    );
  }
}
