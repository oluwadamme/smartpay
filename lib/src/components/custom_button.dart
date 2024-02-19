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
    this.loading = false,
    this.disabled = false,
  });
  final String text;
  final VoidCallback function;
  final double? width;
  final bool loading;
  final bool disabled;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: disabled || loading ? null : function,
      style: TextButton.styleFrom(
        backgroundColor: AppColors.grey900.withOpacity(disabled ? 0.7 : 1),
        fixedSize: Size(width ?? screenWidth(context), 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: loading
          ? const SizedBox(width: 25, height: 25, child: CircularProgressIndicator(color: Colors.white))
          : Text(
              text,
              style: boldStyle(15, Colors.white),
            ),
    );
  }
}
