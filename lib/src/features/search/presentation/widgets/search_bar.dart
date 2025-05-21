import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constant/icons.dart';
import '../../../../../core/constant/padding.dart';
import '../../../../../core/utils/utils.dart';
import 'expert_search_bottom_sheet.dart';

class ExpertSearchBar extends StatefulWidget{
  const ExpertSearchBar({super.key});

  @override
  State<ExpertSearchBar> createState() => _ExpertSearchBarState();
}

class _ExpertSearchBarState extends State<ExpertSearchBar> {

  late final FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.screenHorizontal,
      child: SizedBox(
        height: 48.h,
        child: Row(
          spacing: 8.w,
          children: [
            Expanded(
              child: TextFormField(
                focusNode: _focusNode,
                onTapOutside: (_){
                  _focusNode.unfocus();
                },
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