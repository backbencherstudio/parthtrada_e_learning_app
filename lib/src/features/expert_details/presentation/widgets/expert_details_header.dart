import 'package:e_learning_app/core/constant/icons.dart';
import 'package:e_learning_app/core/constant/padding.dart';
import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:e_learning_app/core/utils/common_widget.dart';
import 'package:e_learning_app/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/constant/images.dart';

class ExpertDetailsHeader extends StatelessWidget{
  const ExpertDetailsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: AppPadding.screenHorizontal,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Profile Picture and Back button
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      width: 24.w,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: ()=>context.pop(),
                        icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.sp),
                      ),
                    ),
                  ),
                ),

                ClipOval(
                  child: Image.asset(AppImages.women,width: 140.w,height: 140.h,fit: BoxFit.cover,),
                ),

                Expanded(
                  child: SizedBox(),
                ),
              ],
            ),
            SizedBox(height: 30.h,),

            /// Name and Rating
            Row(
             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text("Sarah Chen",style: textTheme.headlineSmall,)),
                Icon(Icons.star,color: AppColors.primary,size: 20.sp,),
                SizedBox(width: 4.w,),
                Text("4.8",style: textTheme.bodyLarge,),
              ],
            ),
            SizedBox(height: 4.h,),

            /// Designation
            Text("Senior Data Scientist at Google",style: textTheme.labelMedium,),
            SizedBox(height: 4.h,),

            /// Location
            Row(
              spacing: 6.w,
              children: [
                Icon(Icons.location_on_outlined,color: Colors.white,size: 20.sp,),
                Text("Olmstead Rd",style: textTheme.labelMedium,)
              ],
            ),
            SizedBox(height: 12.h,),

            /// Message button
            CommonWidget.primaryButton(context: context, onPressed: (){}, text: "Message")

          ],
        ),
      ),
    );
  }
}