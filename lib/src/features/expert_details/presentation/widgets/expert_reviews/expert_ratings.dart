import 'package:e_learning_app/core/constant/icons.dart';
import 'package:e_learning_app/core/constant/images.dart';
import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExpertRatings extends StatelessWidget{
  const ExpertRatings({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Reviews",style: textTheme.headlineSmall,),
        SizedBox(height: 10.h,),
        Image.asset(AppImages.women,width : 32.w,height: 32.w,fit: BoxFit.cover,),
        SizedBox(height: 30.h,),

        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("4.8",style: textTheme.bodyMedium?.copyWith(fontSize: 56.sp),),
                Row(children: List.generate(5, (index)=> SvgPicture.asset(AppIcons.starFill,
                  colorFilter: ColorFilter.mode(Color(0xffF6A14B), BlendMode.srcIn,),),),),
                Text("487 Reviews",style: textTheme.labelMedium,)
              ],
            ),
            SizedBox(width: 25.w,),
            Expanded(
              child: Column(
                spacing: 4.h,
                children: List.generate(5, (index)=>Row(
                  children: [
                    Text((5-index).toString(),style: textTheme.labelMedium,),
                    SizedBox(width: 18.w,),
                    Expanded(
                        child: LinearProgressIndicator(
                          borderRadius: BorderRadius.circular(20.r),
                          minHeight: 8.h,
                          value: 0.8,
                          color: AppColors.primary,
                          backgroundColor: Colors.white,
                        )
                    )
                  ],
                )),
              ),
            )
          ],
        )
      ],
    );
  }
}