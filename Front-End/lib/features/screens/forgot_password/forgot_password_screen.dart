import 'package:basics/constants/api_constants.dart';
import 'package:basics/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:basics/utils/theme.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final box = GetStorage();

  bool _isLoading = false;

  Future<void> _sendResetEmail() async {
    setState(() => _isLoading = true);

    final String? baseUrl = ApiConstants.baseUrl;
    final String url = '$baseUrl/auth/forgot-password';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "email": _emailController.text.trim(),
        }),
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200 && data['status'] == 'success') {
        await box.write('email', _emailController.text.trim());
        showAppSnackbar(
            'OTP Sent', data['message'] ?? 'Email sent!', "success");
        Get.toNamed('/otp', arguments: {
          'email': _emailController.text.trim(),
          'type': 'forgot'
        });
      } else {
        final error = jsonDecode(response.body);
        showAppSnackbar(
            'Login Failed', error['message'] ?? 'Unknown error', "error");
      }
    } catch (e) {
      showAppSnackbar('Error', 'Something went wrong!', "error");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 40),
                  Center(
                    child: Image.asset(
                      'assets/img/logo.png',
                      width: 100,
                      height: 100,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      "Write your email address",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 80),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _sendResetEmail,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor[500],
                        foregroundColor: Colors.white),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text('Send Email'.toUpperCase(),
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        if (_isLoading)
                          const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2),
                          )
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      'Login instead',
                      style: TextStyle(
                        color: AppTheme.secondaryColor[500],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
