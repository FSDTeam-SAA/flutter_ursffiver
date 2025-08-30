import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/theme/app_theme.dart';
import 'package:flutter_ursffiver/features/nabber_screen.dart';

import 'features/auth/presentation/screens/after_interest_selected_screen.dart';
import 'features/auth/presentation/screens/interest_screen.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/auth/presentation/screens/onboarding_screen.dart';
import 'features/auth/presentation/screens/reset_password_screen.dart';
import 'features/auth/presentation/screens/reset_screen.dart';
import 'features/auth/presentation/screens/signup_screen.dart';
import 'features/auth/presentation/screens/speet_screen.dart';
import 'features/auth/presentation/screens/splash_screen.dart';
import 'features/auth/presentation/screens/verify_screen.dart';

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
      // home: BottomNavExample(),
      // home: SplashScreen(),
      // home: SpeetScreen(),
      // home: OnBoardingScreen(),
      // home: SignupScreen(),
      // home: SignInScreen(),
      // home: ResetPasswordScreen(),
      // home: VerifyScreen(),
      // home: ResetScreen(),
      home: InterestScreen(),
      // home: AfterInterestSelectedScreen(),
    );
  }
}
  