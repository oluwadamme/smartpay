
import 'package:flutter/material.dart';
import 'package:smartpay/src/components/custom_button.dart';
import 'package:smartpay/src/features/auth/views/login_screen.dart';
import 'package:smartpay/src/features/onboarding/widgets/onboard_one.dart';
import 'package:smartpay/src/features/onboarding/widgets/onboard_two.dart';
import 'package:smartpay/src/features/onboarding/widgets/onboarding_text.dart';
import 'package:smartpay/src/utils/app_color.dart';
import 'package:smartpay/src/utils/spacing_util.dart';
import 'package:smartpay/src/utils/text_util.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  static const String routeName = "/onbooarding";
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();
  final currentIndex = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: currentIndex,
            builder: (context, value, child) {
              return SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, LoginScreen.routeName);
                          },
                          child: Text(
                            "Skip",
                            style: boldStyle(16, AppColors.primary400),
                          ),
                        )
                      ],
                    ),
                    const YMargin(70),
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        SizedBox(
                          height: screenHeight(context),
                          child: PageView(
                            controller: controller,
                            onPageChanged: (value) => currentIndex.value = value,
                            children: const [OnboardOne(), OnboardTwo()],
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          width: double.maxFinite,
                          height: screenHeight(context, percent: 0.56),
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              AnimatedCrossFade(
                                firstChild: const OnboardingText(
                                  title: "Finance app the safest \nand most trusted",
                                  subtitle:
                                      "Your finance work starts here. Our here to help you track and deal with speeding up your transactions.",
                                ),
                                secondChild: const OnboardingText(
                                  title: "The fastest transaction \nprocess only here",
                                  subtitle:
                                      "Get easy to pay all your bills with just a few steps. Paying your bills become fast and efficient.",
                                ),
                                crossFadeState:
                                    currentIndex.value == 0 ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                                duration: const Duration(milliseconds: 500),
                              ),
                              const YMargin(20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ...List.generate(
                                    2,
                                    (index) => AnimatedContainer(
                                      margin: const EdgeInsets.only(right: 5),
                                      duration: const Duration(milliseconds: 500),
                                      width: currentIndex.value == index ? 32 : 6,
                                      height: 6,
                                      decoration: BoxDecoration(
                                          color: currentIndex.value == index ? AppColors.grey900 : AppColors.grey200,
                                          borderRadius: BorderRadius.circular(30)),
                                    ),
                                  )
                                ],
                              ),
                              const YMargin(40),
                              CustomButton(
                                text: "Get Started",
                                function: () {
                                  Navigator.pushNamed(context, LoginScreen.routeName);
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
