import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/app/app_manager.dart';
import 'package:flutter_ursffiver/core/theme/app_theme.dart';
import 'package:flutter_ursffiver/core/di/external_service_di.dart';
import 'package:flutter_ursffiver/core/di/internal_service_di.dart';
import 'package:flutter_ursffiver/features/auth/presentation/screens/splash_screen.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  externalServiceDI();
  initServices();
  Intl.defaultLocale = 'en_US';
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AppManager appManager;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appManager = Get.put(AppManager());

  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      themeMode: ThemeMode.light,
      title: 'Flutter Demo',
      home: SplashScreen(),
      // initialRoute: RouteNames.splash,
      // routes: AppRoutes.routes,
    );
  }
}
