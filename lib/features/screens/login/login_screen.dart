import 'package:flutter/material.dart';
import 'package:basics/utils/theme.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print(Theme.of(context).textTheme.bodyMedium?.color);

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
                // App Logo
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
                      color: Theme.of(context).textTheme.bodyMedium?.color
                    ),
                  ),
                ),
                const SizedBox(height: 80),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Get.offNamed('/home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor[500],
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Login'.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.toNamed('/forgot_password');
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: AppTheme.secondaryColor[500], // Use secondary color for text
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed('/register');
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: AppTheme.secondaryColor[500], // Use secondary color for text
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
