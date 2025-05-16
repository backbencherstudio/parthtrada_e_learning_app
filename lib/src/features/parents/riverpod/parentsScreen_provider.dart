import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../message/presentation/message_screen/message_screen.dart';
import '../../profile/sub_feature/profile_screen.dart';
import '../model/ParentScreenRiverPodModel.dart';
import '../presentation/dummy_screen/dummy_one.dart';
import '../presentation/dummy_screen/dummy_two.dart';

class ParentsScreenProvider extends StateNotifier<ParentScreenRiverPodModel> {
  ParentsScreenProvider() : super(const ParentScreenRiverPodModel());

  final List<Widget> _pageList = [
    DummyOne(),
    DummyTwo(),
    MessageScreen(),
    ProfileScreen(),
  ];

  List<Widget> get pageList => _pageList;

  void onSelectedIndex(int index) {
    debugPrint("Selected Page index : $index");
    state = state.copyWith(selectedIndex: index);
  }
}

final parentsScreenProvider =
    StateNotifierProvider<ParentsScreenProvider, ParentScreenRiverPodModel>((
      ref,
    ) {
      return ParentsScreenProvider();
    });
