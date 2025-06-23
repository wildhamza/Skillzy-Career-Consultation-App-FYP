import 'package:basics/constants/api_constants.dart';
import 'package:basics/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:basics/utils/theme.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final String? baseUrl = ApiConstants.baseUrl;
  bool _isLoading = false;

  late final String otp;

  @override
  void initState() {
    super.initState();
    otp = Get.arguments['otp'];
  }

  Future<void> resetPassword() async {
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (password.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar('Error', 'Please fill both fields');
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar('Error', 'Passwords do not match');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/reset-password'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'otp': otp,
          'password': password,
          'password_confirm': confirmPassword,
        }),
      );

      final res = json.decode(response.body);

      if (response.statusCode == 200 && res['status'] == 'success') {
        Get.offAllNamed('/login');
        showAppSnackbar(
            'Success', res['message'] ?? 'Password updated', "success");
      } else {
        showAppSnackbar('Error', res['message'] ?? 'Reset failed', "error");
      }
    } catch (e) {
      showAppSnackbar('Error', 'Something went wrong', "error");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Reset Password'),
        backgroundColor: AppTheme.primaryColor[900],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Center(
                child: Image.asset('assets/img/logo.png',
                    width: 100, height: 100)),
            const SizedBox(height: 10),
            const Text("Change your Password",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 80),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(
                labelText: 'Password Confirmation',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: _isLoading ? null : resetPassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor[500],
                  foregroundColor: Colors.white,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Text('Update Password'.toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    if (_isLoading)
                      const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2),
                      )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
