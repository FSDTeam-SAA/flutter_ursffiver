import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ursffiver/core/common/reactive_buttons/save_button.dart';
import 'package:flutter_ursffiver/core/constants/route_names.dart';
import 'package:flutter_ursffiver/core/notifiers/snackbar_notifier.dart';
import 'package:flutter_ursffiver/features/auth/controller/verify_account_view_controller.dart';
import 'package:flutter_ursffiver/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:flutter_ursffiver/features/auth/presentation/screens/forget_password_screen.dart';
import 'package:flutter_ursffiver/features/common/app_logo.dart';

class VerifyScreen extends StatefulWidget {
  final String email;
  const VerifyScreen({super.key, required this.email});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  late final VerifyForgetPasswordOtpController controller;
  static const _brandBlue = Color(0xFF4C5CFF);
  final _nodes = List.generate(
    6,
    (_) => FocusNode(debugLabel: 'otp-node'),
    growable: false,
  );
  final _controllers = List.generate(
    6,
    (_) => TextEditingController(),
    growable: false,
  );

  @override
  void initState() {
    super.initState();
    controller = VerifyForgetPasswordOtpController(
      email: widget.email,
      snackbarNotifier: SnackbarNotifier(context: context),
    );
  }

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
    //full typed otp String
    final String otp = _controllers.map((e) => e.text).join();

    controller.otp = otp;
    
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 4),

                // Brand mark
                // const _LogoMark(),
                const AppLogo(height: 24, width: 52),

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
                            textInputAction: i == 5
                                ? TextInputAction.done
                                : TextInputAction.next,
                            maxLength: 1,
                            obscureText: true,
                            obscuringCharacter: '*',
                            decoration: InputDecoration(
                              counterText: '',
                              filled: false,
                              contentPadding: EdgeInsets.zero,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: _brandBlue,
                                  width: 1.6,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: _brandBlue,
                                  width: 1.6,
                                ),
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

                SizedBox(
                  height: 50,
                  child: RSaveButton(
                    key: UniqueKey(),
                    width: double.infinity,
                    height: 54,
                    buttonStatusNotifier: controller.prcessNotifier,
                    saveText: "Verify",
                    loadingText: "Verifying...",
                    doneText: "Done",
                    onDone: () {
                      
                    },
                    onSaveTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResetPasswordScreen(email: controller.email, otp: controller.otp),
                        ),
                      );
                    },
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
