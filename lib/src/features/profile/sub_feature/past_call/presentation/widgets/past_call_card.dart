import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../data/models/past_call_response_model.dart';

class PastCallCard extends StatelessWidget {
  const PastCallCard({super.key, required this.pastCall});

  final PastCall pastCall;

  void _showSummaryDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return Center(
          child: Container(
            width: 300.w,
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: AppColors.screenBackgroundColor,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Meeting Summary',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.onPrimary,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: AppColors.primary),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    constraints: BoxConstraints(maxHeight: 300.h),
                    child: SingleChildScrollView(
                      child: Text(
                        pastCall.meetingSummery ?? 'No summary available',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.onPrimary,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        textStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      child: const Text('Close'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          ),
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            ),
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pastCall.name,
                  style: textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  '${pastCall.duration} Min',
                  style: textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  DateFormat('dd/MM/yyyy, hh:mm a').format(pastCall.date),
                  style: textTheme.labelSmall!.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                if (pastCall.meetingSummery != null) ...[
                  SizedBox(height: 8.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _showSummaryDialog(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        textStyle: textTheme.labelMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      child: const Text('View Summary'),
                    ),
                  ),
                ],
              ],
            ),
          ),
          Text(
            '- \$${pastCall.amount.toStringAsFixed(2)}',
            style: textTheme.labelMedium!.copyWith(
              color: AppColors.error,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}






// import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl/intl.dart';
//
// import '../../../../data/models/past_call_response_model.dart';
//
// class PastCallCard extends StatelessWidget {
//   const PastCallCard({super.key, required this.pastCall});
//
//   final PastCall pastCall;
//
//   void _showSummaryDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Meeting Summary'),
//           content: SingleChildScrollView(
//             child: Text(
//               pastCall.meetingSummery ?? 'No summary available',
//               style: Theme.of(context).textTheme.bodyMedium,
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text('Close'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     TextTheme textTheme = Theme.of(context).textTheme;
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
//       margin: EdgeInsets.only(bottom: 12.h),
//       decoration: BoxDecoration(
//         color: AppColors.secondary,
//         borderRadius: BorderRadius.circular(12.r),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   pastCall.name,
//                   style: textTheme.titleMedium!.copyWith(
//                     fontWeight: FontWeight.w800,
//                   ),
//                 ),
//                 SizedBox(height: 2.h),
//                 Text(
//                   '${pastCall.duration} Min',
//                   style: textTheme.bodyMedium!.copyWith(
//                     fontWeight: FontWeight.normal,
//                   ),
//                 ),
//                 SizedBox(height: 2.h),
//                 Text(
//                   DateFormat('dd/MM/yyyy, hh:mm a').format(pastCall.date),
//                   style: textTheme.labelSmall!.copyWith(
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//                 if (pastCall.meetingSummery != null) ...[
//                   SizedBox(height: 8.h),
//                   ElevatedButton(
//                     onPressed: () => _showSummaryDialog(context),
//                     style: ElevatedButton.styleFrom(
//                       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//                       textStyle: textTheme.labelMedium,
//                     ),
//                     child: const Text('View Summary'),
//                   ),
//                 ],
//               ],
//             ),
//           ),
//           Text(
//             '- \$${pastCall.amount.toStringAsFixed(2)}',
//             style: textTheme.labelMedium!.copyWith(
//               color: AppColors.error,
//               fontWeight: FontWeight.w800,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }