import 'package:basics/constants/colors.dart';
import 'package:basics/constants/images.dart';
import 'package:basics/constants/text.dart';
import 'package:basics/features/models/onboarding_model.dart';
import 'package:basics/features/screens/onboarding/onboarding_page_widget.dart';
import 'package:basics/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final LiquidController _controller = LiquidController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final pages = [
      OnBoardingPageWidget(
        model: OnBoardingModel(
          image: onboarding1,
          title: onboardingScreenOneTitle,
          subtitle: onboardingScreenOneText,
          counter: onboardingScreenOneCounter,
          background: onboardingScreenOneColor,
          background_dark: onboardingScreenOneColorDark,
          height: size.height,
        ),
      ),
      OnBoardingPageWidget(
        model: OnBoardingModel(
          image: onboarding2,
          title: onboardingScreenTwoTitle,
          subtitle: onboardingScreenTwoText,
          counter: onboardingScreenTwoCounter,
          background: onboardingScreenTwoColor,
          background_dark: onboardingScreenTwoColorDark,
          height: size.height,
        ),
      ),
      OnBoardingPageWidget(
        model: OnBoardingModel(
          image: onboarding3,
          title: onboardingScreenThreeTitle,
          subtitle: onboardingScreenThreeText,
          counter: onboardingScreenThreeCounter,
          background: onboardingScreenThreeColor,
          background_dark: onboardingScreenThreeColorDark,
          height: size.height,
        ),
      ),
    ];

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          LiquidSwipe(
            pages: pages,
            liquidController: _controller,
            slideIconWidget: _currentPage == 2 ? null : const Icon(Icons.arrow_back_ios),
            enableSideReveal: true,
            onPageChangeCallback: (int activePageIndex) {
              setState(() {
                _currentPage = activePageIndex;
              });
            },
            enableLoop: false,
          ),
          Positioned(
            bottom: 110,
            child: OutlinedButton(
              onPressed: () {
                if (_currentPage < 2) {
                  _controller.jumpToPage(page: _currentPage + 1);
                } else {
                  // Navigate to Login with slide animation
                  Get.offNamed('/login');
                }
              },
              style: ElevatedButton.styleFrom(
                side: const BorderSide(color: Colors.black26),
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(20),
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: AppTheme.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_forward_ios, color: Colors.white),
              ),
            ),
          ),
          Positioned(
            top: 50,
            right: 20,
            child: TextButton(
              onPressed: () {
                _controller.jumpToPage(page: 2); // Skip to the last slide
              },
              child: const Text(
                "Skip",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
