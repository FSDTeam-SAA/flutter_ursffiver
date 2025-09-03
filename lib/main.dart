import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/theme/app_theme.dart';
import 'package:flutter_ursffiver/features/auth/presentation/screens/verify_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light,
      themeMode: ThemeMode.light,
      title: 'Flutter Demo',
      // home: SplashScreen(),
      home: VerifyScreen(),
    );
  }
}
