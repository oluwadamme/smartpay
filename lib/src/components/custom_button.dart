import 'package:flutter/material.dart';
import 'package:smartpay/src/utils/app_color.dart';
import 'package:smartpay/src/utils/spacing_util.dart';
import 'package:smartpay/src/utils/text_util.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.function,
    this.width,
  });
  final String text;
  final VoidCallback function;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: function,
      style: TextButton.styleFrom(
        backgroundColor: AppColors.grey900,
        fixedSize: Size(width ?? screenWidth(context), 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Text(
        text,
        style: boldStyle(15, Colors.white),
      ),
    );
  }
}
