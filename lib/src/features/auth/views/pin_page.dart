// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:smartpay/src/components/components.dart';
import 'package:smartpay/src/components/keypad.dart';
import 'package:smartpay/src/features/auth/data/controller/auth_controller.dart';
import 'package:smartpay/src/features/auth/data/controller/auth_state.dart';
import 'package:smartpay/src/features/auth/data/model/register_request.dart';
import 'package:smartpay/src/features/auth/views/complete_registration.dart';
import 'package:smartpay/src/utils/utils.dart';

class PinPage extends StatefulWidget {
  const PinPage({super.key, required this.request});
  static const String routeName = "/pin_page";
  final RegisterRequest request;
  @override
  State<PinPage> createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> {
  String pin = "";
  final controller = TextEditingController();
  void register() async {
    final bloc = BlocProvider.of<AuthProvider>(context);
    final request = RegisterRequest(
      email: bloc.regRequest.email,
      country: widget.request.country,
      deviceName: widget.request.deviceName,
      fullName: widget.request.fullName,
      password: widget.request.password,
      username: widget.request.username,
      pin: controller.text,
    );

    await bloc.register(request);
    if (bloc.state.error != null) {
      ToastUtil.showErrorToast(context, bloc.state.error ?? "Error");
      return;
    }
    if (bloc.state.data != null) {
      Navigator.pushNamed(
        context,
        CompleteReg.routeName,
        arguments: widget.request.username,
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 8,
        leading: const SizedBox.shrink(),
        title: const CustomBackButton(),
      ),
      body: BlocBuilder<AuthProvider, AuthState>(builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BoldHeader(text: "Set your PIN code"),
              const YMargin(10),
              const LightHeader(
                  text: "We use state-of-the-art security measures to protect your information at all times"),
              const YMargin(50),
              PinCodeTextField(
                length: 5,
                obscureText: false,
                appContext: context,
                animationType: AnimationType.fade,
                keyboardType: TextInputType.none,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.underline,
                  fieldHeight: 56,
                  fieldWidth: 56,
                  borderWidth: 1,
                  selectedColor: AppColors.primary400,
                  selectedBorderWidth: 1,
                  selectedFillColor: AppColors.grey50,
                  inactiveColor: AppColors.primary,
                  inactiveFillColor: Colors.white,
                  errorBorderWidth: 0,
                  disabledColor: AppColors.grey50,
                  activeColor: AppColors.primary,
                  errorBorderColor: AppColors.grey50,
                  activeFillColor: Colors.white,
                ),
                cursorColor: AppColors.primary,
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
                    register();
                  }
                  return true;
                },
              ),
              const Spacer(),
              CustomButton(
                text: "Create PIN",
                disabled: pin.length < 5,
                function: () {
                  register();
                },
                loading: state.loading,
              ),
              const YMargin(40),
              Keypad(pin: controller),
            ],
          ),
        );
      }),
    );
  }
}
