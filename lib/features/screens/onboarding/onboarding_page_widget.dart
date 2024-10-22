import 'package:basics/constants/sizes.dart';
import 'package:basics/features/models/onboarding_model.dart';
import 'package:flutter/material.dart';

class OnBoardingPageWidget extends StatelessWidget {
  const OnBoardingPageWidget({
    super.key,
    required this.model,
  });

  final OnBoardingModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(pagePadding),
      color: model.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(image: AssetImage(model.image), height: model.height * 0.3,),
          Column(
            children: [
              Text(model.title, style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center,),
              const SizedBox(height: 10.0),
              Text(model.subtitle, textAlign: TextAlign.center,),
            ],
          ),
          Text(model.counter),
          const SizedBox(height: 50.0),
        ],
      ),
    );
  }
}