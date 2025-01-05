import 'package:basics/features/screens/forgot_password/forgot_password_screen.dart';
import 'package:basics/features/screens/home/home_screen.dart';
import 'package:basics/features/screens/otp/otp_screen.dart';
import 'package:basics/features/screens/questions/questions_screen.dart';
import 'package:basics/features/screens/register/register_screen.dart';
import 'package:basics/features/screens/onboarding/onboarding_screen.dart';
import 'package:basics/features/screens/login/login_screen.dart';
import 'package:basics/features/screens/reset_password/reset_password_screen.dart';
import 'package:basics/features/screens/result/result_screen.dart';
import 'package:get/get.dart';

class AppRouter {
  static final getPages = [
    GetPage(
      name: '/',
      page: () => const OnBoardingScreen(),
    ),
    GetPage(
      name: '/login',
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: '/register',
      page: () => const RegisterScreen(),
    ),
    GetPage(
      name: '/forgot_password',
      page: () => const ForgotPasswordScreen(),
    ),
    GetPage(
      name: '/otp',
      page: () => const OtpScreen(),
    ),
    GetPage(
      name: '/reset_password',
      page: () => const ResetPasswordScreen(),
    ),
    GetPage(
      name: '/home',
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: '/questions',
      page: () => const QuestionsScreen(),
    ),
    GetPage(
      name: '/result',
      page: () => const ResultScreen(),
    ),
  ];
}
