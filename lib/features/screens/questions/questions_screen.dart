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

  final List<Map<String, dynamic>> questions = [
    // Technical Skills
    {
      'category': 'Technical Skills',
      'question': 'How proficient are you in programming?',
      'options': ['1', '2', '3', '4', '5', '6', '7'],
    },
    {
      'category': 'Technical Skills',
      'question': 'How skilled are you in database fundamentals?',
      'options': ['1', '2', '3', '4', '5', '6', '7'],
    },
    {
      'category': 'Technical Skills',
      'question': 'Rate your knowledge of computer architecture.',
      'options': ['1', '2', '3', '4', '5', '6', '7'],
    },
    {
      'category': 'Technical Skills',
      'question': 'How experienced are you with distributed computing systems?',
      'options': ['1', '2', '3', '4', '5', '6', '7'],
    },
    {
      'category': 'Technical Skills',
      'question': 'Do you have experience in cybersecurity? If yes, how proficient are you?',
      'options': ['1', '2', '3', '4', '5', '6', '7'],
    },
    {
      'category': 'Technical Skills',
      'question': 'How would you rate your networking skills?',
      'options': ['1', '2', '3', '4', '5', '6', '7'],
    },
    {
      'category': 'Technical Skills',
      'question': 'How proficient are you in software development?',
      'options': ['1', '2', '3', '4', '5', '6', '7'],
    },
    {
      'category': 'Technical Skills',
      'question': 'How would you rate your knowledge of artificial intelligence and machine learning?',
      'options': ['1', '2', '3', '4', '5', '6', '7'],
    },
    {
      'category': 'Technical Skills',
      'question': 'Do you have experience with computer forensics fundamentals?',
      'options': ['1', '2', '3', '4', '5', '6', '7'],
    },
    {
      'category': 'Technical Skills',
      'question': 'Rate your understanding of software engineering concepts.',
      'options': ['1', '2', '3', '4', '5', '6', '7'],
    },
    {
      'category': 'Technical Skills',
      'question': 'How proficient are you in data science?',
      'options': ['1', '2', '3', '4', '5', '6', '7'],
    },

    // Soft Skills
    {
      'category': 'Soft Skills',
      'question': 'How would you rate your communication skills?',
      'options': ['1', '2', '3', '4', '5', '6', '7'],
    },
    {
      'category': 'Soft Skills',
      'question': 'How proficient are you in project management?',
      'options': ['1', '2', '3', '4', '5', '6', '7'],
    },
    {
      'category': 'Soft Skills',
      'question': 'How strong are your troubleshooting skills?',
      'options': ['1', '2', '3', '4', '5', '6', '7'],
    },
    {
      'category': 'Soft Skills',
      'question': 'Do you have experience in business analysis? If yes, how would you rate your proficiency?',
      'options': ['1', '2', '3', '4', '5', '6', '7'],
    },
    {
      'category': 'Soft Skills',
      'question': 'How skilled are you in graphic designing?',
      'options': ['1', '2', '3', '4', '5', '6', '7'],
    },
    {
      'category': 'Soft Skills',
      'question': 'How good are you at technical communication?',
      'options': ['1', '2', '3', '4', '5', '6', '7'],
    },

    // Psychological Traits
    {
      'category': 'Psychological Traits',
      'question': 'How open are you to trying new things?',
      'options': ['1', '2', '3', '4', '5', '6', '7'],
    },
    {
      'category': 'Psychological Traits',
      'question': 'How organized and detail-oriented are you?',
      'options': ['1', '2', '3', '4', '5', '6', '7'],
    },
    {
      'category': 'Psychological Traits',
      'question': 'Do you enjoy working in a team, or do you prefer working alone?',
      'options': ['1', '2', '3', '4', '5', '6', '7'],
    },
    {
      'category': 'Psychological Traits',
      'question': 'How empathetic and cooperative are you with others?',
      'options': ['1', '2', '3', '4', '5', '6', '7'],
    },
    {
      'category': 'Psychological Traits',
      'question': 'How well do you handle stress in challenging situations?',
      'options': ['1', '2', '3', '4', '5', '6', '7'],
    },

    // Values & Preferences
    {
      'category': 'Values & Preferences',
      'question': 'How comfortable are you with having conversations and discussions in professional settings?',
      'options': ['1', '2', '3', '4', '5', '6', '7'],
    },
    {
      'category': 'Values & Preferences',
      'question': 'Are you open to changes in your routine or environment?',
      'options': ['1', '2', '3', '4', '5', '6', '7'],
    },
    {
      'category': 'Values & Preferences',
      'question': 'Do you prioritize enjoying life and having fun over work responsibilities?',
      'options': ['1', '2', '3', '4', '5', '6', '7'],
    },
    {
      'category': 'Values & Preferences',
      'question': 'How much do you value personal achievement and success in your career?',
      'options': ['1', '2', '3', '4', '5', '6', '7'],
    },
    {
      'category': 'Values & Preferences',
      'question': 'How much do you value contributing to the well-being of others?',
      'options': ['1', '2', '3', '4', '5', '6', '7'],
    },
  ];

  String? selectedOption;

  void nextQuestion() {
    if (selectedOption != null) {
      if (currentQuestionIndex < questions.length - 1) {
        setState(() {
          currentQuestionIndex++;
          selectedOption = null;
        });
      } else {
        Get.offNamed('/result');
      }
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
        selectedOption = null;
      });
    }
  }

  String getSkillLabel(String value) {
    switch (value) {
      case "1":
        return 'Very Low';
      case "2":
        return 'Low';
      case "3":
        return 'Below Average';
      case "4":
        return 'Average';
      case "5":
        return 'Above Average';
      case "6":
        return 'High';
      case "7":
        return 'Very High';
      default:
        return 'Unknown';
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestionIndex];

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
              const SizedBox(height: 70),
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
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value;
                      });
                    },
                    title: Text(
                      getSkillLabel(option),
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
                  Text("${currentQuestionIndex + 1}/${questions.length}"),
                  ElevatedButton(
                    onPressed: nextQuestion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedOption != null
                          ? AppTheme.secondaryColor[800]
                          : AppTheme.blackPalette[200],
                    ),
                    child: Text(
                      currentQuestionIndex < questions.length - 1 ? "Next" : "Submit",
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
