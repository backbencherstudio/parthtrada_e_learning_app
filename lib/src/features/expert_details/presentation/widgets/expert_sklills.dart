// import 'package:e_learning_app/src/features/search/presentation/widgets/wrapper_list.dart';
// import 'package:flutter/material.dart';

// class ExpertSkill extends StatelessWidget {
//   ExpertSkill({super.key});

//   final List<String> expertSkillList = [
//     "Machine Learning",
//     "Data Science",
//     "Software Engineering",
//   ];

//   void onSkillSelected(String selectedSkill) {
//     print('Selected Skill: $selectedSkill');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text("Skills", style: Theme.of(context).textTheme.headlineSmall),
//         WrapperList(
//           contentList: expertSkillList,
//           textStyle: Theme.of(
//             context,
//           ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
//           onSkillSelected: onSkillSelected,
//         ),
//       ],
//     );
//   }
// }

import 'package:e_learning_app/repository/expert_skills.dart';
import 'package:e_learning_app/src/features/onboarding/riverpod/login_state.dart';
import 'package:e_learning_app/src/features/search/presentation/widgets/wrapper_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final skillsProvider = FutureProvider.family<List<String>, String>((
  ref,
  authToken,
) async {
  final service = ExpertService();
  return service.fetchSkills(authToken);
});

class ExpertSkill extends ConsumerWidget {
  const ExpertSkill({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authToken = ref.watch(authTokenProvider);
    final skillsAsync = ref.watch(skillsProvider(authToken!));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Skills", style: Theme.of(context).textTheme.headlineSmall),
        skillsAsync.when(
          data: (skills) {
            return WrapperList(
              contentList: skills,
              textStyle: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
              onSkillSelected: (selectedSkill) {},
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(child: Text("Error: $error")),
        ),
      ],
    );
  }
}
