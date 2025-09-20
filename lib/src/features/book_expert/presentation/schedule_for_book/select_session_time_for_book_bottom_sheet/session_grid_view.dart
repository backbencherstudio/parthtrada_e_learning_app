import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SessionGridView extends StatelessWidget {
  final String heading;
  final List<String> sessions;
  final bool isMorningShift;
  final stateNotifier;
  final state;
  const SessionGridView({
    super.key,
    required this.heading,
    required this.sessions,
    required this.isMorningShift,
    required this.state,
    required this.stateNotifier,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 12.h,
      children: [
        Text(heading, style: textTheme.headlineSmall),

        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: sessions.length,
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 8.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 2,
          ),
          itemBuilder: (_, index) {
            final session = sessions[index];
            return GestureDetector(
              onTap: () {
                debugPrint("\nIs morning shift : $isMorningShift\n");
                stateNotifier.onSelectSessionTime(
                  index: index,
                  isMorningShift: isMorningShift,
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32.r),
                  color:
                      state.isMorningShift == isMorningShift &&
                              state.selectedSessionTime == index
                          ? AppColors.primary
                          : AppColors.secondary,
                ),
                child: FittedBox(
                  child: Text(
                    session,
                    style: textTheme.bodySmall?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
