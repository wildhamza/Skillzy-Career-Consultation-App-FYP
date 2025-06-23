import 'package:basics/utils/getQuestions.dart';
import 'package:basics/utils/getSkillLabel.dart';
import 'package:basics/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  int currentQuestionIndex = 0;
  List<String?> selectedOptions = List.filled(getQuestions().length, null);

  void nextQuestion(int idx) async {
    if (selectedOptions[idx] != null) {
      if (currentQuestionIndex < getQuestions().length - 1) {
        setState(() {
          currentQuestionIndex++;
        });
      } else {
        Get.offNamed('/result', arguments: {
          'options': selectedOptions,
        });
      }
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = getQuestions()[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          question['category'],
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Text(
                question['question'],
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ...List.generate(
                question['options'].length,
                    (index) {
                  final option = question['options'][index];
                  return RadioListTile<String>(
                    value: option,
                    groupValue: selectedOptions[question['idx'] - 1],
                    onChanged: (value) {
                      setState(() {
                        selectedOptions[question['idx'] - 1] = value;
                      });
                    },
                    title: Text(
                      getSkillLabel(option, currentQuestionIndex),
                      style: const TextStyle(fontSize: 16),
                    ),
                    activeColor: AppTheme.secondaryColor,
                  );
                },
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: previousQuestion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: currentQuestionIndex > 0
                          ? AppTheme.primaryColor[700]
                          : AppTheme.blackPalette[200],
                    ),
                    child: const Text(
                      "Previous",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Text("${currentQuestionIndex + 1}/${getQuestions().length}"),
                  ElevatedButton(
                    onPressed: () {
                      nextQuestion(question['idx'] - 1);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedOptions[question['idx'] - 1] != null
                          ? AppTheme.secondaryColor[800]
                          : AppTheme.blackPalette[200],
                    ),
                    child: Text(
                      currentQuestionIndex < getQuestions().length - 1 ? "Next" : "Submit",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
