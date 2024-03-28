import 'package:flutter/material.dart';
import 'package:smartpay/src/utils/utils.dart';

class NumberField extends StatelessWidget {
  const NumberField({
    super.key,
    required this.label,
    required this.onTap,
  });
  final String label;
  final ValueChanged onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(label),
      child: Material(
        color: Colors.transparent,
        child: SizedBox(
          width: 40,
          height: 40,
          child: Text(label, style: mediumStyle(20, AppColors.grey900)),
        ),
      ),
    );
  }
}
