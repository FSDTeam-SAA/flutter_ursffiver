import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ursffiver/core/common/widget/reactive_button/r_icon.dart';
import 'package:flutter_ursffiver/features/auth/controller/signup_controller.dart';
import 'package:flutter_ursffiver/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter_ursffiver/features/auth/presentation/screens/verify_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_ursffiver/core/notifiers/snackbar_notifier.dart';
import 'package:flutter_ursffiver/core/common/sheets/interest_picker_sheet.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import '../../../common/app_logo.dart';

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

  // REMOVED: Set<String> _selectedInterests = <String>{};

  late final SignUpController signupController;

  @override
  void initState() {
    super.initState();
    signupController = SignUpController();
  }

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

  Future<Set<String>?> _openInterestPicker(BuildContext context) {
    return showModalBottomSheet<Set<String>>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) => InterestPickerSheet.forSignUp(
        interestSelectionCntlr: signupController.interestSelectionCntlr,
        brandGradient: _brandGradient,
        onConfirm: () => Navigator.pop(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final caption = Theme.of(
      context,
    ).textTheme.bodySmall?.copyWith(color: Colors.black54);

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
                  AppLogo(height: 110, width: 80),
                  const SizedBox(height: 8),
                  const Text(
                    "Create your account",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Transform digital connections into real-life meetups with nearby people who share your interests.",
                    textAlign: TextAlign.center,
                    style: caption,
                  ),
                  const SizedBox(height: 20),

                  // === INTEREST PICKER ===
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
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
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
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Text(
                                "Select interests to find people who share your passions",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),

                            // TRIGGER (tap to open bottom sheet)
                            InkWell(
                              borderRadius: BorderRadius.circular(4),
                              onTap: () async {
                                // No setState – sheet updates controller directly
                                await _openInterestPicker(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.white,
                                ),
                                height: 48,
                                width: double.infinity,
                                child: const Center(
                                  child: Text(
                                    "Click to select your interests",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // LIVE COUNTER – uses controller's selectedCount
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                ),
                                child: Obx(() {
                                  final cnt =
                                      signupController.selectedCount.value;
                                  return RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      text: "Selected: ",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: "$cnt/15",
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        if (cnt == 0) ...[
                                          const WidgetSpan(
                                            child: SizedBox(width: 40),
                                          ),
                                          const TextSpan(
                                            text: "Please select at least 1",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ],
                                      ],
                                    ),
                                  );
                                }),
                              ),
                            ),

                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Text(
                                "Your interests help us connect you with like-minded people nearby",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // === INPUT FIELDS ===
                  Row(
                    children: [
                      Expanded(
                        child: _Labeled(
                          label: 'First Name',
                          child: TextFormField(
                            controller: _firstName,
                            onChanged: signupController.setFirstName,
                            decoration: _decoration('Name Here'),
                            validator: (v) => (v == null || v.trim().isEmpty)
                                ? 'Required'
                                : null,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _Labeled(
                          label: 'Last Name',
                          child: TextFormField(
                            controller: _lastName,
                            onChanged: signupController.setLastName,
                            decoration: _decoration('Name Here'),
                            validator: (v) => (v == null || v.trim().isEmpty)
                                ? 'Required'
                                : null,
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
                      onChanged: signupController.setUsername,
                      decoration: _decoration('User Name Here'),
                      validator: (v) =>
                          (v == null || v.trim().isEmpty) ? 'Required' : null,
                    ),
                  ),
                  const SizedBox(height: 12),

                  _Labeled(
                    label: 'Email Address',
                    child: TextFormField(
                      controller: _email,
                      onChanged: signupController.setEmail,
                      keyboardType: TextInputType.emailAddress,
                      decoration: _decoration('hello@example.com'),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return 'Required';
                        final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                        if (!emailRegex.hasMatch(v.trim()))
                          return 'Invalid email';
                        return null;
                      },
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
                          final formatted =
                              "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                          _dob.text = formatted;
                          signupController.setDateOfBirth(formatted);
                        }
                      },
                      validator: (v) =>
                          (v == null || v.trim().isEmpty) ? 'Required' : null,
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
                            onChanged: (v) {
                              setState(() => _gender = v);
                              signupController.setGender(v ?? '');
                            },
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
                            onChanged: (v) {
                              setState(() => _ageRange = v);
                              signupController.setAgeRange(v ?? '');
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  _Labeled(
                    label: 'Bio (Optional)',
                    labelTrailing: Obx(
                      () => Text(
                        '${signupController.bio.value.length}/500',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    child: TextFormField(
                      controller: _bio,
                      maxLines: 4,
                      onChanged: signupController.setBio,
                      decoration: _decoration('Write something about yourself'),
                    ),
                  ),
                  const SizedBox(height: 20),

                  _Labeled(
                    label: 'Create Password',
                    child: TextFormField(
                      controller: _password,
                      obscureText: !_showPassword,
                      onChanged: signupController.setPassword,
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
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Required';
                        if (!_hasMinLength(v)) return 'Minimum 8 characters';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 8),

                  Obx(
                    () => RulesBox(
                      checks: {
                        'Minimum 8 characters': _hasMinLength(_password.text),
                        'At least 1 uppercase letter': _hasUppercase(
                          signupController.password.value,
                        ),
                        'At least 1 lowercase letter': _hasLowercase(
                          signupController.password.value,
                        ),
                        'At least 1 number': _hasNumber(_password.text),
                        'At least 1 special character': _hasSpecial(
                          signupController.password.value,
                        ),
                      },
                    ),
                  ),
                  const SizedBox(height: 12),

                  _Labeled(
                    label: 'Confirm Password',
                    child: TextFormField(
                      controller: _confirmPassword,
                      obscureText: !_showConfirm,
                      onChanged: signupController.setConfirmPassword,
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
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Required';
                        if (v != _password.text)
                          return 'Passwords do not match';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4C5CFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          signupController.signup(
                            buttonNotifier: signupController.processNotifier,
                            snackbarNotifier: SnackbarNotifier(
                              context: context,
                            ),
                            onDone: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => VerifyScreen(
                                  email: _email.text,
                                  isFromRegisterScreen: true,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 4,
                        children: [
                          const Text(
                            'Create Account',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          RIcon(
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            key: UniqueKey(),
                            processStatusNotifier:
                                signupController.processNotifier,
                            iconWidget: Container(),
                            loadingStateWidget: const FittedBox(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  Text.rich(
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
                            ..onTap = () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => SignInScreen()),
                            ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
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

/* ---------- Helpers (unchanged) ---------- */

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
