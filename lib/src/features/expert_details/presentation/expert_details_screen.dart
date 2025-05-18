import 'package:e_learning_app/core/constant/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ExpertDetailsScreen extends StatelessWidget{
  const ExpertDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: 24.w,
                      child: IconButton(
                        onPressed: ()=>context.pop(),
                        icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.sp),
                      ),
                    ),
                  ),
                  
                  ClipOval(
                    child: Image.asset(AppImages.women,width: 140.w,height: 140.h,fit: BoxFit.cover,),
                  ),
                  
                  Expanded(
                    child: SizedBox(),
                  )
                ],
              )
            ],
          )
      ),
    );
  }
}