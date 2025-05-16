import 'package:e_learning_app/core/constant/icons.dart';
import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../user profile/widget/custom_button.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        title: Text(
          "Payment Method",
          style: Theme.of(
            context,
          ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.only(left: 24.w),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset(AppIcons.backlongArrow),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              thickness: 1,
              color: Color(0xff2B2C31),
              indent: 6.w,
              endIndent: 6.w,
            ),
            SizedBox(height: 24.h),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Card Number',
                    style: textTheme.labelLarge!.copyWith(
                      fontSize: 14.sp,
                      color: Color(0xffffffff),
                    ),
                  ),
                  TextSpan(
                    text: '*',
                    style: textTheme.labelLarge!.copyWith(
                      fontSize: 14.sp,
                      color: Color(0xffFF4747),
                    ),
                  ),
                ],
              ),
            ),
           SizedBox(height: 8.h,),
            TextFormField( decoration: InputDecoration(hintText: "________", suffixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(AppIcons.scanner),
            )),),
            SizedBox(height:14.h),
          //given name

              RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Given Name',
                    style: textTheme.labelLarge!.copyWith(
                      fontSize: 14.sp,
                      color: Color(0xffffffff),
                    ),
                  ),
                  TextSpan(
                    text: '*',
                    style: textTheme.labelLarge!.copyWith(
                      fontSize: 14.sp,
                      color: Color(0xffFF4747),
                    ),
                  ),
                ],
              ),
            ),
           SizedBox(height: 8.h,),
            TextFormField( decoration: InputDecoration(hintText: "Jenny Wilson", )
             ),
               SizedBox(height:14.h),
          //Surname 

              RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Surname',
                    style: textTheme.labelLarge!.copyWith(
                      fontSize: 14.sp,
                      color: Color(0xffffffff),
                    ),
                  ),
                  TextSpan(
                    text: '*',
                    style: textTheme.labelLarge!.copyWith(
                      fontSize: 14.sp,
                      color: Color(0xffFF4747),
                    ),
                  ),
                ],
              ),
            ),
           SizedBox(height: 8.h,),
           TextFormField( decoration: InputDecoration(hintText: "wilson@09gail.com", )
             ),
              //Expire in  
               SizedBox(height:14.h),

              RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Expire in',
                    style: textTheme.labelLarge!.copyWith(
                      fontSize: 14.sp,
                      color: Color(0xffffffff),
                    ),
                  ),
                  TextSpan(
                    text: '*',
                    style: textTheme.labelLarge!.copyWith(
                      fontSize: 14.sp,
                      color: Color(0xffFF4747),
                    ),
                  ),
                ],
              ),
            ),
           SizedBox(height: 8.h,),
           TextFormField( decoration: InputDecoration(hintText: "MM/YY", )
             ),

             //CVV/CSC *
                            SizedBox(height:14.h),

              RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'CVV/CSC',
                    style: textTheme.labelLarge!.copyWith(
                      fontSize: 14.sp,
                      color: Color(0xffffffff),
                    ),
                  ),
                  TextSpan(
                    text: '*',
                    style: textTheme.labelLarge!.copyWith(
                      fontSize: 14.sp,
                      color: Color(0xffFF4747),
                    ),
                  ),
                ],
              ),
            ),
           SizedBox(height: 8.h,),
           TextFormField( decoration: InputDecoration(hintText: "________", ),

           
             ),

             SizedBox(height: 50.h,),

             Mybutton(color: AppColors.primary, text: "Save", onTap: (){}, width: 327.w,)
          ],
        ),
      ),
    );
  }
}
