import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_ursffiver/core/theme/app_gap.dart';
import '../../../common/app_logo.dart';
import 'interest_screen.dart';
import 'login_screen.dart';

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

  // === NEW: keep the currently selected interests for the counter outside the sheet
  Set<String> _selectedInterests = <String>{};

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

  // === NEW: launcher for the bottom sheet
  Future<Set<String>?> _openInterestPicker(BuildContext context) {
    return showModalBottomSheet<Set<String>>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _InterestPickerSheet(
        initialSelection: _selectedInterests,
        brandGradient: _brandGradient,
      ),
    );
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Create a  ',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      AppLogo(height: 110, width: 80),
                    ],
                  ),

                  const Text(
                    "Yours truly Local",
                    style: TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 6),
                  Text(
                    "Spontaneously and on the spot, transform digital connections into real-life meetups with nearby people who share your interests - all within minutes.",
                    style: caption,
                    textAlign: TextAlign.center,
                  ),

                  // === INTEREST PICKER CARD (unchanged visual; now clickable)
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
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),

                            // === TRIGGER (tap to open bottom sheet)
                            InkWell(
                              borderRadius: BorderRadius.circular(4),
                              onTap: () async {
                                final result = await _openInterestPicker(
                                  context,
                                );
                                if (result != null) {
                                  setState(() {
                                    _selectedInterests = result;
                                  });
                                }
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
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: RichText(
                                text: TextSpan(
                                  text: "Selected: ",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "${_selectedInterests.length}/15",
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    const WidgetSpan(
                                      child: SizedBox(width: 80),
                                    ),
                                    if (_selectedInterests.isEmpty)
                                      const TextSpan(
                                        text: "Please select at least 1",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                  ],
                                ),
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
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
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

                  // Confirm password
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
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

// --- Interest Picker Bottom Sheet -------------------------------------------

class _InterestPickerSheet extends StatefulWidget {
  const _InterestPickerSheet({
    required this.initialSelection,
    required this.brandGradient,
  });

  final Set<String> initialSelection;
  final Gradient brandGradient;

  @override
  State<_InterestPickerSheet> createState() => _InterestPickerSheetState();
}

class _InterestPickerSheetState extends State<_InterestPickerSheet> {
  static const int kMax = 15;

  final TextEditingController _search = TextEditingController();
  late Set<String> _selected = {...widget.initialSelection};

  // Mutable example data — replace with your backend data as needed.
  final Map<String, List<String>> _groups = {
    'Adventure': [
      'BASE Jumping',
      'Bungee Jumping',
      'Cultural Immersion',
      'Expedition Travel',
    ],
    'Creative Arts': [
      'Acting/Theater',
      'Animation',
      'Art',
      'Calligraphy/Lettering',
      'Ceramics/Pottery',
    ],
    'Entertainment': [
      'Arcade Gaming',
      'Board Games',
      'Concerts',
      'Escape Rooms',
      'Karaoke',
    ],
  };

  void _toggle(String item) {
    setState(() {
      if (_selected.contains(item)) {
        _selected.remove(item);
      } else if (_selected.length < kMax) {
        _selected.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DraggableScrollableSheet(
      initialChildSize: 0.92,
      minChildSize: 0.6,
      maxChildSize: 0.98,
      builder: (context, scrollCtrl) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                blurRadius: 24,
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, -8),
              ),
            ],
          ),
          child: Column(
            children: [
              const SizedBox(height: 8),
              Container(
                width: 46,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color(0xFFE6E6E9),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(height: 12),

              // Header + Search + Custom link
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select Your Interests",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Select interests to help find compatible people nearby. Choose up to 15.",
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.black54,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _search,
                      onChanged: (_) => setState(() {}),
                      decoration: InputDecoration(
                        hintText: "Search interests",
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFE6E6E9),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFE6E6E9),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFBAC0FF),
                          ),
                        ),
                        prefixIcon: const Icon(Icons.search),
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: _showCreateCustomInterest,
                      child: Text(
                        "Create Custom Interests",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF4C5CFF),
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // Interest list
              Expanded(
                child: ListView.builder(
                  controller: scrollCtrl,
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                  itemCount: _groups.length,
                  itemBuilder: (_, idx) {
                    final group = _groups.keys.elementAt(idx);
                    final items = _groups[group]!;
                    final query = _search.text.trim().toLowerCase();
                    final visibles = items
                        .where(
                          (e) =>
                              query.isEmpty || e.toLowerCase().contains(query),
                        )
                        .toList();
                    if (visibles.isEmpty) return const SizedBox.shrink();

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          Text(
                            group,
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: Colors.black54,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 6),
                          ...visibles.map((it) {
                            final selected = _selected.contains(it);
                            return InkWell(
                              onTap: () => _toggle(it),
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 0,
                                ),
                                decoration: BoxDecoration(
                                  color: selected
                                      ? const Color(0xFFF5F6FF)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: selected
                                        ? const Color(0xFFBAC0FF)
                                        : const Color(0xFFE6E6E9),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: selected,
                                      onChanged: (_) => _toggle(it),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(child: Text(it)),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Bottom bar (sticky)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: Color(0xFFE6E6E9))),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Selected: ${_selected.length}/$kMax",
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(width: 8),
                        if (_selected.isEmpty)
                          const Text(
                            "Please select at least 1",
                            style: TextStyle(color: Colors.red),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _selected.isEmpty
                            ? null
                            : () => Navigator.pop(context, _selected),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4C5CFF),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(
                          "Save interest (${_selected.length}/$kMax)",
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Gap.h40,
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Small dialog to create a custom interest (per Figma)
  void _showCreateCustomInterest() {
    showDialog(
      context: context,
      builder: (_) {
        final TextEditingController nameCtl = TextEditingController();
        final TextEditingController descCtl = TextEditingController();
        String? error;

        return StatefulBuilder(
          builder: (context, setLocal) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            content: SizedBox(
              width: 360,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Text(
                        "Create Custom Interest",
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: nameCtl,
                    decoration: const InputDecoration(
                      hintText: "Search interests",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (error != null)
                    Text(error!, style: const TextStyle(color: Colors.red)),
                  TextField(
                    controller: descCtl,
                    minLines: 3,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      hintText: "Brief description (optional, max 100 chars)",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 44,
                    child: ElevatedButton(
                      onPressed: () {
                        final name = nameCtl.text.trim();
                        if (name.length < 3) {
                          setLocal(
                            () => error =
                                "Interest name must be at least 3 characters",
                          );
                          return;
                        }
                        setState(() {
                          final list = _groups['Custom'] ?? <String>[];
                          if (!list.contains(name)) {
                            _groups['Custom'] = [...list, name];
                          }
                          if (_selected.length < kMax) {
                            _selected.add(name);
                          }
                        });
                        Navigator.pop(context); // close dialog
                      },
                      child: const Text(
                        "Create interests",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
            decoration: const InputDecoration(
              hintText: 'Write something about yourself',
              hintStyle: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: Color(0xFF9CA3AF),
              ),
              isDense: true,
              contentPadding: EdgeInsets.fromLTRB(12, 14, 12, 12),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(color: neutral300, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
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
