import 'dart:async';
import 'package:flutter/material.dart';
// import your designed SpeetScreen:
import 'speet_screen.dart'; // <-- update the path if needed

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      // Use a stateful view as `home:` so it has a Navigator above it
      home: const _SplashView(),
    );
  }
}

class _SplashView extends StatefulWidget {
  const _SplashView({super.key});

  @override
  State<_SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<_SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const SpeetScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const FramedPanel(); // your splash UI
  }
}

class FramedPanel extends StatelessWidget {
  const FramedPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AspectRatio(
          aspectRatio: 284 / 527,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              // add splash artwork here
            ),
          ),
        ),
      ),
    );
  }
}

