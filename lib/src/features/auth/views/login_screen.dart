// ignore_for_file: use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartpay/src/components/components.dart';
import 'package:smartpay/src/features/auth/data/controller/auth_controller.dart';
import 'package:smartpay/src/features/auth/data/controller/auth_state.dart';
import 'package:smartpay/src/features/auth/data/model/login_response.dart';
import 'package:smartpay/src/features/auth/views/home_screen.dart';
import 'package:smartpay/src/features/forget_password/views/recover_password.dart';
import 'package:smartpay/src/features/auth/views/register_screen.dart';
import 'package:smartpay/src/features/auth/views/widgets/other_auth_method.dart';
import 'package:smartpay/src/utils/utils.dart';

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

  void login() async {
    final bloc = BlocProvider.of<AuthProvider>(context);
    await bloc.login(
      emailController.text.trim(),
      passController.text.trim(),
    );
    if (bloc.state.error != null) {
      ToastUtil.showErrorToast(context, bloc.state.error ?? "Error");
      return;
    }
    if (bloc.state.data != null && bloc.state.data is LoginResponse) {
      Navigator.pushNamed(context, HomeScreen.routeName);
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navigator.canPop(context)
          ? AppBar(
              leadingWidth: 8,
              leading: const SizedBox.shrink(),
              title: const CustomBackButton(),
            )
          : null,
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<AuthProvider, AuthState>(builder: (context, state) {
        return Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BoldHeader(text: "Hi There! 👋"),
                const YMargin(10),
                const LightHeader(text: "Welcome back, Sign in to your account"),
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
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RecoverPasswordPage.routeName);
                      },
                      child: Text(
                        "Forgot Password?",
                        style: boldStyle(15, AppColors.primary),
                      ),
                    )
                  ],
                ),
                const YMargin(30),
                CustomButton(
                  text: "Sign In",
                  function: () {
                    FocusScope.of(context).unfocus();
                    if (formKey.currentState!.validate()) {
                      login();
                    }
                  },
                  disabled: !(emailController.text.isValidEmail() && passController.text.isNotEmpty),
                  loading: state.loading,
                ),
                const YMargin(40),
                const OtherAuthMethod(),
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
        );
      }),
    );
  }
}
