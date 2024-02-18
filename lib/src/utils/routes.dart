import 'package:flutter/material.dart';
import 'package:smartpay/src/components/animations.dart';
import 'package:smartpay/src/components/splash_screen.dart';
import 'package:smartpay/src/features/onboarding/views/onboarding.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.routeName:
        return FadeRoute(page: const SplashScreen());
      case OnboardingScreen.routeName:
        return ScaleRoute(page: const OnboardingScreen());
      default:
        return FadeRoute(page: const SplashScreen());
    }
  }
}
