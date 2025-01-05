import 'package:basics/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AssessmentCard extends StatelessWidget {
  final String date;
  final List<String> skills;
  final List<String> careers;

  const AssessmentCard({
    super.key,
    required this.date,
    required this.skills,
    required this.careers,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Color textColor = isDarkMode ? AppTheme.whitePalette[500] ?? Colors.white : Colors.black;
    Color textColorLighter = isDarkMode ? AppTheme.whitePalette[100] ?? Colors.black.withOpacity(0.7) : Colors.black.withOpacity(0.7);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 10,
      shadowColor: Colors.black.withOpacity(0.5),
      color: isDarkMode ? AppTheme.primaryColor[500] : AppTheme.primaryColor[100],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date Row
            Row(
              children: [
                SvgPicture.asset(
                  'assets/svg/clock.svg',
                  height: 25,
                  width: 25,
                  fit: BoxFit.contain,
                  colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
                ),
                const SizedBox(width: 10),
                Text(
                  date, // Use the dynamic date here
                  style: TextStyle(
                    fontSize: 14,
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Skills Section
            const Text(
              'Skills Identified:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              skills.map((skill) => '• $skill').join('\n'), // Dynamically display skills
              style: TextStyle(
                fontSize: 14,
                color: textColorLighter,
              ),
            ),
            const SizedBox(height: 16),

            // Suggested Careers Section
            const Text(
              'Suggested Careers:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              careers.map((career) => '• $career').join('\n'), // Dynamically display careers
              style: TextStyle(
                fontSize: 14,
                color: textColorLighter,
              ),
            ),
            const SizedBox(height: 20),

            // View Details Button
            ElevatedButton(
              onPressed: () {
                // Navigate or show full details
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 14),
                elevation: 5,
              ),
              child: const Text(
                'View Details',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
