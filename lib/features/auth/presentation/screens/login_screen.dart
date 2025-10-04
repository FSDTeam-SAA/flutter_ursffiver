import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart'; // 👈 add this
import 'package:flutter_ursffiver/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:flutter_ursffiver/features/auth/presentation/screens/verify_screen.dart';
import 'package:flutter_ursffiver/features/common/app_logo.dart';
import 'package:flutter_ursffiver/features/nabber_screen.dart';
import '../../../home/presentation/screen/home_screen.dart';
import 'signup_screen.dart'; // 👈 your path

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  static const _brandBlue = Color(0xFF4C5CFF);
  static const _brandGradient = LinearGradient(
    colors: [Color(0xFF4C5CFF), Color(0xFF8F79FF)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static const _borderColor = Color(0xFFE6E6E9);

  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  bool _showPassword = false;
  bool _keepSignedIn = true;
  bool _showPasswordError = false; // toggle to show the red error like the mock

  InputDecoration _fieldDecoration(String hint) => InputDecoration(
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
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.red),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.red),
    ),
    errorStyle: const TextStyle(color: Colors.red),
  );

  TextStyle get _label =>
      const TextStyle(fontSize: 13, fontWeight: FontWeight.w700);

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    // Demo validation to match the mock's error state.
    // Replace with your auth logic.
    // final valid = _formKey.currentState?.validate() ?? false;
    // if (!valid || _password.text.isEmpty) {
    //   setState(() => _showPasswordError = true);
    //   return;
    // }else{
    // Navigate to HomeScreen
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const BottomNavExample()));
    // }
  }

  @override
  Widget build(BuildContext context) {
    final caption = Theme.of(
      context,
    ).textTheme.bodySmall?.copyWith(color: Colors.black54, height: 1.4);

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
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Sign In to ',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      // const _GradientText(
                      //   'SPEET',
                      //   gradient: _brandGradient,
                      //   size: 22,
                      //   weight: FontWeight.w900,
                      // ),
                      const AppLogo(height: 70,width: 50),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Center(
                    child: Text(
                      'Yours truly local',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Spontaneously and on the spot, transform digital\n'
                    'connections into real-life meetups with nearby\n'
                    'people who share your interests – all within\n'
                    'minutes.',
                    style: caption,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

                  // Email
                  Text('Email Address', style: _label),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: _fieldDecoration('Email address'),
                    validator: (v) => (v == null || v.isEmpty)
                        ? 'Please Enter Your Correct Name'
                        : null,
                  ),
                  const SizedBox(height: 14),

                  // Password label + forgot
                  Row(
                    children: [
                      Text('Password', style: _label),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const ResetPasswordScreen(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: _brandBlue,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // Password field
                  TextFormField(
                    controller: _password,
                    obscureText: !_showPassword,
                    decoration: _fieldDecoration('Password').copyWith(
                      suffixIcon: IconButton(
                        icon: Icon(
                          _showPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () =>
                            setState(() => _showPassword = !_showPassword),
                      ),
                    ),
                    validator: (_) => _showPasswordError
                        ? 'Please Enter Correct Password'
                        : null,
                  ),
                  if (_showPasswordError)
                    const Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Text(
                        'Please Enter Correct Password',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  const SizedBox(height: 12),

                  // Keep me signed in
                 Row(
                    children: [
                      Checkbox(
                        value: _keepSignedIn,
                        onChanged: (v) => setState(() => _keepSignedIn = v!),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        activeColor: _brandBlue,
                        side: const BorderSide(color: _borderColor),
                      ),
                      const SizedBox(width: 4),
                      const Text('Keep me signed in'),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Log In button
                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _brandBlue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _submit,
                      child: const Text(
                        'Log In',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Center(
                    child: Text.rich(
                      TextSpan(
                        text: "Don't have an Account? ",
                        style: Theme.of(context).textTheme.bodySmall,
                        children: [
                          TextSpan(
                            text: 'Sign up',
                            style: const TextStyle(
                              color: _brandBlue, // use your token
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => SignupScreen(),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Terms
                  Center(
                    child: Text.rich(
                      TextSpan(
                        text: 'By continuing, you agree to SPEET’s ',
                        style: caption,
                        children: const [
                          TextSpan(
                            text: 'Terms of Service',
                            style: TextStyle(
                              color: _brandBlue,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              color: _brandBlue,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(text: '.'),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/* ---- helpers ---- */

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
        style: TextStyle(
          fontSize: size,
          fontWeight: weight,
          letterSpacing: 1.1,
        ),
      ),
    );
  }
}
