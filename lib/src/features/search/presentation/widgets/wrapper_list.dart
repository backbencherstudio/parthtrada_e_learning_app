import 'package:e_learning_app/src/features/search/presentation/widgets/wrap_item_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../provider/expert_provider.dart';
import '../../provider/selected_skill_provider.dart';

class WrapperList extends ConsumerWidget {
  final List<String> contentList;
  final int? minimumShow;
  final TextStyle? textStyle;
  const WrapperList({
    super.key,
    required this.contentList,
    this.minimumShow,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndexes = ref.watch(selectedSkillsProvider);
    final int? remainingLength =
        minimumShow != null ? contentList.length - minimumShow! : null;

    int listLength =
        remainingLength != null && remainingLength > 0
            ? (minimumShow! + 1)
            : contentList.length;

    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: List.generate(listLength, (index) {
        final isSelected = selectedIndexes.contains(contentList[index]);
        return GestureDetector(
          onTap: () {
            ref.read(selectedSkillsProvider.notifier).toggleSkill(contentList[index]);
            ref.read(expertPaginationProvider.notifier).fetchExperts(reset: true);
          },
          child: WrapItemContainer(
            text: contentList[index],
            isSelected: selectedIndexes.contains(contentList[index]),
            isRemainingItemShow: false,
            textStyle: textStyle,
          ),
        );
      }),
    );
  }
}
