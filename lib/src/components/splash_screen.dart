import 'package:flutter/material.dart';
import 'package:smartpay/src/features/onboarding/views/onboarding.dart';
import 'package:smartpay/src/utils/app_asset.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = "/";
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, OnboardingScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          color: Colors.white,
          width: 150,
          height: 150,
          child: Image.asset(AppAsset.logo),
        ),
      ),
    );
  }
}
