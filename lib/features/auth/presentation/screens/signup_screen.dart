import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import '../../../common/app_logo.dart';
import 'interest_screen.dart';
import 'login_screen.dart'; // update path/name

import 'onboarding_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreen();
}

class _SignupScreen extends State<SignupScreen> {
  // Brand
  static const _brandGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFF4C5CFF), Color(0xFF8F79FF)],
  );
  static const _borderColor = Color(0xFFE6E6E9);

  // === Password rule checks ===
  bool _hasMinLength(String v) => v.length >= 8;
  bool _hasUppercase(String v) => RegExp(r'[A-Z]').hasMatch(v);
  bool _hasLowercase(String v) => RegExp(r'[a-z]').hasMatch(v);
  bool _hasNumber(String v) => RegExp(r'\d').hasMatch(v);
  // raw string: no need to escape $
  bool _hasSpecial(String v) => RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(v);

  final _formKey = GlobalKey<FormState>();

  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _userName = TextEditingController();
  final _email = TextEditingController();
  final _dob = TextEditingController();
  final _bio = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  bool _showPassword = false;
  bool _showConfirm = false;

  String? _gender;
  String? _ageRange;

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _userName.dispose();
    _email.dispose();
    _dob.dispose();
    _bio.dispose();
    _password.dispose();
    _confirmPassword.dispose();
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

  TextStyle get _labelStyle =>
      const TextStyle(fontSize: 13, fontWeight: FontWeight.w700);

  @override
  void initState() {
    super.initState();
    _password.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final caption = Theme.of(
      context,
    ).textTheme.bodySmall?.copyWith(color: Colors.black54, height: 1.35);

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
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Brand
                  // const _GradientText('SPEET', gradient: _brandGradient, size: 18, weight: FontWeight.w900),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Create a  ',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const AppLogo(height: 110, width: 80),
                    ],
                  ),

                  Text("Yours truly Local", style: TextStyle(fontSize: 16)),

                  // const SizedBox(height: 10),

                  // Title + subtitle
                  const SizedBox(height: 6),
                  Text(
                    "Spontaneously and on the spot, transform digital connections into real-life meetups with nearby people who share your interests - all within minutes.",
                    style: caption,
                    textAlign: TextAlign.center,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.grey[200],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "What interests you ?",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Container(
                                  width: 80,
                                  height: 7,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Colors.deepPurpleAccent,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Text(
                                "Select interest to find people who share your passions",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.white,
                              ),
                              height: 48,
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  "Click to select you interests",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: RichText(
                                text: TextSpan(
                                  text: "Selected: ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                  children: [
                                    TextSpan(text: "0/15 interests  "),
                                    TextSpan(
                                      text: "Please Select at least 1 ",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Text(
                                "You interest help us connect you with like minded people nearby",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // First/Last
                  Row(
                    children: [
                      Expanded(
                        child: _Labeled(
                          label: 'First Name',
                          child: TextFormField(
                            controller: _firstName,
                            textInputAction: TextInputAction.next,
                            decoration: _decoration('Name Here'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _Labeled(
                          label: 'Last Name',
                          child: TextFormField(
                            controller: _lastName,
                            textInputAction: TextInputAction.next,
                            decoration: _decoration('Name Here'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  _Labeled(
                    label: 'User Name',
                    child: TextFormField(
                      controller: _userName,
                      textInputAction: TextInputAction.next,
                      decoration: _decoration('User Name Here'),
                    ),
                  ),
                  const SizedBox(height: 12),

                  _Labeled(
                    label: 'Email Address',
                    child: TextFormField(
                      controller: _email,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      decoration: _decoration('hello@example.com'),
                    ),
                  ),
                  const SizedBox(height: 12),

                  _Labeled(
                    label: 'Date of Birth',
                    child: TextFormField(
                      controller: _dob,
                      readOnly: true,
                      decoration: _decoration(
                        'DD/MM/YY',
                      ).copyWith(suffixIcon: const Icon(Icons.event_outlined)),
                      onTap: () async {
                        final now = DateTime.now();
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime(
                            now.year - 18,
                            now.month,
                            now.day,
                          ),
                          firstDate: DateTime(1900),
                          lastDate: now,
                        );
                        if (picked != null) {
                          _dob.text =
                              '${picked.day.toString().padLeft(2, '0')}/'
                              '${picked.month.toString().padLeft(2, '0')}/'
                              '${picked.year.toString().substring(2)}';
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Privacy note card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF2F2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFFFD4D4)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 2),
                          child: Icon(
                            Icons.warning,
                            color: Colors.red,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Privacy Protected Information\n"
                            "Your birth date is only required for Apple and Google app store compliance to verify you’re 18+. "
                            "This information is never visible to other users, not used for marketing or recommendations, "
                            "and not shared with any third parties. It remains completely private and secure.",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Gender + Age Range
                  Row(
                    children: [
                      Expanded(
                        child: _Labeled(
                          label: 'Gender',
                          child: _Dropdown<String>(
                            value: _gender,
                            hint: 'Select',
                            items: const [
                              'Male',
                              'Female',
                              'Non-binary',
                              'Prefer not to say',
                            ],
                            onChanged: (v) => setState(() => _gender = v),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _Labeled(
                          label: 'Age Range',
                          child: _Dropdown<String>(
                            value: _ageRange,
                            hint: 'Select',
                            items: const [
                              '18–24',
                              '25–34',
                              '35–44',
                              '45–54',
                              '55+',
                            ],
                            onChanged: (v) => setState(() => _ageRange = v),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Bio
                  _Labeled(
                    label: 'Bio (Optional)',
                    labelTrailing: ValueListenableBuilder<TextEditingValue>(
                      valueListenable: _bio,
                      builder: (_, v, __) => Text(
                        '${v.text.length}/500',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    child: SizedBox(
                      height: 150,
                      child: _BioSection(controller: _bio), // share controller
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Your bio will be visible to nearby users as a preview of who you are.',
                    style: caption,
                  ),
                  const SizedBox(height: 16),

                  // Create Password
                  Align(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Create Password',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _password,
                    obscureText: !_showPassword,
                    decoration: _decoration('Password').copyWith(
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
                  ),
                  const SizedBox(height: 8),

                  _RulesBox(
                    checks: {
                      'Minimum 8 characters': _hasMinLength(_password.text),
                      'At least 1 uppercase letter': _hasUppercase(
                        _password.text,
                      ),
                      'At least 1 lowercase letter': _hasLowercase(
                        _password.text,
                      ),
                      'At least 1 number': _hasNumber(_password.text),
                      'At least 1 special character (e.g., !@#\$%)':
                          _hasSpecial(_password.text),
                    },
                  ),
                  const SizedBox(height: 12),

                  //confirm passowrd
                  Align(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Confirm Password',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _confirmPassword,
                    obscureText: !_showConfirm,
                    decoration: _decoration('Confirm Password').copyWith(
                      suffixIcon: IconButton(
                        icon: Icon(
                          _showConfirm
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () =>
                            setState(() => _showConfirm = !_showConfirm),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // CTA
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4C5CFF),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const InterestScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Create Account',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  Center(
                    child: Text.rich(
                      TextSpan(
                        text: 'Already have an account? ',
                        style: caption,
                        children: [
                          TextSpan(
                            text: 'Sign in',
                            style: const TextStyle(
                              color: Color(0xFF4C5CFF),
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => const SignInScreen(),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 12),

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
                              color: Color(0xFF4C5CFF),
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              color: Color(0xFF4C5CFF),
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
                  const SizedBox(height: 18),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// --- Bio section -------------------------------------------------------------
class _BioSection extends StatefulWidget {
  const _BioSection({this.controller});
  final TextEditingController? controller;

  @override
  State<_BioSection> createState() => _BioSectionState();
}

class _BioSectionState extends State<_BioSection> {
  static const _maxChars = 500;

  late final TextEditingController _ctl =
      widget.controller ?? TextEditingController();

  @override
  void dispose() {
    if (widget.controller == null) _ctl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const baseBlack = Color(0xFF030712);
    const neutral300 = Color(0xFFC0C0C6);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title + counter (top-right)
        Row(
          children: [
            // const Spacer(),
            // ValueListenableBuilder<TextEditingValue>(
            //   valueListenable: _ctl,
            //   builder: (_, v, __) {
            //     final n = v.text.characters.length;
            //     return Text(
            //       '$n/$_maxChars',
            //       style: const TextStyle(
            //         fontFamily: 'Poppins',
            //         fontSize: 12,
            //         color: Color(0xFF6B7280),
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
        const SizedBox(height: 8),

        Expanded(
          child: TextField(
            controller: _ctl,
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            maxLength: _maxChars,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            buildCounter:
                (
                  _, {
                  required int currentLength,
                  required bool isFocused,
                  int? maxLength,
                }) => null,

            // 👇 make the content (and hint) stick to the top-left
            textAlignVertical: TextAlignVertical.top,
            expands: true,
            minLines: null,
            maxLines: null,

            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: baseBlack,
              height: 1.4,
            ),
            decoration: InputDecoration(
              hintText: 'Write something about yourself',
              hintStyle: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: Color(0xFF9CA3AF),
              ),
              isDense: true,
              // extra top padding so text doesn’t collide with the border
              contentPadding: const EdgeInsets.fromLTRB(12, 14, 12, 12),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(color: neutral300, width: 1),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(width: 1.5),
              ),
            ),
          ),
        ),

        const SizedBox(height: 8),
      ],
    );
  }
}

/* ---------- UI helpers ---------- */

class _Labeled extends StatelessWidget {
  const _Labeled({
    required this.label,
    required this.child,
    this.labelTrailing,
  });

  final String label;
  final Widget child;
  final Widget? labelTrailing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
            ),
            const Spacer(),
            if (labelTrailing != null) labelTrailing!,
          ],
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}

class _Dropdown<T> extends StatelessWidget {
  const _Dropdown({
    required this.value,
    required this.items,
    required this.onChanged,
    required this.hint,
  });

  final T? value;
  final List<String> items;
  final ValueChanged<T?> onChanged;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      isExpanded: true,
      items: items
          .map((e) => DropdownMenuItem<T>(value: e as T, child: Text(e)))
          .toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _SignupScreen._borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFBAC0FF)),
        ),
      ),
      icon: const Icon(Icons.keyboard_arrow_down_rounded),
    );
  }
}

class _RulesBox extends StatelessWidget {
  const _RulesBox({required this.checks});
  final Map<String, bool> checks;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE6E6E9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: checks.entries.map((e) {
          final text = e.key;
          final valid = e.value;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              children: [
                Icon(
                  valid ? Icons.check_circle : Icons.radio_button_unchecked,
                  size: 16,
                  color: valid ? Colors.green : Colors.black45,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: valid ? Colors.green : Colors.black87,
                      fontWeight: valid ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
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
      shaderCallback: (rect) => gradient.createShader(rect),
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
