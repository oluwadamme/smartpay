import 'package:flutter/material.dart';
import 'package:smartpay/src/components/splash_screen.dart';
import 'package:smartpay/src/utils/routes.dart';
import 'package:smartpay/src/utils/theme_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smartpay',
      theme: ThemeConfig.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
