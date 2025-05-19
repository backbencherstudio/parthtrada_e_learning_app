import 'package:e_learning_app/core/constant/images.dart';
import 'package:e_learning_app/core/constant/padding.dart';
import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:e_learning_app/core/utils/common_widget.dart';
import 'package:e_learning_app/src/features/expert_details/presentation/widgets/expert_bottom_book_button.dart';
import 'package:e_learning_app/src/features/expert_details/presentation/widgets/expert_details_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ExpertDetailsScreen extends StatelessWidget{
  const ExpertDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ExpertDetailsBottomBackButton(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExpertDetailsHeader(),
        ],
      ),
    );
  }
}