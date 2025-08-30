import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  static const _brandBlue = Color(0xFF4C5CFF);
  static const _brandGradient = LinearGradient(
    colors: [Color(0xFF4C5CFF), Color(0xFF8F79FF)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

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

  String get _otp => _controllers.map((c) => c.text).join();

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
                const _LogoMark(),
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
                  // exact wording from the mock
                  'We have share a code of your registered email\n'
                      'address rob*******@example.com',
                  style: caption,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 22),

                // OTP boxes
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
                      // TODO: verify OTP (_otp)
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

/* ---------- Small branded logo used at the top ---------- */

class _LogoMark extends StatelessWidget {
  const _LogoMark();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _GradientText('SPEET',
            gradient: _VerifyScreenState._brandGradient, size: 18),
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
    const grad = _VerifyScreenState._brandGradient;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        _GradientMask(gradient: grad, child: _ArrowIcon(left: true, size: 16)),
        SizedBox(width: 8),
        _GradientMask(gradient: grad, child: _Pill(width: 34, height: 7)),
        SizedBox(width: 8),
        _GradientMask(gradient: grad, child: _ArrowIcon(left: false, size: 16)),
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
        gradient: _VerifyScreenState._brandGradient,
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
