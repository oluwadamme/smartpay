import 'package:flutter/material.dart';
import 'package:smartpay/src/components/animations.dart';
import 'package:smartpay/src/components/splash_screen.dart';
import 'package:smartpay/src/features/auth/views/about_you_screen.dart';
import 'package:smartpay/src/features/auth/views/complete_registration.dart';
import 'package:smartpay/src/features/auth/views/home_screen.dart';
import 'package:smartpay/src/features/auth/views/login_screen.dart';
import 'package:smartpay/src/features/forget_password/views/new_password.dart';
import 'package:smartpay/src/features/forget_password/views/recover_password.dart';
import 'package:smartpay/src/features/auth/views/register_screen.dart';
import 'package:smartpay/src/features/auth/views/verify_email_screen.dart';
import 'package:smartpay/src/features/forget_password/views/verify_identity.dart';
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
      case VerifyEmailScreen.routeName:
        return ScaleRoute(page: const VerifyEmailScreen());
      case AboutYouScreen.routeName:
        return ScaleRoute(page: const AboutYouScreen());
      case CompleteReg.routeName:
        return ScaleRoute(page: const CompleteReg());
      case HomeScreen.routeName:
        return ScaleRoute(page: const HomeScreen());
      case LoginScreen.routeName:
        return SlideRightRoute(page: const LoginScreen());
      case RecoverPasswordPage.routeName:
        return FadeRoute(page: const RecoverPasswordPage());
      case NewPasswordPage.routeName:
        return SizeRoute(page: const NewPasswordPage());
      case VerifyIdentityPage.routeName:
        return FadeRoute(page: VerifyIdentityPage(email: settings.arguments as String));
      default:
        return FadeRoute(page: const SplashScreen());
    }
  }
}
