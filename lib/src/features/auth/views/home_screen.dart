import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartpay/src/features/auth/data/controller/auth_controller.dart';
import 'package:smartpay/src/features/auth/data/controller/auth_state.dart';
import 'package:smartpay/src/features/auth/data/controller/dash_controller.dart';
import 'package:smartpay/src/utils/app_color.dart';
import 'package:smartpay/src/utils/spacing_util.dart';
import 'package:smartpay/src/utils/text_util.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = "/home_screen";
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    fetchDashText();
  }

  void fetchDashText() {
    if (BlocProvider.of<AuthProvider>(context).loginResponse != null) {
      final token = BlocProvider.of<AuthProvider>(context).loginResponse!.token ?? "";
      BlocProvider.of<DashboardProvider>(context).dashboard(token);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: RefreshIndicator(
          onRefresh: () async => fetchDashText(),
          child: ListView(
            children: [
              const Center(child: Text("Pull to refresh the secret")),
              const YMargin(30),
              BlocConsumer<DashboardProvider, AuthState>(
                builder: (context, state) {
                  if (state.loading) {
                    return const Center(child: SizedBox(height: 100, width: 100, child: CircularProgressIndicator()));
                  }
                  if (state.error != null) {
                    return Center(child: SizedBox(height: 100, width: 100, child: Text(state.error!)));
                  }
                  if (state.data == null) {
                    return const Center(child: SizedBox(height: 100, width: 100, child: CircularProgressIndicator()));
                  }
                  return Center(
                    child: SizedBox(
                      width: screenWidth(context, percent: 0.8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedTextKit(
                            animatedTexts: [
                              TypewriterAnimatedText(state.data, textStyle: boldStyle(24, AppColors.primary400))
                            ],
                            totalRepeatCount: 4,
                            pause: const Duration(milliseconds: 1000),
                            displayFullTextOnTap: true,
                            stopPauseOnTap: true,
                          ),
                          const YMargin(30),
                        ],
                      ),
                    ),
                  );
                },
                listener: (context, state) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
