import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartpay/src/components/custom_back_button.dart';
import 'package:smartpay/src/components/custom_button.dart';
import 'package:smartpay/src/components/input_field.dart';
import 'package:smartpay/src/features/auth/views/register_screen.dart';
import 'package:smartpay/src/utils/app_asset.dart';
import 'package:smartpay/src/utils/app_color.dart';
import 'package:smartpay/src/utils/extensions.dart';
import 'package:smartpay/src/utils/spacing_util.dart';
import 'package:smartpay/src/utils/text_util.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = "/login";
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool obscured = true;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 8,
        leading: const SizedBox.shrink(),
        title: const CustomBackButton(),
      ),
      resizeToAvoidBottomInset: false,
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Hi There! 👋", style: boldStyle(24, AppColors.grey900)),
              const YMargin(10),
              Text(
                "Welcome back, Sign in to your account",
                style: mediumStyle(16, AppColors.grey500),
              ),
              const YMargin(30),
              InputField(
                controller: emailController,
                hint: "Email",
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Email field is required";
                  }
                  if (!value.isValidEmail()) {
                    return "Email is invalid";
                  }
                  return null;
                },
                onChanged: (p0) => setState(() {}),
                keyboardType: TextInputType.emailAddress,
              ),
              const YMargin(10),
              InputField(
                controller: passController,
                hint: "Password",
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      obscured = !obscured;
                    });
                  },
                  child: Icon(
                    obscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    size: 20,
                    weight: 1.5,
                    color: AppColors.grey500,
                  ),
                ),
                onbscureText: obscured,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "password field is required";
                  }
                  return null;
                },
                onChanged: (p0) => setState(() {}),
                keyboardType: TextInputType.visiblePassword,
              ),
              const YMargin(30),
              Row(
                children: [
                  Text(
                    "Forgot Password?",
                    style: boldStyle(15, AppColors.primary),
                  )
                ],
              ),
              const YMargin(30),
              CustomButton(
                text: "Sign In",
                function: () {
                  FocusScope.of(context).unfocus();
                  if (formKey.currentState!.validate()) {}
                },
              ),
              const YMargin(40),
              SvgPicture.asset(AppAsset.or),
              const YMargin(30),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      width: screenWidth(context),
                      height: 56,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.grey200),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(child: SvgPicture.asset(AppAsset.google)),
                    ),
                  ),
                  const XMargin(20),
                  Expanded(
                    child: Container(
                      width: screenWidth(context),
                      height: 56,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.grey200),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(child: SvgPicture.asset(AppAsset.apple)),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Center(
                child: Text.rich(
                  TextSpan(
                    text: "Don’t have an account? ",
                    style: mediumStyle(16, AppColors.grey500),
                    children: [
                      TextSpan(
                        text: "Sign Up",
                        style: boldStyle(16, AppColors.primary),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, RegisterScreen.routeName);
                          },
                      )
                    ],
                  ),
                ),
              ),
              const YMargin(10)
            ],
          ),
        ),
      ),
    );
  }
}
