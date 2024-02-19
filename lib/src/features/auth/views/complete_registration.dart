import 'package:flutter/material.dart';
import 'package:smartpay/src/components/custom_button.dart';
import 'package:smartpay/src/features/auth/views/login_screen.dart';
import 'package:smartpay/src/utils/app_asset.dart';
import 'package:smartpay/src/utils/app_color.dart';
import 'package:smartpay/src/utils/spacing_util.dart';
import 'package:smartpay/src/utils/text_util.dart';

class CompleteReg extends StatefulWidget {
  const CompleteReg({super.key});
  static const String routeName = "/complete_reg";
  @override
  State<CompleteReg> createState() => _CompleteRegState();
}

class _CompleteRegState extends State<CompleteReg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 140, height: 140, child: Image.asset(AppAsset.thumb)),
              const YMargin(40),
              Text(
                "Congratulations, James",
                style: boldStyle(24, AppColors.grey900, letterSpacing: -.2),
              ),
              const YMargin(20),
              Text(
                "You’ve completed the onboarding, \nyou can start using",
                textAlign: TextAlign.center,
                style: normalStyle(16, AppColors.grey500),
              ),
              const YMargin(20),
              CustomButton(
                text: "Get Started",
                function: () {
                  Navigator.pushNamed(context, LoginScreen.routeName);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
