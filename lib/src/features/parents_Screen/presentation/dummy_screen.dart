import 'package:e_learning_app/src/features/parents_Screen/presentation/bottom_NavBar.dart';
import 'package:e_learning_app/src/features/parents_Screen/riverpod/bottomNavbar_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, _) {
          final currentIndex = ref.watch(bottomNavIndexProvider);
          return Center(child: Text("Page $currentIndex"));
        },
      ),
      bottomNavigationBar: Consumer(
        builder: (context, ref, _) {
          final currentIndex = ref.watch(bottomNavIndexProvider);
          return CustomBottomNavBar(
            currentIndex: currentIndex,
            onTap: (index) {
              ref.read(bottomNavIndexProvider.notifier).state = index;
            },
          );
        },
      ),
    );
  }
}
