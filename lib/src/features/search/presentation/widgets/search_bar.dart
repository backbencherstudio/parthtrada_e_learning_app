import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constant/icons.dart';
import '../../../../../core/constant/padding.dart';
import '../../../../../core/utils/utils.dart';
import 'expert_search_bottom_sheet.dart';

class ExpertSearchBar extends ConsumerWidget{
  const ExpertSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: AppPadding.screenHorizontal,
      child: SizedBox(
        height: 48.h,
        child: Row(
          spacing: 8.w,
          children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Type expert name",
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 14.h,
                    ),
                    child: SvgPicture.asset(
                      AppIcons.search,
                      colorFilter: ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            GestureDetector(
              onTap: ()=>expertSearchBottomSheet(context: context),
              child: Container(
                padding: EdgeInsets.all(14.r),
                decoration: Utils.commonBoxDecoration(),
                child: SvgPicture.asset(AppIcons.filter),
              ),
            )
          ],
        ),
      ),
    );
  }
}