// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';

// import '../../../../../core/constant/icons.dart';
// import '../../../../../core/constant/padding.dart';
// import '../../../../../core/utils/utils.dart';
// import 'expert_search_bottom_sheet.dart';

// class ExpertSearchBar extends StatelessWidget{
//   const ExpertSearchBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: AppPadding.screenHorizontal,
//       child: SizedBox(
//         height: 48.h,
//         child: Row(
//           spacing: 8.w,
//           children: [
//             Expanded(
//               child: TextFormField(
//                 decoration: InputDecoration(
//                   hintText: "Type expert name",
//                   prefixIcon: Padding(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: 20.w,
//                       vertical: 14.h,
//                     ),
//                     child: SvgPicture.asset(
//                       AppIcons.search,
//                       colorFilter: ColorFilter.mode(
//                         Colors.white,
//                         BlendMode.srcIn,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),

//             GestureDetector(
//               onTap: ()=>expertSearchBottomSheet(context: context),
//               child: Container(
//                 padding: EdgeInsets.all(14.r),
//                 decoration: Utils.commonBoxDecoration(),
//                 child: SvgPicture.asset(AppIcons.filter),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:e_learning_app/core/constant/icons.dart';
import 'package:e_learning_app/core/constant/padding.dart';
import 'package:e_learning_app/core/utils/utils.dart';
import 'package:e_learning_app/src/features/onboarding/riverpod/login_state.dart';
import 'package:e_learning_app/src/features/search/presentation/widgets/expert_search_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ExpertSearchBar extends ConsumerStatefulWidget {
  final ValueChanged<String> onQueryChanged;

  const ExpertSearchBar({super.key, required this.onQueryChanged});

  @override
  ConsumerState<ExpertSearchBar> createState() => _ExpertSearchBarState();
}

class _ExpertSearchBarState extends ConsumerState<ExpertSearchBar> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusScope.of(context).unfocus(),

      child: Padding(
        padding: AppPadding.screenHorizontal,
        child: SizedBox(
          height: 48.h,
          child: Row(
            spacing: 8.w,
            children: [
              Expanded(
                child: TextFormField(
                  controller: _controller,
                  focusNode: _focusNode,
                  onChanged: widget.onQueryChanged,
                  decoration: InputDecoration(
                    hintText: "Type expert name",
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 14.h,
                      ),
                      child: SvgPicture.asset(
                        AppIcons.search,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              GestureDetector(
                onTap: () {
                  final authToken = ref.watch(authTokenProvider);
                  expertSearchBottomSheet(
                    context: context,
                    authToken: authToken,
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(14.r),
                  decoration: Utils.commonBoxDecoration(),
                  child: SvgPicture.asset(AppIcons.filter),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
