import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ursffiver/core/common/reactive_buttons/save_button.dart';
import 'package:flutter_ursffiver/features/auth/controller/create_new_password_controller.dart';
import 'package:flutter_ursffiver/features/common/app_logo.dart';
import 'package:get/get.dart';

class ResetScreen extends StatefulWidget {
  final String email;
  const ResetScreen({super.key, required this.email});

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  static const _borderColor = Color(0xFFE6E6E9);

  final _password = TextEditingController();
  final _confirm = TextEditingController();

  late final CreateNewPasswordController controller;

  bool _showPass = false;
  bool _showConfirm = false;

  // validation flags
  bool _lenOk = false;
  bool _upperOk = false;
  bool _lowerOk = false;
  bool _numOk = false;
  bool _specialOk = false;
  bool _matchOk = false;



  @override
  void initState() {
    super.initState();

    controller = Get.put(CreateNewPasswordController(email: widget.email));
    _password.addListener(_recompute);
    _confirm.addListener(_recompute);

  }

  @override
  void dispose() {
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  void _recompute() {
    final p = _password.text;
    setState(() {
      _lenOk = p.length >= 8;
      _upperOk = RegExp(r'[A-Z]').hasMatch(p);
      _lowerOk = RegExp(r'[a-z]').hasMatch(p);
      _numOk = RegExp(r'\d').hasMatch(p);
      _specialOk = RegExp(r'[^A-Za-z0-9]').hasMatch(p);

      _matchOk = _confirm.text.isNotEmpty && _confirm.text == p;
    });
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

  TextStyle get _label =>
      const TextStyle(fontSize: 13, fontWeight: FontWeight.w700);

  @override
  Widget build(BuildContext context) {
    final caption = Theme.of(
      context,
    ).textTheme.bodySmall?.copyWith(color: Colors.black54, height: 1.45);

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
                    'Reset Your Password',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                ),
                const SizedBox(height: 6),
                Center(
                  child: Text(
                    'Create a new password',
                    style: caption,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 22),

                // Create Password
                Text('Create Password', style: _label),
                const SizedBox(height: 8),
                TextField(
                  controller: _password,
                  obscureText: !_showPass,
                  decoration: _decoration('Password').copyWith(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _showPass ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () => setState(() => _showPass = !_showPass),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Rules (live)
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Rule('Minimum 8 characters', ok: _lenOk),
                      _Rule('At least 1 uppercase letter', ok: _upperOk),
                      _Rule('At least 1 lowercase letter', ok: _lowerOk),
                      _Rule('At least 1 number', ok: _numOk),
                      _Rule(
                        'At least 1 special character (e.g. !@#\$%)',
                        ok: _specialOk,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),

                // Confirm Password
                Text('Confirm Password', style: _label),
                const SizedBox(height: 8),
                TextField(
                  controller: _confirm,
                  obscureText: !_showConfirm,
                  decoration: _decoration('Confirm Password').copyWith(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _showConfirm ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () =>
                          setState(() => _showConfirm = !_showConfirm),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                if (!_matchOk && _confirm.text.isNotEmpty)
                  const Padding(
                    padding: EdgeInsets.only(left: 6, top: 2),
                    child: Text(
                      'Passwords do not match',
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),

                const Spacer(),

                // CTA
                SizedBox(
                  height: 50,
                  child: RSaveButton(
                    key: UniqueKey(),
                    buttonStatusNotifier: controller.processNotifier,
                    saveText: "Update Password",
                    loadingText: "Updating...",
                    doneText: "Done",
                    onSaveTap: () {},
                    onDone: () {},
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

class _Rule extends StatelessWidget {
  const _Rule(this.text, {required this.ok});
  final String text;
  final bool ok;

  @override
  Widget build(BuildContext context) {
    final color = ok ? const Color(0xFF10B981) : Colors.black54;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            ok ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 16,
            color: color,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: color, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
