
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'qna.dart';

class QNASection extends StatelessWidget {
  const QNASection({
    super.key,
    required this.textStyle,
  });

  final TextTheme textStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 24.h,
      children: [
        QNA(
          textStyle: textStyle,
          question: 'What Specific topic would you like to discuss?',
          answer:
          'Implementing machine learning models in production',
        ),
        QNA(
          textStyle: textStyle,
          question: 'What Specific topic would you like to discuss?',
          answer:
          'Implementing machine learning models in production',
        ),
        QNA(
          textStyle: textStyle,
          question: 'What Specific topic would you like to discuss?',
          answer:
          'Implementing machine learning models in production',
        ),
        QNA(
          textStyle: textStyle,
          question: 'What Specific topic would you like to discuss?',
          answer:
          'Implementing machine learning models in production',
        ),
        QNA(
          textStyle: textStyle,
          question: 'What Specific topic would you like to discuss?',
          answer:
          'Implementing machine learning models in production',
        ),
      ],
    );
  }
}