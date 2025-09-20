import 'package:e_learning_app/src/features/profile/presentation/language/widgets/customCheckbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageContainer extends StatelessWidget {
  final text;
  final bool isChecked;
  final void Function()? onTap;
  LanguageContainer({
    super.key,
    required this.text,
    required this.isChecked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Color(0xff191919),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Text(
                text,

                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                  color: Color(0xffffffff),
                ),
              ),
              Spacer(),
              CustomCircleCheckbox(isChecked: isChecked, onTap: onTap),
            ],
          ),
        ),
      ),
    );
  }
}
