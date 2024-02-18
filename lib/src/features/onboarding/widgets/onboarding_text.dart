import 'package:flutter/material.dart';
import 'package:smartpay/src/utils/app_color.dart';
import 'package:smartpay/src/utils/spacing_util.dart';
import 'package:smartpay/src/utils/text_util.dart';

class OnboardingText extends StatelessWidget {
  const OnboardingText({
    super.key,
    required this.title,
    required this.subtitle,
  });
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: boldStyle(24, AppColors.grey900, letterSpacing: -.2),
        ),
        const YMargin(20),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: mediumStyle(14, AppColors.grey500, letterSpacing: .3),
        ),
      ],
    );
  }
}
