import 'package:e_learning_app/src/features/onboarding/presentation/widgets/onboarding_tab_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/images.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: [
          OnboardingPageWidget(
            heading: "Talk to Real Experts",
            bodyText:
                "Get career advice from verified professionals -one-on-one.",
            imagePath: AppImages.onboardingImageOne,
            tabController: _tabController,
             buttonText: "Next",
          ),

          OnboardingPageWidget(
            heading: "Personalized Career Help",
            bodyText:
                "Ask questions, get guidance, and grow with expert support.",
            imagePath: AppImages.onboardingImageTwo,
            tabController: _tabController,
            buttonText: "Next",
          ),

          OnboardingPageWidget(
            heading: "Achieve More, Faster",
            bodyText:
                "Book sessions, learn new skills, and reach your goals.",
            imagePath: AppImages.onboardingImageThree,
            tabController: _tabController,
            buttonText: "Get Started",
          ),
        ],
      ),
    );
  }
}
