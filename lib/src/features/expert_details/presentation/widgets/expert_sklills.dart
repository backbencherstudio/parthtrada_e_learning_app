import 'package:e_learning_app/src/features/search/presentation/widgets/wrapper_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpertSkill extends StatelessWidget{
   ExpertSkill({super.key});

  final List<String> expertSkillList = ["Machine Learning", "Data Science", "Software Engineering"];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 6.h,
      children: [
        Text("Skills",style: Theme.of(context).textTheme.headlineSmall,),
        WrapperList(contentList: expertSkillList,
        textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600,),
        )
      ],
    );
  }
}