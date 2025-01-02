import 'package:basics/utils/theme.dart';
import 'package:flutter/material.dart';

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
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(16.0),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
