// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:smartpay/src/core/hive_service.dart';
import 'package:smartpay/src/features/dashboard/views/home_screen.dart';
import 'package:smartpay/src/features/onboarding/views/onboarding.dart';
import 'package:smartpay/src/utils/utils.dart';

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
    Future.microtask(() {
      navigate();
    });
  }

  final hive = HiveService();
  void navigate() async {
    if (await hive.isExists(boxName: Constants.token)) {
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } else {
      Navigator.pushReplacementNamed(context, OnboardingScreen.routeName);
    }
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
