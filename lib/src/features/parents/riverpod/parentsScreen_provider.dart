import 'package:e_learning_app/src/features/message/presentation/message_screen/message_screen.dart';
import 'package:e_learning_app/src/features/parents/model/ParentScreenRiverPodModel.dart';
import 'package:e_learning_app/src/features/parents/presentation/dummy_screen/dummy_four.dart';
import 'package:e_learning_app/src/features/parents/presentation/dummy_screen/dummy_one.dart';
import 'package:e_learning_app/src/features/parents/presentation/dummy_screen/dummy_three.dart';
import 'package:e_learning_app/src/features/parents/presentation/dummy_screen/dummy_two.dart';
import 'package:e_learning_app/src/features/profile/presentation/user%20profile/view/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../search/presentation/serach_screen.dart';

class ParentsScreenProvider extends StateNotifier<ParentScreenRiverPodModel> {
  ParentsScreenProvider() : super(const ParentScreenRiverPodModel());

  final List<Widget> _pageList = [
    SearchScreen(),
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
    StateNotifierProvider<ParentsScreenProvider, ParentScreenRiverPodModel>((ref) {
  return ParentsScreenProvider();
});
