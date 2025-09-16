import 'package:e_learning_app/repository/linkedin_login_webview.dart';
import 'package:e_learning_app/src/features/expert_details/presentation/widgets/expert_bottom_book_button.dart';
import 'package:e_learning_app/src/features/expert_details/presentation/widgets/expert_details_body.dart';
import 'package:e_learning_app/src/features/expert_details/presentation/widgets/expert_details_header.dart';
import 'package:e_learning_app/src/features/expert_details/riverpod/expert_details_provider_with_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpertDetailsScreen extends ConsumerStatefulWidget {
  final String id;
  const ExpertDetailsScreen({super.key, required this.id});

  @override
  ConsumerState<ExpertDetailsScreen> createState() =>
      _ExpertDetailsScreenState();
}

class _ExpertDetailsScreenState extends ConsumerState<ExpertDetailsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final expertId = widget.id;
      ref
          .read(expertDetailsProvider.notifier)
          .fetchExpertDetails('$baseUrl/experts/$expertId');
    });
  }

  @override
  Widget build(BuildContext context) {
    final userDetails = ref.watch(expertDetailsProvider);
    final data = userDetails.data;

    return Scaffold(
      bottomNavigationBar: ExpertDetailsBottomBookButton(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpertDetailsHeader(data: data),
            SizedBox(height: 24.h),
            ExpertDetailsBody(data: data, id: widget.id),
          ],
        ),
      ),
    );
  }
}
