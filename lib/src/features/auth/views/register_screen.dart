import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartpay/src/components/custom_back_button.dart';
import 'package:smartpay/src/components/custom_button.dart';
import 'package:smartpay/src/components/input_field.dart';
import 'package:smartpay/src/features/auth/data/controller/auth_controller.dart';
import 'package:smartpay/src/features/auth/data/controller/auth_state.dart';
import 'package:smartpay/src/features/auth/views/login_screen.dart';
import 'package:smartpay/src/features/auth/views/verify_email_screen.dart';
import 'package:smartpay/src/features/auth/views/widgets/other_auth_method.dart';
import 'package:smartpay/src/utils/app_color.dart';
import 'package:smartpay/src/utils/extensions.dart';
import 'package:smartpay/src/utils/spacing_util.dart';
import 'package:smartpay/src/utils/text_util.dart';
import 'package:smartpay/src/utils/toast_util.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String routeName = "/register";
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void getEmailToken() async {
    final bloc = BlocProvider.of<AuthProvider>(context);
    await bloc.getToken(emailController.text.trim());
    bloc.regRequest.email = emailController.text.trim();
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
          ToastUtil.showSuccessToast(context, "Code sent");
          //37202
          Navigator.pushNamed(context, VerifyEmailScreen.routeName);
          return;
        }
      }, builder: (context, state) {
        return Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Create a ",
                    style: boldStyle(24, AppColors.grey900),
                    children: [
                      TextSpan(
                        text: "Smartpay",
                        style: boldStyle(24, AppColors.primary),
                      ),
                      TextSpan(
                        text: "\naccount",
                        style: boldStyle(24, AppColors.grey900),
                      ),
                    ],
                  ),
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
                const YMargin(30),
                CustomButton(
                  text: "Sign In",
                  disabled: formKey.currentState != null && !formKey.currentState!.validate(),
                  function: () {
                    FocusScope.of(context).unfocus();
                    if (formKey.currentState!.validate()) {
                      getEmailToken();
                    }
                  },
                  loading: state.loading,
                ),
                const YMargin(40),
                const OtherAuthMethod(),
                const YMargin(100),
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: "Already have an account? ",
                      style: mediumStyle(16, AppColors.grey500),
                      children: [
                        TextSpan(
                          text: "Sign In",
                          style: boldStyle(16, AppColors.primary),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, LoginScreen.routeName);
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
