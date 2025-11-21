import 'package:e_learning_app/src/features/search/provider/expert_search_query_provider.dart';
import 'package:e_learning_app/src/features/search/provider/expert_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/constant/icons.dart';
import '../../../../../core/constant/padding.dart';
import '../../../../../core/utils/utils.dart';
import 'expert_search_bottom_sheet.dart';

class ExpertSearchBar extends ConsumerWidget {
  const ExpertSearchBar({super.key, required this.readOnly, this.onTap});

  final bool readOnly;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: AppPadding.screenHorizontal,
      child: SizedBox(
        height: 48.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextFormField(
                readOnly: readOnly,
                onTap: onTap,
                onChanged: (value) {
                  ref.read(expertSearchQueryProvider.notifier).state = value;
                },
                onFieldSubmitted: (value) async {
                  ref.read(expertSearchQueryProvider.notifier).state = value;
                  await ref.read(expertPaginationProvider.notifier).fetchExperts(reset: true);
                },
                decoration: InputDecoration(
                  hintText: "Type expert name or skill",
                  prefixIcon: Padding(
                    padding: EdgeInsets.fromLTRB(
                      20.w, 14.h, 14.w, 14.h
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
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: () => expertSearchBottomSheet(context: context),
              child: Container(
                padding: EdgeInsets.all(14.r),
                decoration: Utils.commonBoxDecoration(),
                child: SvgPicture.asset(AppIcons.filter),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
