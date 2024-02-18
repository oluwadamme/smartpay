import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartpay/src/components/custom_back_button.dart';
import 'package:smartpay/src/components/custom_button.dart';
import 'package:smartpay/src/components/input_field.dart';
import 'package:smartpay/src/features/auth/data/controller/auth_controller.dart';
import 'package:smartpay/src/features/auth/data/controller/auth_state.dart';
import 'package:smartpay/src/features/auth/views/register_screen.dart';
import 'package:smartpay/src/features/auth/views/widgets/other_auth_method.dart';
import 'package:smartpay/src/utils/app_asset.dart';
import 'package:smartpay/src/utils/app_color.dart';
import 'package:smartpay/src/utils/extensions.dart';
import 'package:smartpay/src/utils/spacing_util.dart';
import 'package:smartpay/src/utils/text_util.dart';
import 'package:smartpay/src/utils/toast_util.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 8,
        leading: const SizedBox.shrink(),
        title: const CustomBackButton(),
      ),
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<AuthProvider, AuthState>(listener: (context, state) {
        if (state.error != null) {
          ToastUtil.showErrorToast(context, state.error ?? "Error");
          return;
        }
        if (state.data != null) {
          return;
        }
      }, builder: (context, state) {
        return Form(
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
                    if (formKey.currentState!.validate()) {
                      login();
                    }
                  },
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
