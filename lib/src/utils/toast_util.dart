import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:smartpay/main.dart';
import 'package:smartpay/src/utils/app_color.dart';
import 'package:smartpay/src/utils/text_util.dart';

class ToastUtil {
  static Future<void> showSuccessToast(BuildContext context, String message) async {
    await Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticIn,
      backgroundColor: Colors.greenAccent,
      duration: const Duration(seconds: 5),
      icon: const Icon(
        Icons.check_circle,
        color: Colors.green,
      ),
      borderRadius: BorderRadius.circular(10),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      messageText: Row(
        children: [
          Text(
            message,
            style: mediumStyle(14, AppColors.grey900),
          ),
        ],
      ),
    ).show(navigatorKey.currentContext ?? context);
  }

  static Future<void> showErrorToast(BuildContext context, String msg) async {
    await Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticIn,
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 6),
      borderRadius: BorderRadius.circular(10),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      messageText: Row(
        children: [
          Flexible(
            child: Text(
              msg,
              style: mediumStyle(14, Colors.white),
            ),
          ),
        ],
      ),
    ).show(navigatorKey.currentContext ?? context);
  }
}
