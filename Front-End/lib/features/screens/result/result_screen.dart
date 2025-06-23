import 'package:basics/constants/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:basics/utils/theme.dart';
import 'dart:convert';
import 'package:basics/utils/index.dart';
import 'package:http/http.dart' as http;

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List<String> recommendedSkills = [];
  String recommendedCareer = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    final List<String?> options = args['options'];
    submitAnswers(options);
  }

  Future<void> submitAnswers(List<String?> options) async {
    final box = GetStorage();
    final token = box.read('token');
    final String? baseUrl = ApiConstants.baseUrl;
    final String url = '$baseUrl/recommendation/recommend-career';

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "answers": options,
        }),
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200 && data["status"] == "success") {
        final recommendation = data["data"]["recommendation"];
        setState(() {
          recommendedSkills =
              List<String>.from(recommendation["recommendedSkills"]);
          recommendedCareer = recommendation["recommendedCareer"];
        });
      } else {
        print(data);
        showAppSnackbar(
            'Error', data["message"] ?? "Something went wrong", "error");
      }
    } catch (e) {
      showAppSnackbar('Error', "Failed to submit answers", "error");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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
              if (_isLoading)
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
                          child: LoadingAnimationWidget.waveDots(
                              color: Colors.white, size: 120),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Text(
                      "Generating skills and \n career for you",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(height: 1.5, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    )
                  ],
                )
              else
                Column(
                  children: [
                    Text(
                      "Recommended Career Path",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      recommendedCareer,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 18, height: 1.7),
                    ),
                    const SizedBox(height: 60),
                    Text(
                      "Recommended Skills",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    for (var skill in recommendedSkills)
                      Text(
                        skill,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontSize: 18, height: 1.7),
                      ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed('/home');
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryColor[500],
                          foregroundColor: Colors.white),
                      child: Text('Continue'.toUpperCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold)),
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
