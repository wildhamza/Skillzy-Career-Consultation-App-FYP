import 'package:basics/constants/colors.dart';
import 'package:basics/constants/images.dart';
import 'package:basics/constants/text.dart';
import 'package:basics/constants/sizes.dart';
import 'package:basics/features/models/onboarding_model.dart';
import 'package:basics/features/screens/onboarding/onboarding_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final pages = [
      OnBoardingPageWidget(model: OnBoardingModel(
          image: onboarding1,
          title: onboardingScreenOneTitle,
          subtitle: onboardingScreenOneText,
          counter: onboardingScreenOneCounter,
          background: onboardingScreenOneColor,
          height: size.height
      )),
      OnBoardingPageWidget(model: OnBoardingModel(
          image: onboarding2,
          title: onboardingScreenTwoTitle,
          subtitle: onboardingScreenTwoText,
          counter: onboardingScreenTwoCounter,
          background: onboardingScreenTwoColor,
          height: size.height
      )),
      OnBoardingPageWidget(model: OnBoardingModel(
          image: onboarding3,
          title: onboardingScreenThreeTitle,
          subtitle: onboardingScreenThreeText,
          counter: onboardingScreenThreeCounter,
          background: onboardingScreenThreeColor,
          height: size.height
      ))
    ];

    return Scaffold(
      body: Stack(
        children: [
          LiquidSwipe(
              pages: pages,
            slideIconWidget: const Icon(Icons.arrow_back_ios),
            enableSideReveal: true,
            enableLoop: false,
          ),
        ],
      ),
    );
  }
}
