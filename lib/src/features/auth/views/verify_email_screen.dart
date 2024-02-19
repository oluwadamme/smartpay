import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:smartpay/src/components/custom_back_button.dart';
import 'package:smartpay/src/components/custom_button.dart';
import 'package:smartpay/src/components/input_field.dart';
import 'package:smartpay/src/features/auth/data/controller/auth_controller.dart';
import 'package:smartpay/src/features/auth/data/controller/auth_state.dart';
import 'package:smartpay/src/features/auth/views/about_you_screen.dart';
import 'package:smartpay/src/utils/app_color.dart';
import 'package:smartpay/src/utils/spacing_util.dart';
import 'package:smartpay/src/utils/text_util.dart';
import 'package:smartpay/src/utils/toast_util.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});
  static const String routeName = "/verify_email";
  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  String pin = "";
  void getEmailToken() async {
    final bloc = BlocProvider.of<AuthProvider>(context);
    await bloc.getToken(bloc.regRequest.email!);
  }

  void verifyToken() async {
    final bloc = BlocProvider.of<AuthProvider>(context);
    await bloc.validateToken(bloc.regRequest.email!, pin);
  }

  final controller = TextEditingController();

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 8,
        leading: const SizedBox.shrink(),
        title: const CustomBackButton(),
      ),
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<AuthProvider, AuthState>(listener: (context, state) {
        if (state.error != null) {
          ToastUtil.showErrorToast(context, state.error ?? "Error");
          return;
        }
        if (state.data != null) {
          Navigator.pushNamed(context, AboutYouScreen.routeName);
          return;
        }
      }, builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Verify it’s you", style: boldStyle(24, AppColors.grey900)),
              const YMargin(10),
              Text.rich(
                TextSpan(
                  text: "We send a code to ( ",
                  style: mediumStyle(16, AppColors.grey500),
                  children: [
                    TextSpan(
                      text: "****@${context.read<AuthProvider>().regRequest.email!.split("@").last}",
                      style: semiBoldStyle(16, AppColors.grey900),
                    ),
                    TextSpan(
                      text: " ). Enter it here to verify your identity",
                      style: mediumStyle(16, AppColors.grey500),
                    ),
                  ],
                ),
              ),
              const YMargin(30),
              PinCodeTextField(
                length: 5,
                obscureText: false,
                appContext: context,
                animationType: AnimationType.fade,
                keyboardType: TextInputType.number,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(12),
                  fieldHeight: 56,
                  fieldWidth: 56,
                  borderWidth: 1,
                  selectedColor: AppColors.primary400,
                  selectedBorderWidth: 1,
                  selectedFillColor: AppColors.grey50,
                  inactiveColor: AppColors.grey50,
                  inactiveFillColor: AppColors.grey50,
                  errorBorderWidth: 0,
                  disabledColor: AppColors.grey50,
                  activeColor: Colors.white,
                  errorBorderColor: AppColors.grey50,
                  activeFillColor: AppColors.grey50,
                ),
                enableActiveFill: true,
                animationDuration: const Duration(milliseconds: 300),
                backgroundColor: Colors.white,
                controller: controller,
                onCompleted: (v) {},
                onChanged: (value) {
                  setState(() {
                    pin = value;
                  });
                },
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  setState(() {
                    pin = text ?? "";
                  });
                  if (pin.length == 5) {
                    verifyToken();
                  }
                  return true;
                },
              ),
              const YMargin(30),
              Center(
                child: TweenAnimationBuilder(
                  duration: const Duration(seconds: 30),
                  tween: Tween<Duration>(begin: const Duration(seconds: 30), end: const Duration(seconds: 0)),
                  builder: (context, obj, child) {
                    return TextButton(
                      onPressed: obj.inSeconds == 0
                          ? () {
                              getEmailToken();
                            }
                          : null,
                      child: Text(
                        "Resend Code ${obj.inSeconds} secs",
                        style: boldStyle(16, AppColors.grey700),
                      ),
                    );
                  },
                ),
              ),
              const YMargin(50),
              CustomButton(
                text: "Confirm",
                disabled: pin.length < 5,
                function: () {
                  verifyToken();
                },
                loading: state.loading,
              ),
            ],
          ),
        );
      }),
    );
  }
}

class PinField extends StatefulWidget {
  const PinField({
    super.key,
    required this.controller,
  });
  final TextEditingController controller;

  @override
  State<PinField> createState() => _PinFieldState();
}

class _PinFieldState extends State<PinField> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InputField(
        controller: widget.controller,
        keyboardType: TextInputType.number,
        inputFormatters: [LengthLimitingTextInputFormatter(1)],
        onChanged: (p0) {
          if (p0.isNotEmpty) {
            if (FocusScope.of(context).hasFocus) {
              FocusScope.of(context).nextFocus();
            }
          }
          setState(() {});
        },
        validator: (p0) {
          if (p0 == null || p0.isEmpty) {
            return '';
          }
          return null;
        },
        textAlign: TextAlign.center,
        textStyle: boldStyle(24, AppColors.grey900),
      ),
    );
  }
}
