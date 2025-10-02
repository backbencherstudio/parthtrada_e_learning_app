import 'package:e_learning_app/src/features/expert_details/presentation/widgets/expert_bottom_book_button.dart';
import 'package:e_learning_app/src/features/expert_details/presentation/widgets/expert_details_body.dart';
import 'package:e_learning_app/src/features/expert_details/presentation/widgets/expert_details_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../riverpod/expert_details_provider.dart';

class ExpertDetailsScreen extends ConsumerWidget {
  final String id;
  final String hourlyRate;
  const ExpertDetailsScreen({super.key, required this.id, required this.hourlyRate});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expertDetailAsync = ref.watch(expertDetailProvider(id));

    return Scaffold(
      bottomNavigationBar: ExpertDetailsBottomBookButton(hourlyRate: hourlyRate,),
      body: expertDetailAsync.when(
        data: (expertDetail) {
          final expert = expertDetail.data?.expert;
          if (expert == null) {
            return const Center(child: Text("Expert details not found"));
          }

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
                ),

                SizedBox(height: 24.h),

                ExpertDetailsBody(
                  description: expert.description ?? "",
                  skills: expert.skills ?? [],
                  availableDays: expert.availableDays ?? [],
                  availableTime: expert.availableTime ?? [],
                  stats: expertDetail.data?.stats,
                  experience: expertDetail.data?.expert?.experience.toString() ?? '0',
                  expertId: id,
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (err, stack) => Center(child: Text("Failed to load details: $err")),
      ),
    );
  }
}
