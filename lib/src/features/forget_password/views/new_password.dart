import 'package:flutter/material.dart';
import 'package:smartpay/src/components/components.dart';
import 'package:smartpay/src/features/auth/views/login_screen.dart';
import 'package:smartpay/src/utils/utils.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key});
  static const String routeName = "/new_password";
  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final passController = TextEditingController();
  final confirmPass = TextEditingController();
  bool obscured = true;
  bool obscured1 = true;
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BoldHeader(text: "Create New Password"),
            const YMargin(10),
            const LightHeader(text: "Please, enter a new password below different from the previous password"),
            const YMargin(30),
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
            const YMargin(10),
            InputField(
              controller: confirmPass,
              hint: "Confirm password",
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    obscured1 = !obscured1;
                  });
                },
                child: Icon(
                  obscured1 ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  size: 20,
                  weight: 1.5,
                  color: AppColors.grey500,
                ),
              ),
              onbscureText: obscured1,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "password field is required";
                }
                return null;
              },
              onChanged: (p0) => setState(() {}),
              keyboardType: TextInputType.visiblePassword,
            ),
            const Spacer(),
            CustomButton(
              text: "Create new password",
              function: () {
                FocusScope.of(context).unfocus();
                Navigator.pushNamed(context, LoginScreen.routeName);
              },
              disabled: passController.text.trim().isEmpty ||
                  confirmPass.text.trim().isEmpty ||
                  confirmPass.text.trim() != passController.text.trim(),
            )
          ],
        ),
      ),
    );
  }
}
