import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartpay/src/components/custom_back_button.dart';
import 'package:smartpay/src/components/custom_button.dart';
import 'package:smartpay/src/components/input_field.dart';
import 'package:smartpay/src/features/auth/data/controller/auth_controller.dart';
import 'package:smartpay/src/features/auth/data/controller/auth_state.dart';
import 'package:smartpay/src/features/auth/data/model/country.dart';
import 'package:smartpay/src/features/auth/data/model/register_request.dart';
import 'package:smartpay/src/features/auth/views/complete_registration.dart';
import 'package:smartpay/src/utils/app_asset.dart';
import 'package:smartpay/src/utils/app_color.dart';
import 'package:smartpay/src/utils/spacing_util.dart';
import 'package:smartpay/src/utils/text_util.dart';
import 'package:smartpay/src/utils/toast_util.dart';

class AboutYouScreen extends StatefulWidget {
  const AboutYouScreen({super.key});
  static const String routeName = "/about_you";
  @override
  State<AboutYouScreen> createState() => _AboutYouScreenState();
}

class _AboutYouScreenState extends State<AboutYouScreen> {
  final username = TextEditingController();
  final country = TextEditingController();
  final nameController = TextEditingController();
  final passController = TextEditingController();
  Country? selectedCountry;
  final searchController = TextEditingController();
  bool obscured = true;
  bool hasUpperCase(String input) {
    RegExp regex = RegExp(r'[A-Z]');
    return regex.hasMatch(input);
  }

  bool hasLowerCase(String input) {
    RegExp regex = RegExp(r'[a-z]');
    return regex.hasMatch(input);
  }

  bool hasNumber(String input) {
    RegExp regex = RegExp(r'[0-9]');
    return regex.hasMatch(input);
  }

  final formKey = GlobalKey<FormState>();

  void register() async {
    final bloc = BlocProvider.of<AuthProvider>(context);
    final request = RegisterRequest(
      email: bloc.regRequest.email,
      country: selectedCountry!.code,
      deviceName: Platform.localeName,
      fullName: nameController.text.trim(),
      password: passController.text.trim(),
      username: username.text.trim(),
    );
    await bloc.register(request);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 8,
        leading: const SizedBox.shrink(),
        title: const CustomBackButton(),
      ),
      // resizeToAvoidBottomInset: false,
      body: BlocConsumer<AuthProvider, AuthState>(listener: (context, state) {
        if (state.error != null) {
          ToastUtil.showErrorToast(context, state.error ?? "Error");
          return;
        }
        if (state.data != null) {
          Navigator.pushNamedAndRemoveUntil(context, CompleteReg.routeName, (route) => false);
          return;
        }
      }, builder: (context, state) {
        return Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Hey there! tell us a bit \nabout ",
                    style: boldStyle(24, AppColors.grey900),
                    children: [
                      TextSpan(
                        text: "yourself",
                        style: boldStyle(24, AppColors.primary),
                      ),
                    ],
                  ),
                ),
                const YMargin(30),
                InputField(
                  controller: nameController,
                  hint: "Full name",
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "fullname field is required";
                    }
                    if (value.split(" ").length < 2) {
                      return "Enter full name";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name,
                  onChanged: (p0) => setState(() {}),
                ),
                const YMargin(15),
                InputField(
                  controller: username,
                  hint: "Username",
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "fullname field is required";
                    }
                    return null;
                  },
                  onChanged: (p0) {
                    setState(() {});
                  },
                ),
                const YMargin(10),
                InkWell(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    showModalBottomSheet(
                      context: context,
                      isDismissible: false,
                      builder: (context) => ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                        child: StatefulBuilder(builder: (context, setstate) {
                          return Container(
                            width: double.maxFinite,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                              ),
                            ),
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: InputField(
                                        controller: searchController,
                                        hint: "Search",
                                        prefixIcon: SvgPicture.asset(AppAsset.search, fit: BoxFit.scaleDown),
                                        onChanged: (p0) {},
                                      ),
                                    ),
                                    const XMargin(15),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Cancel",
                                        style: boldStyle(16, AppColors.grey900),
                                      ),
                                    )
                                  ],
                                ),
                                const YMargin(20),
                                Expanded(
                                    child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      ...countryList.map(
                                        (e) => Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: InkWell(
                                            onTap: () {
                                              setstate(() {
                                                selectedCountry = e;
                                              });
                                              setState(() {
                                                country.text = e.name;
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                              decoration: BoxDecoration(
                                                color: (selectedCountry != null && selectedCountry!.code == e.code)
                                                    ? AppColors.grey50
                                                    : Colors.white,
                                                borderRadius: BorderRadius.circular(16),
                                              ),
                                              width: double.maxFinite,
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 32,
                                                    height: 24,
                                                    child: Image.asset(e.flag),
                                                  ),
                                                  const XMargin(10),
                                                  Text(
                                                    e.code,
                                                    style: mediumStyle(16, AppColors.grey500),
                                                  ),
                                                  const XMargin(10),
                                                  Text(
                                                    e.name,
                                                    style: boldStyle(16, AppColors.grey900),
                                                  ),
                                                  const Spacer(),
                                                  if (selectedCountry != null && selectedCountry!.code == e.code)
                                                    const Icon(
                                                      Icons.check,
                                                      color: AppColors.primary400,
                                                    )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ))
                              ],
                            ),
                          );
                        }),
                      ),
                    );
                  },
                  child: Material(
                    child: AbsorbPointer(
                      child: InputField(
                        controller: country,
                        hint: "Select Country",
                        suffixIcon: const Icon(Icons.keyboard_arrow_down_outlined),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "field is required";
                          }
                          return null;
                        },
                        textStyle: boldStyle(16, AppColors.grey900),
                        prefixIcon: selectedCountry == null
                            ? null
                            : Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 30,
                                    height: 24,
                                    child: Image.asset(
                                      selectedCountry!.flag,
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ],
                              ),
                        onChanged: (p0) => setState(() {}),
                      ),
                    ),
                  ),
                ),
                const YMargin(10),
                InputField(
                  controller: passController,
                  hint: "Password",
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        obscured = !obscured;
                      });
                    },
                    child: Icon(
                      obscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      size: 20,
                      weight: 1.5,
                      color: AppColors.grey500,
                    ),
                  ),
                  onbscureText: obscured,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "password field is required";
                    }
                    if (value.length < 6) {
                      return "password must be greater than 6 characters";
                    }
                    if (!hasLowerCase(value)) {
                      return "password must have at least one lowercase";
                    }
                    if (!hasUpperCase(value)) {
                      return "password must have at least one uppercase";
                    }
                    if (!hasNumber(value)) {
                      return "password must have at least one number";
                    }
                    return null;
                  },
                  onChanged: (p0) => setState(() {}),
                  keyboardType: TextInputType.visiblePassword,
                ),
                const YMargin(30),
                CustomButton(
                  text: "Continue",
                  function: () {
                    FocusScope.of(context).unfocus();
                    register();
                  },
                  loading: state.loading,
                  disabled: formKey.currentState != null && !formKey.currentState!.validate(),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
