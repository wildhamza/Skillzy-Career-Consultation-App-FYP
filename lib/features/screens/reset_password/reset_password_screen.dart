import 'package:flutter/material.dart';
import 'package:basics/utils/theme.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Reset Pasword'),
        backgroundColor: AppTheme.primaryColor[900],
      ),
      body: SingleChildScrollView(
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
              const Center(
                child: Text(
                  "Change your Password",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 80),
              // Email Input Field
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              // Password Input Field
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Password Confirmation',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              // Login Button
              ElevatedButton(
                onPressed: () {
                  // Go to Home
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor[500],
                    foregroundColor: Colors.white
                ),
                child: Text('Update Password'.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
