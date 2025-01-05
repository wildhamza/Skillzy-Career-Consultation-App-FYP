import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:basics/utils/theme.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  // Initializing with null values to show loading indicator first
  List<String> recommendedSkills = [];
  List<String> recommendedCareers = [];

  @override
  void initState() {
    super.initState();
    // Simulate a 5-second delay to show the generated skills and careers
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        recommendedSkills = ['Communication', 'Problem Solving', 'Leadership'];
        recommendedCareers = ['Marketing Manager', 'Project Manager', 'HR Specialist'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Assessment Result",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 120),
              // Display the loading message or the results based on the state
              if (recommendedSkills.isEmpty && recommendedCareers.isEmpty)
                Column(
                  children: [
                    Center(
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor,
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: LoadingAnimationWidget.waveDots(color: Colors.white, size: 120),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Text(
                      "Generating skills and \n career for you",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(height: 1.5, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    )
                  ],
                )
              else
                Column(
                  children: [
                    Text(
                      "Recommended Skills",
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    for (var skill in recommendedSkills)
                      Text(
                        skill,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18, height: 1.7),
                      ),
                    const SizedBox(height: 60),
                    Text(
                      "Recommended Careers Paths",
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    for (var career in recommendedCareers)
                      Text(
                        career,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18, height: 1.7),
                      ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed('/home');
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryColor[500],
                          foregroundColor: Colors.white
                      ),
                      child: Text('Continue'.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
