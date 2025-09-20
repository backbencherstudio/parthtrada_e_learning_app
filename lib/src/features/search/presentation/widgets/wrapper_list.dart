import 'package:e_learning_app/src/features/search/presentation/widgets/wrap_item_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WrapperList extends StatelessWidget {
  final List<String> contentList;
  final int? minimumShow;
  final TextStyle? textStyle;
  final Function(String) onSkillSelected;
  const WrapperList({
    super.key,
    required this.contentList,
    required this.onSkillSelected,
    this.minimumShow,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final int? remainingLength =
        minimumShow != null ? contentList.length - minimumShow! : null;

    int listLength =
        remainingLength != null && remainingLength > 0
            ? (minimumShow! + 1)
            : contentList.length;
    debugPrint(
      "\nOriginal length : ${contentList.length}\nList length : $listLength\nremaining length : $remainingLength\n",
    );

    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: List.generate(
        listLength,
        (index) => GestureDetector(
          onTap: () {
            onSkillSelected(contentList[index]);
            debugPrint("\nTaped index : $index\n");
          },
          child: WrapItemContainer(
            textStyle: textStyle,
            text: contentList[index],
          ),
        ),
      ),
    );
  }
}
