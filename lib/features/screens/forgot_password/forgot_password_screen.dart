import 'package:flutter/material.dart';
import 'package:basics/utils/theme.dart';
import 'package:get/get.dart'; // Import your theme

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

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
                   "Write your email address",
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
                   labelText: 'Email',
                   border: OutlineInputBorder(),
                   prefixIcon: Icon(Icons.email),
                 ),
                 keyboardType: TextInputType.emailAddress,
               ),
               const SizedBox(height: 20),
               // Login Button
               ElevatedButton(
                 onPressed: () {
                   Get.toNamed('/otp');
                 },
                 style: ElevatedButton.styleFrom(
                     backgroundColor: AppTheme.primaryColor[500],
                     foregroundColor: Colors.white
                 ),
                 child: Text('Send Email'.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold)),
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
         ),
       ),
      )
    );
  }
}
