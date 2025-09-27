// expert_skills.dart
import 'package:e_learning_app/src/features/search/presentation/widgets/wrapper_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpertSkill extends StatelessWidget {
  final List<String> skills;
  const ExpertSkill({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Skills", style: Theme.of(context).textTheme.headlineSmall),
        SizedBox(height: 6.h),
        WrapperList(
          contentList: skills,
          textStyle: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
