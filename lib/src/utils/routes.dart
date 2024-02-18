import 'package:flutter/material.dart';
import 'package:smartpay/src/components/animations.dart';
import 'package:smartpay/src/components/splash_screen.dart';
import 'package:smartpay/src/features/auth/views/login_screen.dart';
import 'package:smartpay/src/features/auth/views/register_screen.dart';
import 'package:smartpay/src/features/onboarding/views/onboarding.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.routeName:
        return FadeRoute(page: const SplashScreen());
      case OnboardingScreen.routeName:
        return ScaleRoute(page: const OnboardingScreen());
      case RegisterScreen.routeName:
        return ScaleRoute(page: const RegisterScreen());
      case LoginScreen.routeName:
        return SlideRightRoute(page: const LoginScreen());
      default:
        return FadeRoute(page: const SplashScreen());
    }
  }
}
