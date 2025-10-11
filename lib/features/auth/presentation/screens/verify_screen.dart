import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ursffiver/features/auth/presentation/screens/reset_screen.dart';
import 'package:flutter_ursffiver/features/common/app_logo.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  static const _brandBlue = Color(0xFF4C5CFF);
  final _nodes =
  List.generate(6, (_) => FocusNode(debugLabel: 'otp-node'), growable: false);
  final _controllers =
  List.generate(6, (_) => TextEditingController(), growable: false);

  @override
  void dispose() {
    for (final n in _nodes) n.dispose();
    for (final c in _controllers) c.dispose();
    super.dispose();
  }

  void _onChanged(int index, String value) {
    // Allow only one digit
    if (value.length > 1) {
      _controllers[index].text = value.characters.last;
      _controllers[index].selection = TextSelection.collapsed(offset: 1);
    }
    if (value.isNotEmpty && index < _nodes.length - 1) {
      _nodes[index + 1].requestFocus();
    }
    setState(() {});
  }

  void _onBackspace(int index, RawKeyEvent e) {
    if (e is RawKeyDownEvent &&
        e.logicalKey == LogicalKeyboardKey.backspace &&
        _controllers[index].text.isEmpty &&
        index > 0) {
      _nodes[index - 1].requestFocus();
    }
  }

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

                // Title + subtitle
                const Center(
                  child: Text(
                    'Enter OTP',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'We have share a code of your registered email\n'
                      'address rob*******@example.com',
                  style: caption,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 22),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(6, (i) {
                    return Padding(
                      padding: EdgeInsets.only(right: i == 5 ? 0 : 12),
                      child: SizedBox(
                        width: 46,
                        height: 46,
                        child: RawKeyboardListener(
                          focusNode: FocusNode(skipTraversal: true),
                          onKey: (e) => _onBackspace(i, e),
                          child: TextField(
                            controller: _controllers[i],
                            focusNode: _nodes[i],
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            textInputAction:
                            i == 5 ? TextInputAction.done : TextInputAction.next,
                            maxLength: 1,
                            obscureText: true,
                            obscuringCharacter: '*',
                            decoration: InputDecoration(
                              counterText: '',
                              filled: false,
                              contentPadding: EdgeInsets.zero,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                const BorderSide(color: _brandBlue, width: 1.6),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                const BorderSide(color: _brandBlue, width: 1.6),
                              ),
                            ),
                            onChanged: (v) => _onChanged(i, v),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 10),

                // Resend
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: "Don't get a code? ",
                      style: caption,
                      children: const [
                        TextSpan(
                          text: 'Resend',
                          style: TextStyle(
                            color: _brandBlue,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const Spacer(),

                // Verify button
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
                          builder: (_) => const ResetScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Verify',
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