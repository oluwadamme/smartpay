import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartpay/src/components/splash_screen.dart';
import 'package:smartpay/src/features/auth/data/controller/auth_controller.dart';
import 'package:smartpay/src/utils/routes.dart';
import 'package:smartpay/src/utils/service_locator.dart';
import 'package:smartpay/src/utils/theme_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  serviceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'Smartpay',
        theme: ThemeConfig.lightTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.routeName,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
