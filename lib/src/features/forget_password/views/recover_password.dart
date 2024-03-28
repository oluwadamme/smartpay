import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smartpay/src/components/components.dart';
import 'package:smartpay/src/features/auth/views/login_screen.dart';
import 'package:smartpay/src/features/forget_password/views/verify_identity.dart';
import 'package:smartpay/src/utils/utils.dart';

class RecoverPasswordPage extends StatefulWidget {
  const RecoverPasswordPage({super.key});
  static const String routeName = "/recover_password";
  @override
  State<RecoverPasswordPage> createState() => _RecoverPasswordPageState();
}

class _RecoverPasswordPageState extends State<RecoverPasswordPage> {
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20)
            .copyWith(top: MediaQuery.of(context).padding.top + 40, bottom: MediaQuery.viewInsetsOf(context).bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(AppAsset.lock),
            const YMargin(20),
            const BoldHeader(text: "Password Recovery"),
            const YMargin(10),
            const LightHeader(text: "Enter your registered email below to receive password instructions"),
            const YMargin(20),
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
            const Spacer(),
            CustomButton(
              text: "Send me email",
              function: () {
                FocusScope.of(context).unfocus();
                Navigator.pushNamed(context, VerifyIdentityPage.routeName, arguments: emailController.text);
              },
              disabled: emailController.text.trim().isEmpty || !emailController.text.trim().isValidEmail(),
            ),
            const YMargin(30),
          ],
        ),
      ),
    );
  }
}
