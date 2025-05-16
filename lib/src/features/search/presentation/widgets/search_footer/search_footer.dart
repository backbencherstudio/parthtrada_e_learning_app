import 'package:e_learning_app/core/constant/logos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/constant/padding.dart';
import 'app_details_container.dart';
import 'app_mentors_container.dart';

class SearchFooter extends StatelessWidget {
  const SearchFooter({super.key});



  @override
  Widget build(BuildContext context) {
    List<String> mentorsLogoPath = [
      AppLogos.google,
      AppLogos.meta,
      AppLogos.tesla,
      AppLogos.microsoft,
    ];
    return Padding(
      padding: AppPadding.screenHorizontal,
      child: Column(
        children: [

          /// App Details
          AppDetailsContainer(),

          SizedBox(height: 24.h),

          /// App Mentors
          AppMentorsShow(),
        ],
      ),
    );
  }
}
