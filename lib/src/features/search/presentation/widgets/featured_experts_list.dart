import 'package:e_learning_app/core/constant/icons.dart';
import 'package:e_learning_app/core/constant/images.dart';
import 'package:e_learning_app/core/constant/padding.dart';
import 'package:e_learning_app/core/routes/route_name.dart';
import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:e_learning_app/core/utils/common_widget.dart';
import 'package:e_learning_app/core/utils/utils.dart';
import 'package:e_learning_app/src/features/search/presentation/widgets/wrap_item_container.dart';
import 'package:e_learning_app/src/features/search/presentation/widgets/wrapper_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class FeaturedExpertsList extends StatelessWidget{
  const FeaturedExpertsList({super.key});

  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:  AppPadding.screenHorizontal,
          child: Text("Featured Experts",style: Theme.of(context).textTheme.titleLarge,),
        ),
        SizedBox(height: 16.h,),

        SizedBox(
          height: 308.h,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              padding: EdgeInsets.symmetric(horizontal: 24.w),

              itemBuilder: (_, index){
                return FittedBox(
                  child: GestureDetector(
                    onTap: ()=> context.push(RouteName.expertDetailsScreen),
                    child: Container(
                      width: 274.w,
                    margin: EdgeInsets.only(right: 12.w),
                    padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 16.h),
                    decoration: Utils.commonBoxDecoration(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipOval(
                            child: Image.asset(AppImages.women,width: 56.w,height: 56.w,),
                          ),
                          SizedBox(height: 16.h,),
                          Text("Sarah Chen",style: textTheme.titleLarge,maxLines: 1,overflow: TextOverflow.ellipsis,),
                          SizedBox(height: 4.h,),
                          Text("Senior Data Scientist at Google",
                            style: textTheme.bodyMedium?.copyWith(color: AppColors.secondaryTextColor)
                            ,maxLines: 1,overflow: TextOverflow.ellipsis,),

                          SizedBox(height: 7.h,),

                          Row(
                            spacing: 4.w,
                            children: [
                              Icon(Icons.star,color: AppColors.primary,size: 20.sp,),
                              Text("4.9"),
                              SizedBox(width: 4.w,),
                              Text("(127 reviews)",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.secondaryTextColor
                              ),),
                            ],
                          ),

                          SizedBox(height: 7.h,),

                          Row(
                            spacing : 8.w,
                            children: [
                              Expanded(child: WrapItemContainer(text: "Machine Learning",)),
                              Expanded(child: WrapItemContainer(text: "Data Science",)),
                              WrapItemContainer(text: "+1",isRemainingItemShow: true,),
                            ],
                          ),

                          SizedBox(height: 7.h,),

                          Row(
                            spacing: 8.w,
                            children: [
                              SvgPicture.asset(AppIcons.calendar,width: 20.w,height: 20.h,),
                              Text("Next available: Mon 2pm...",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.secondaryTextColor
                              ),)
                            ],
                          ),
                          SizedBox(height: 12.h,),

                          SizedBox(
                            width : double.infinity,
                            child: CommonWidget.primaryButton(
                              context: context,
                              onPressed: (){},
                              text: "Book \$150/hour"
                            ),
                          )


                        ],
                      ),
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