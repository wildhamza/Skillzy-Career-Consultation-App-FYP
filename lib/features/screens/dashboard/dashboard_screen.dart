import 'package:basics/components/assessment_card.dart';
import 'package:basics/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String user = "Ghayas";
    String getGreeting() {
      final hour = DateTime.now().hour;

      if (hour >= 5 && hour < 12) {
        return "Morning";
      } else if (hour >= 12 && hour < 18) {
        return "Afternoon";
      } else {
        return "Evening";
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Good ${getGreeting()} ",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: user,
                        style: TextStyle(
                          color: AppTheme.secondaryColor[600],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Welcome ",
                        style: TextStyle(
                          color: AppTheme.secondaryColor[600],
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const TextSpan(
                        text: "back",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                const Text("Tip of the day", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700,)),
                const SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                      color: AppTheme.secondaryColor[900],
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Stack(
                        children: [
                          SvgPicture.asset(
                            'assets/svg/quote.svg',
                            height: 30,
                            width: 30,
                            fit: BoxFit.contain,
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text("         Choose a job you love, and you will never have to work a day in your life.", style: TextStyle(
                                  height: 2, fontWeight: FontWeight.w600, fontSize: 17, color: AppTheme.whitePalette[500]
                              )),
                          )
                        ],
                      ),
                  ),
                ),

                const SizedBox(height: 40),

                const Text("Your Assessments Journey", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700,)),
                const SizedBox(height: 15),
                const AssessmentCard(
                  date: 'July 12, 2024',
                  skills: ['Communication', 'Problem Solving', 'Leadership'],
                  careers: ['Marketing Manager', 'Project Manager', 'HR Specialist'],
                ),
                const SizedBox(height: 15),
                const AssessmentCard(
                  date: 'August 5, 2024',
                  skills: ['Critical Thinking', 'Creativity', 'Teamwork'],
                  careers: ['Graphic Designer', 'Data Analyst', 'Content Writer'],
                ),
                const SizedBox(height: 15),
                const AssessmentCard(
                  date: 'September 10, 2024',
                  skills: ['Technical Knowledge', 'Attention to Detail', 'Adaptability'],
                  careers: ['Software Engineer', 'Quality Assurance Specialist', 'IT Support Specialist'],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
