import 'package:e_learning_app/src/features/parents/presentation/Navbar/bottom_NavBar.dart';
import 'package:e_learning_app/src/features/parents/riverpod/parentsScreen_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ParentScreen extends StatelessWidget {
  const ParentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, _) {
          final index = ref.watch(parentsScreenProvider).selectedIndex;
          final pages = ref.read(parentsScreenProvider.notifier).pageList;
          return pages[index];
        },
      ),
      bottomNavigationBar: Consumer(
        builder: (context, ref, _) {
          final currentIndex = ref.watch(parentsScreenProvider).selectedIndex;
          final provider = ref.read(parentsScreenProvider.notifier);

          return CustomBottomNavBar(
            currentIndex: currentIndex,
            onTap: provider.onSelectedIndex,
          );
        },
      ),
    );
  }
}
