import 'dart:convert';
import 'dart:math';

import 'package:basics/components/assessment_card.dart';
import 'package:basics/utils/getQuotes.dart';
import 'package:basics/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<dynamic> recommendations = [];
  bool isLoading = true;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    fetchRecommendations();
  }

  Future<void> fetchRecommendations() async {
    final baseUrl = dotenv.env['BASE_URL'];
    final box = GetStorage();
    final userData = box.read('user');
    final token = box.read('token');
    final userId = userData["_id"];

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/recommendation?userId=$userId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        setState(() {
          recommendations = body["data"]["recommendations"];
          isLoading = false;
        });
      } else {
        setState(() {
          isError = true;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isError = true;
        isLoading = false;
      });
    }
  }

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) return "Morning";
    if (hour >= 12 && hour < 18) return "Afternoon";
    return "Evening";
  }

  String formatDate(String isoDate) {
    final date = DateTime.parse(isoDate);
    final day = date.day;
    final suffix = (day >= 11 && day <= 13)
        ? 'th'
        : (day % 10 == 1)
        ? 'st'
        : (day % 10 == 2)
        ? 'nd'
        : (day % 10 == 3)
        ? 'rd'
        : 'th';
    return '${day}$suffix ${DateFormat("MMMM, y").format(date)}';
  }

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final userData = box.read('user');
    final user = "${userData["firstName"]} ${userData["lastName"]}";
    final randomQuote = getQuotes()[Random().nextInt(getQuotes().length)];

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(20),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : isError
              ? const Center(child: Text("Failed to load recommendations"))
              : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Good ${getGreeting()} ",
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      TextSpan(
                        text: user,
                        style: TextStyle(
                          color: AppTheme.primaryColor[300],
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
                          color: AppTheme.primaryColor[300],
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
                const SizedBox(height: 60),
                const Text("Tip of the day",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                const SizedBox(height: 15),
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(width: 3, color: Colors.white),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          randomQuote,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            height: 1.6,
                            color: AppTheme.secondaryColor[500],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 60),
                const Text("Your Assessments Journey",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                const SizedBox(height: 15),
                ...recommendations.map((rec) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: AssessmentCard(
                      date: formatDate(rec["createdAt"]),
                      skills: List<String>.from(rec["recommendedSkills"]),
                      careers: [rec["recommendedCareer"]],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
