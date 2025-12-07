// speet_screen.dart
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'onboarding_screen.dart';

class SpeetScreen extends StatefulWidget {
  const SpeetScreen({super.key});

  static const brandGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFF4C5CFF), Color(0xFF8F79FF)],
  );

  @override
  State<SpeetScreen> createState() => _SpeetScreenState();
}

class _SpeetScreenState extends State<SpeetScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => OnBoardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: const SafeArea(
          child: Center(child: _LogoGroup()),
        ),
      ),
    );
  }
}

class _LogoGroup extends StatelessWidget {
  const _LogoGroup();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const _GradientMask(
          gradient: SpeetScreen.brandGradient,
          child: Text(
            'SPEET',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 56,
              fontWeight: FontWeight.w900,
              letterSpacing: 4,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            _GradientMask(
              gradient: SpeetScreen.brandGradient,
              child: _ArrowIcon(left: true),
            ),
            SizedBox(width: 12),
            _Pill(),
            SizedBox(width: 12),
            _GradientMask(
              gradient: SpeetScreen.brandGradient,
              child: _ArrowIcon(left: false),
            ),
          ],
        ),
      ],
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 177.3,
      height: 25,
      decoration: const BoxDecoration(
        gradient: SpeetScreen.brandGradient,
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
    );
  }
}

class _GradientMask extends StatelessWidget {
  const _GradientMask({required this.gradient, required this.child});
  final Gradient gradient;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (b) =>
          gradient.createShader(Rect.fromLTWH(0, 0, b.width, b.height)),
      blendMode: BlendMode.srcIn,
      child: child,
    );
  }
}

class _ArrowIcon extends StatelessWidget {
  const _ArrowIcon({required this.left});
  final bool left;

  @override
  Widget build(BuildContext context) {
    const icon = Icon(Icons.play_arrow_rounded, size: 28);
    return left ? Transform.rotate(angle: math.pi, child: icon) : icon;
  }
}
