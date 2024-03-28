import 'package:flutter/material.dart';
import 'package:smartpay/src/utils/app_color.dart';
import 'package:smartpay/src/utils/text_util.dart';

class BoldHeader extends StatelessWidget {
  const BoldHeader({super.key, required this.text, this.color});
  final String text;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Text(text, style: boldStyle(24, color ?? AppColors.grey900));
  }
}

class LightHeader extends StatelessWidget {
  const LightHeader({super.key, required this.text, this.color});
  final String text;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: mediumStyle(16, color ?? AppColors.grey500),
    );
  }
}
