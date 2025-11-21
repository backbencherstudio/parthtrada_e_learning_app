import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../rvierpod/session_provider.dart';

class SessionGridView extends ConsumerWidget {
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

  String convertTo24HourFormat(String time12h) {
    try {
      final cleaned = time12h.replaceAll(RegExp(r'\s+'), '').trim();
      if (cleaned.isEmpty) return '';

      final inputFormat = DateFormat("hh:mma");
      final outputFormat = DateFormat('HH:mm');
      final dateTime = inputFormat.parse(cleaned);
      return outputFormat.format(dateTime);
    } catch (e) {
      debugPrint('Error parsing time "$time12h": $e');
      return time12h;
    }
  }
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 12.h,
      children: [
        Text(heading, style: textTheme.headlineSmall),

        sessions.isEmpty
            ? Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Center(
                child: Text('No available sessions found for this Slot'),
              ),
            )
            : GridView.builder(
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
                    // debugPrint("\nIs morning shift : $isMorningShift\n");
                    stateNotifier.onSelectSessionTime(
                      index: index,
                      isMorningShift: isMorningShift,
                    );
                    final sessionDataNotifier = ref.read(
                      sessionDataProvider.notifier,
                    );

                    final convertedTime = convertTo24HourFormat(session);
                    sessionDataNotifier.setTime(convertedTime);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32.r),
                      color:
                          state.selectedSessionTime != null &&
                                  state.isMorningShift == isMorningShift &&
                                  state.selectedSessionTime == index
                              ? AppColors.primary
                              : AppColors.secondary,
                    ),
                    child: FittedBox(
                      child: Text(
                        session,
                        style: textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                        ),
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
