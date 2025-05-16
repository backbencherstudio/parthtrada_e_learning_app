import 'package:e_learning_app/core/constant/images.dart';
import 'package:e_learning_app/core/constant/padding.dart';
import 'package:e_learning_app/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserReviewList extends StatelessWidget{
  const UserReviewList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16.h,
      children: [
        Padding(
          padding: AppPadding.screenHorizontal,
          child: Text("What People Say",style: Theme.of(context).textTheme.titleLarge,),
        ),

        SizedBox(
          height: 176.h,
          child: ListView.builder(
              itemCount: 5,
              padding: AppPadding.screenHorizontal,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index){

                return FittedBox(
                  child: Container(
                    width: 274.w,
                    margin: EdgeInsets.only(right: 12.w),
                    padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 12.h),
                    decoration: Utils.commonBoxDecoration(),
                    child: Column(
                      children: [
                        /// Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          spacing : 12.w,
                          children: [
                            ClipOval(
                              child: Image.asset(AppImages.men,width: 48.w,height: 48.w,),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 4.h,
                              children: [
                                Text("John Smith"),
                                Text("CTO at Techcorp",style: Theme.of(context).textTheme.labelMedium,),
                              ],
                            )
                          ],
                        ),

                        SizedBox(height: 12.h,),

                        Text("\"The Al matching was spot-on! Found the perfect expert for our ML project in minutes.\"",
                        maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic
                          ),
                        ),

                        SizedBox(height: 12.h,),

                        Row(
                          children: List.generate(
                            5,
                                (index) => Icon(
                             Icons.star, // Use filled stars for the rating value
                              color: Colors.yellow,
                              size: 16.sp,
                            ),
                          )..add(SizedBox(width: 4.w))..add(Text("4.9")),
                        )
                      ],
                    ),
                  ),
                );
              }
          ),
        )
      ],
    );
  }
}