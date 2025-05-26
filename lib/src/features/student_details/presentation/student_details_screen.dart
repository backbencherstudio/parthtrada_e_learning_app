import 'package:e_learning_app/src/features/student_details/presentation/widgets/bottom_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'widgets/header_widgets.dart';
import 'widgets/professional_bio.dart';
import 'widgets/qna_section.dart';

class StudentDetailsScreen extends StatelessWidget {
  const StudentDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 24.w, right: 24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  spacing: 30.h,
                  children: [
                    SizedBox(height: 37.h),

                    HeaderWidget(textStyle: textStyle),

                    ProfessionalBio(textStyle: textStyle),

                    QNASection(textStyle: textStyle),

                    SizedBox(height: 30.h),
                  ],
                ),
              ),
            ),
          ),
          BottomSheetWidget(textStyle: textStyle),
        ],
      ),
    );
  }
}
