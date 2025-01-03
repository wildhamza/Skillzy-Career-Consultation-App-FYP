import 'package:flutter/material.dart';
import 'package:basics/utils/theme.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 20, color: isDarkMode ? Colors.white : Colors.black, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.primaryColor[100] ?? const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppTheme.secondaryColor[100] ?? const Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(8),
    );
    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: isDarkMode ? AppTheme.primaryColor[500] : AppTheme.secondaryColor[50] ?? const Color.fromRGBO(234, 239, 243, 1),
      ),
      textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w800)
    );

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
                    "Enter 4 digit OTP",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 80),
                Pinput(
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  validator: (s) {
                    return s == '2222' ? null : 'Pin is incorrect';
                  },
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                  onCompleted: (pin) => print(pin),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Get.offNamed('/home');
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor[500],
                      foregroundColor: Colors.white
                  ),
                  child: Text('Verify OTP'.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
