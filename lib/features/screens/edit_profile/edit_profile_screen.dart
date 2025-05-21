import 'dart:convert';

import 'package:basics/utils/index.dart';
import 'package:basics/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  final box = GetStorage();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    final userData = box.read('user');
    _firstNameController.text = userData['firstName'] ?? '';
    _lastNameController.text = userData['lastName'] ?? '';
  }

  Future<void> updateProfile() async {
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();

    if (firstName.isEmpty || lastName.isEmpty) {
      Get.snackbar("Error", "All fields are required");
      return;
    }

    setState(() {
      isLoading = true;
    });

    final baseUrl = dotenv.env['BASE_URL'];
    final token = box.read("token");

    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/users/update-me'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          "firstName": firstName,
          "lastName": lastName,
        }),
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        // Update local storage user
        final updatedUser = data['data']['user'];
        box.write('user', updatedUser);
        Get.back(result: updatedUser);
      } else {
        showAppSnackbar('Error', data["message"] ?? 'Something went wrong!', "error");
      }
    } catch (e) {
      showAppSnackbar('Error', "Failed to update profile", "error");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600)),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 32),
              TextField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 20),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: isLoading ? null : updateProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor[500],
                        foregroundColor: Colors.white,
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Text('Update Profile'.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          if (isLoading)
                            const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                            )
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
