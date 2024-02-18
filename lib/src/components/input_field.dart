import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    this.inputFormatters,
    this.textAlign,
    this.textStyle,
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
  final TextAlign? textAlign;
  final TextStyle? textStyle;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: textStyle ?? mediumStyle(16, AppColors.grey900),
      textAlign: textAlign ?? TextAlign.start,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      textCapitalization: TextCapitalization.sentences,
      cursorColor: AppColors.grey900,
      cursorWidth: 1,
      inputFormatters: inputFormatters,
      obscureText: onbscureText,
      obscuringCharacter: "•",
      enabled: enabled,
    );
  }
}
