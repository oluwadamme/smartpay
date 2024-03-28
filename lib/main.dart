import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smartpay/src/components/splash_screen.dart';
import 'package:smartpay/src/features/auth/data/controller/auth_controller.dart';
import 'package:smartpay/src/features/dashboard/data/controllers/dash_controller.dart';
import 'package:smartpay/src/features/auth/data/repository/auth_repository.dart';
import 'package:smartpay/src/features/dashboard/data/repository/dash_repository.dart';
import 'package:smartpay/src/utils/routes.dart';
import 'package:smartpay/src/utils/theme_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _authRepository = AuthRepository();
  final _dashRepository = DashboardRepository();
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthProvider(_authRepository)),
        BlocProvider(create: (context) => DashboardProvider(_dashRepository)),
      ],
      child: MaterialApp(
        title: 'Smartpay',
        theme: ThemeConfig.lightTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.routeName,
        onGenerateRoute: AppRouter.generateRoute,
        navigatorKey: navigatorKey,
      ),
    );
  }
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
