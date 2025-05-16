import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Mybutton extends StatelessWidget {
  final String text;
  final Color color;
  final double? width;
  final void Function()? onTap;
  const Mybutton({super.key,
  required this.color,
  required this.text,
  required this.onTap,
  this.width,

  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height:56.h,
        width: width ?? 158.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: color
        ),
        child: Center(
          child: Text(text,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: Color(0xffffffff),
            fontWeight: FontWeight.w700,
          ),
          ),
        ),
      ),
    );
  }
}