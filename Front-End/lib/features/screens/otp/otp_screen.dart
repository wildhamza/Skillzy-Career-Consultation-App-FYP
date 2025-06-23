import 'package:basics/constants/api_constants.dart';
import 'package:basics/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:basics/utils/theme.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final String? baseUrl = ApiConstants.baseUrl;
  String otp = '';
  bool _isLoading = false;

  late final String email;
  late final String type;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    email = args['email'];
    type = args['type']; // 'verify' or 'forgot'
  }

  Future<void> verifyOtp() async {
    if (otp.length != 6) {
      Get.snackbar('Invalid OTP', 'Please enter a 6-digit OTP');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final url = Uri.parse(
        type == 'verify'
            ? '$baseUrl/auth/verify-email'
            : '$baseUrl/auth/verify-reset-password-otp',
      );

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({'email': email, 'otp': otp}),
      );

      final res = json.decode(response.body);

      if (response.statusCode == 200 && res['status'] == 'success') {
        if (type == 'verify') {
          // Navigate to home after email verification
          Get.offAllNamed('/home');
        } else {
          // Navigate to reset password screen
          Get.offNamed('/reset_password', arguments: {'otp': otp});
        }

        showAppSnackbar('Success', res['message'] ?? 'OTP Verified', "success");
      } else {
        showAppSnackbar(
            'Error', res['message'] ?? 'Verification failed', "error");
      }
    } catch (e) {
      showAppSnackbar('Error', 'Something went wrong', "error");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: isDarkMode ? Colors.white : Colors.black,
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.primaryColor[100]!),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Center(
                child:
                    Image.asset('assets/img/logo.png', width: 100, height: 100),
              ),
              const SizedBox(height: 10),
              const Text(
                "Enter 4 digit OTP",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 80),
              Pinput(
                length: 6,
                defaultPinTheme: defaultPinTheme,
                onCompleted: (value) => otp = value,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                  onPressed: _isLoading ? null : verifyOtp,
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
      ),
    );
  }
}
