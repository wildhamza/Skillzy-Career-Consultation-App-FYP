import 'package:basics/constants/api_constants.dart';
import 'package:basics/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:basics/utils/theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  final box = GetStorage();

  Future<void> login() async {
    setState(() {
      _isLoading = true;
    });
    final baseUrl = ApiConstants.baseUrl;
    final url = Uri.parse('$baseUrl/auth/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': _emailController.text.trim(),
          'password': _passwordController.text.trim(),
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData["message"] != null &&
            responseData["message"].toString().isNotEmpty) {
          showAppSnackbar('OTP Sent', responseData["message"], "success");
          Get.offNamed('/otp', arguments: {
            'email': _emailController.text.trim(),
            'type': 'verify'
          });
        } else {
          final token = responseData['token'];
          final user = responseData['data']['user'];
          await box.write('token', token);
          await box.write('user', user);
          Get.offNamed('/home');
        }
      } else {
        final error = jsonDecode(response.body);
        showAppSnackbar(
            'Login Failed', error['message'] ?? 'Unknown error', "error");
      }
    } catch (e) {
      showAppSnackbar('Error', 'Something went wrong!', "error");
    } finally {
      setState(() {
        _isLoading = false;
      });
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
                Center(
                  child: Text(
                    "Login to your account",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
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
                ElevatedButton(
                  onPressed: login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor[500],
                    foregroundColor: Colors.white,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Text('Login'.toUpperCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold)),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Get.toNamed('/forgot_password'),
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(color: AppTheme.secondaryColor[500]),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Get.toNamed('/register'),
                      child: Text(
                        'Register',
                        style: TextStyle(color: AppTheme.secondaryColor[500]),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
