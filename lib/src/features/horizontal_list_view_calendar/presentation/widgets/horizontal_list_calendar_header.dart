import 'package:e_learning_app/core/constant/icons.dart';
import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:e_learning_app/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../riverpod/horizontal_list_calendar_riverpod.dart';

class HorizontalListCalendarHeader extends ConsumerWidget{
  final EdgeInsets? headerPadding;
  final List<String> availableDays;
  const HorizontalListCalendarHeader({super.key, this.headerPadding, required this.availableDays});

  Widget _buildArrowButton({
    required VoidCallback onTap,
    required Color color, required IconData icon, required Color iconColor}){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(6.r),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Icon(icon,color: iconColor,size: 14.sp,),
      )
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final horizontalListCalendarState = ref.watch(horizontalListCalendarRiverpodProvider(availableDays));
    final horizontalListCalendarNotifier = ref.watch(horizontalListCalendarRiverpodProvider(availableDays).notifier);
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: headerPadding ?? EdgeInsets.zero,
      child: Row(
        children: [
          Text(Utils.formatDate(date: horizontalListCalendarState.currentDate!),
          style: textTheme.bodyMedium?.copyWith(color: AppColors.secondaryTextColor),
          ),

          Spacer(),

          _buildArrowButton(
              onTap: ()=>horizontalListCalendarNotifier.changeMonth(-1),
              color: Color(0xff2B2C31),
              icon: Icons.arrow_back_ios_rounded,
              iconColor: Color(0xffD2D2D5),
          ),
          SizedBox(width: 12.w,),

          _buildArrowButton(
              onTap: ()=>horizontalListCalendarNotifier.changeMonth(1),
              color: AppColors.primary,
              icon: Icons.arrow_forward_ios_outlined,
              iconColor: Colors.white,)
        ],
      ),
    );
  }
}