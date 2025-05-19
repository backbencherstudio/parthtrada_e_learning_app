import 'package:e_learning_app/src/features/expert_details/presentation/widgets/expert_bottom_book_button.dart';
import 'package:e_learning_app/src/features/expert_details/presentation/widgets/expert_details_body.dart';
import 'package:e_learning_app/src/features/expert_details/presentation/widgets/expert_details_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpertDetailsScreen extends StatelessWidget{
  const ExpertDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ExpertDetailsBottomBackButton(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpertDetailsHeader(),
            SizedBox(height: 24.h,),
            ExpertDetailsBody(),
          ],
        ),
      ),
    );
  }
}