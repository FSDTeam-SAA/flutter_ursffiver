import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/app/app_manager.dart';
import 'package:flutter_ursffiver/core/constants/route_names.dart';
import 'package:flutter_ursffiver/core/theme/app_theme.dart';
import 'package:flutter_ursffiver/core/di/controller_dependency_injection.dart';
import 'package:flutter_ursffiver/core/di/external_service_di.dart';
import 'package:flutter_ursffiver/core/di/interface_dependency_injection.dart';
import 'package:get/get.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initControllers();
  externalServiceDI();
  initInterfaces();
  Get.put(AppManager());
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
    appManager = AppManager();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      themeMode: ThemeMode.light,
      title: 'Flutter Demo',
      //home: HomeScreen(),
      initialRoute: RouteNames.splash,
      routes: AppRoutes.routes,
    );
  }
}
