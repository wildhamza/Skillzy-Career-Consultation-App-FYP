import 'package:basics/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:basics/constants/text.dart';
import 'package:get/get.dart';

class AssessmentScreen extends StatelessWidget {
  const AssessmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Assessment", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600)),
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 150),
                  Center(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: AppTheme.primaryColor,
                              borderRadius: BorderRadius.circular(100.0)
                          ),
                          child: SizedBox(
                            width: 120,
                            height: 120,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: SvgPicture.asset(
                                'assets/svg/checklist.svg',
                                height: 20,
                                width: 20,
                                fit: BoxFit.contain,
                                // colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 60),
                        Text(assessmentText, style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            Get.toNamed('/questions');
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryColor[500],
                              foregroundColor: Colors.white
                          ),
                          child: Text('Start Assessment'.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}