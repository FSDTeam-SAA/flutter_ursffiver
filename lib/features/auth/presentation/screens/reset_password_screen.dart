import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ursffiver/features/auth/presentation/screens/verify_screen.dart';
import 'package:flutter_ursffiver/features/common/app_logo.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  static const _brandBlue = Color(0xFF4C5CFF);
  static const _brandGradient = LinearGradient(
    colors: [Color(0xFF4C5CFF), Color(0xFF8F79FF)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static const _borderColor = Color(0xFFE6E6E9);

  final _email = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  InputDecoration _decoration(String hint) => InputDecoration(
    hintText: hint,
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: _borderColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFBAC0FF)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final caption = Theme.of(context)
        .textTheme
        .bodySmall
        ?.copyWith(color: Colors.black54, height: 1.4);

    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 4),
                // Brand mark
                // const _LogoMark(),
                const AppLogo(height: 24,width: 52,),
                const SizedBox(height: 14),

                // Title + subtitle (centered)
                const Center(
                  child: Text(
                    'Enter Your Email Address',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter your email or phone number to get code\n'
                      'for reset your account password.',
                  style: caption,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 22),

                // Email label + field
                const Text(
                  'Email Address',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: _decoration('hello@example.com'),
                ),

                const Spacer(),

                // CTA
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _brandBlue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      // Navigate to HomeScreen
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => const VerifyScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Send Code',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/* ---------- Small branded logo used at the top ---------- */

class _LogoMark extends StatelessWidget {
  const _LogoMark();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _GradientText('SPEET', gradient: _ResetPasswordScreenState._brandGradient, size: 18),
        SizedBox(height: 4),
        _LogoUnderline(),
      ],
    );
  }
}

class _LogoUnderline extends StatelessWidget {
  const _LogoUnderline();

  @override
  Widget build(BuildContext context) {
    const grad = _ResetPasswordScreenState._brandGradient;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        _GradientMask(
          gradient: grad,
          child: _ArrowIcon(left: true, size: 16),
        ),
        SizedBox(width: 8),
        _GradientMask(
          gradient: grad,
          child: _Pill(width: 34, height: 7),
        ),
        SizedBox(width: 8),
        _GradientMask(
          gradient: grad,
          child: _ArrowIcon(left: false, size: 16),
        ),
      ],
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.width, required this.height});
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        gradient: _ResetPasswordScreenState._brandGradient,
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
    );
  }
}

class _ArrowIcon extends StatelessWidget {
  const _ArrowIcon({required this.left, this.size = 20});
  final bool left;
  final double size;

  @override
  Widget build(BuildContext context) {
    final icon = Icon(Icons.play_arrow_rounded, size: size);
    return left ? Transform.rotate(angle: math.pi, child: icon) : icon;
  }
}

class _GradientText extends StatelessWidget {
  const _GradientText(
      this.text, {
        required this.gradient,
        this.size = 24,
        this.weight = FontWeight.w900,
      });

  final String text;
  final Gradient gradient;
  final double size;
  final FontWeight weight;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (r) => gradient.createShader(Offset.zero & r.size),
      blendMode: BlendMode.srcIn,
      child: Text(
        text,
        style: TextStyle(fontSize: size, fontWeight: weight, letterSpacing: 1.1),
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
      shaderCallback: (r) => gradient.createShader(Offset.zero & r.size),
      blendMode: BlendMode.srcIn,
      child: child,
    );
  }
}
