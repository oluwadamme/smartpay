import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartpay/src/components/components.dart';
import 'package:smartpay/src/features/forget_password/views/new_password.dart';
import 'package:smartpay/src/utils/utils.dart';

class VerifyIdentityPage extends StatelessWidget {
  const VerifyIdentityPage({super.key, required this.email});
  final String email;
  static const String routeName = "/verify_identity";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20)
            .copyWith(top: MediaQuery.of(context).padding.top + 40, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(AppAsset.person),
            const YMargin(20),
            const BoldHeader(text: "Verify your identity"),
            const YMargin(10),
            RichText(
              text: TextSpan(
                text: "Where would you like ",
                style: normalStyle(16, AppColors.grey500),
                children: [
                  TextSpan(
                    text: "Smartpay",
                    style: boldStyle(16, AppColors.primary),
                  ),
                  TextSpan(
                    text: " to send your security code?",
                    style: normalStyle(16, AppColors.grey500),
                  )
                ],
              ),
            ),
            const YMargin(20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
              decoration: BoxDecoration(color: AppColors.grey50, borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  Checkbox(
                    value: true,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                    onChanged: (value) {},
                    activeColor: AppColors.primary,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email",
                          style: boldStyle(16, AppColors.grey900),
                        ),
                        LightHeader(text: "${email.split("@").first[0]}*****@${email.split("@").last}")
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.mail_outline_outlined,
                    color: AppColors.grey400,
                  )
                ],
              ),
            ),
            const Spacer(),
            CustomButton(
              text: "Continue",
              function: () {
                Navigator.pushNamed(context, NewPasswordPage.routeName);
              },
            )
          ],
        ),
      ),
    );
  }
}
