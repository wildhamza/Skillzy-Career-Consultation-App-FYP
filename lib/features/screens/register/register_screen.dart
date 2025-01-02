import 'package:basics/features/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:basics/utils/theme.dart';
import 'package:get/get.dart'; // Import your theme

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
              // App Logo
              Center(
                child: Image.asset(
                  'assets/img/logo.png', // Replace with your app logo path
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
              // First Name Input Field
              const TextField(
                decoration: InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 20),
              // Last Name Input Field
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 20),
              // Email Input Field
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              // Password Input Field
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
                    foregroundColor: Colors.white
                ),
                child: Text('Register'.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 5),
              // Forgot Password and Register Options
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'Login instead',
                  style: TextStyle(
                    color: AppTheme.secondaryColor[500], // Use secondary color for text
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
