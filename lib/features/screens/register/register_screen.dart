import 'package:basics/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:basics/utils/theme.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:get_storage/get_storage.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController = TextEditingController();
  final box = GetStorage();

  bool _isLoading = false;

  Future<void> _register() async {
    setState(() {
      _isLoading = true;
    });

    // Password confirmation check
    if (_passwordController.text.trim() != _passwordConfirmController.text.trim()) {
      showAppSnackbar('Error', 'Passwords do not match', 'error');
      setState(() => _isLoading = false);
      return;
    }

    final String? baseUrl = dotenv.env['BASE_URL'];
    final String url = '$baseUrl/auth/signup';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "firstName": _firstNameController.text.trim(),
          "lastName": _lastNameController.text.trim(),
          "email": _emailController.text.trim(),
          "password": _passwordController.text.trim(),
          "passwordConfirm": _passwordConfirmController.text.trim(),
        }),
      );
      final data = json.decode(response.body);
      if (response.statusCode == 201 && data['status'] == 'success') {
        final responseData = jsonDecode(response.body);
        showAppSnackbar('Success', data["message"], "success");
        Get.offNamed('/otp', arguments: {
          'email': _emailController.text.trim(),
          'type': 'verify'
        });
        final token = responseData['token'];
        final user = responseData['data']['user'];
        await box.write('token', token);
        await box.write('user', user);
      } else {
        showAppSnackbar('Signup Failed', data["message"], "error");
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
                  const Center(
                    child: Text(
                      "Create an account",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
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
                  TextField(
                    controller: _passwordConfirmController,
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: _isLoading ? null : _register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor[500],
                        foregroundColor: Colors.white,
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Text('Register'.toUpperCase(),
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                          if (_isLoading)
                            const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                            )
                        ],
                      )
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
            )
        ),
      ),
    );
  }
}
