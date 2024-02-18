import 'package:flutter/material.dart';
import 'package:smartpay/src/utils/app_color.dart';
import 'package:smartpay/src/utils/text_util.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    required this.controller,
    this.onbscureText = false,
    this.validator,
    this.onChanged,
    this.enabled = true,
  });
  final TextEditingController controller;
  final String? label;
  final String? hint;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool onbscureText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: mediumStyle(16, AppColors.grey900),
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      cursorColor: AppColors.grey900,
      cursorWidth: 1,
      obscureText: onbscureText,
      obscuringCharacter: "•",
      enabled: enabled,
    );
  }
}
