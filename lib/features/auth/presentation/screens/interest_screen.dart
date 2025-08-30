import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../common/app_logo.dart';
import '../../../home/presentation/screen/home_screen.dart';

class InterestScreen extends StatefulWidget {
  const InterestScreen({super.key});

  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  // Brand + UI constants
  static const _brandBlue = Color(0xFF4C5CFF);
  static const _brandGradient = LinearGradient(
    colors: [Color(0xFF4C5CFF), Color(0xFF8F79FF)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static const _border = Color(0xFFE6E6E9);
  static const _cardBg = Color(0xFFF8F6FF); // subtle lilac like the mock

  // Data
  static const int _maxSelection = 15;

  // Demo categories (extend as needed)
  final Map<String, List<String>> _catalog = const {
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

  final Set<String> _selected = <String>{};
  bool _showError = false;

  // Colors used for selected chips / row highlights
  final List<Color> _chipColors = const [
    Color(0xFF4DA3FF), // blue
    Color(0xFF37CC6E), // green
    Color(0xFFFF5A58), // red
    Color(0xFFFFB020), // yellow
  ];

  int get _count => _selected.length;

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
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: const AppLogo(
                    height: 50,
                    width: 50,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'What are your Primary Interests?',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 6),
                Text(
                  'Select interests to find people who share your\npassions.',
                  style: caption,
                ),
                const SizedBox(height: 14),

                // Card
                _Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title row with gradient tick
                      Row(
                        children: [
                          const Text(
                            'My Primary Interests',
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 15),
                          ),
                          const Spacer(),
                          Container(
                            width: 56,
                            height: 6,
                            decoration: const BoxDecoration(
                              gradient: _brandGradient,
                              borderRadius:
                              BorderRadius.all(Radius.circular(8)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Your primary interests will be visible to nearby users as a preview of who you are.',
                        style: caption,
                      ),
                      const SizedBox(height: 12),

                      // Selected chips preview (only when there are selections)
                      if (_selected.isNotEmpty) ...[
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _selected.toList().asMap().entries.map((e) {
                            final color = _chipColors[e.key % _chipColors.length];
                            return _Chip(text: e.value, color: color);
                          }).toList(),
                        ),
                        const SizedBox(height: 12),
                      ],

                      // Trigger field
                      GestureDetector(
                        onTap: _openSelectorSheet,
                        child: AbsorbPointer(
                          child: TextField(
                            readOnly: true,
                            decoration: _inputDecoration(
                              hint: _selected.isEmpty
                                  ? 'Click to select your interests'
                                  : (_selected.length == 1
                                  ? '1 interest selected'
                                  : '${_selected.length} interests selected'),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Counter + error
                      Row(
                        children: [
                          Text(
                            'Selected: $_count/$_maxSelection interests',
                            style: caption,
                          ),
                          const Spacer(),
                          if (_showError && _count == 0)
                            const Text(
                              'Please select at least 1',
                              style: TextStyle(color: Colors.red),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Your interests help us connect you with like minded people nearby',
                        style: caption,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),

      // Sticky bottom button
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(20, 8, 20, 12),
        child: SizedBox(
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
              setState(() => _showError = _count == 0);
              if (_count == 0) return;
              // Navigate to HomeScreen
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => const HomeScreen(),
                ),
              );
            },
            child: Text(
              'Save Interest ($_count/$_maxSelection)',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }

  /* ---------- UI helpers ---------- */

  InputDecoration _inputDecoration({required String hint}) => InputDecoration(
    hintText: hint,
    filled: true,
    fillColor: Colors.white,
    contentPadding:
    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: _border),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFBAC0FF)),
    ),
  );

  void _openSelectorSheet() async {
    final result = await showModalBottomSheet<Set<String>>(
      context: context,
      isScrollControlled: true,
      barrierColor: Colors.black.withOpacity(0.35),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (context) {
        return _InterestSelectorSheet(
          initial: _selected,
          max: _maxSelection,
          catalog: _catalog,
          brandGradient: _brandGradient,
          onChipColor: (i) => _chipColors[i % _chipColors.length],
        );
      },
    );

    if (result != null) {
      setState(() {
        _selected
          ..clear()
          ..addAll(result);
      });
    }
  }
}

/* ===================== Components ===================== */

class _Card extends StatelessWidget {
  const _Card({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _InterestScreenState._cardBg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            blurRadius: 14,
            spreadRadius: 0,
            offset: Offset(0, 8),
            color: Color(0x12000000),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.text, required this.color});
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }
}

/* ---------------- Bottom Sheet ---------------- */

class _InterestSelectorSheet extends StatefulWidget {
  const _InterestSelectorSheet({
    required this.initial,
    required this.max,
    required this.catalog,
    required this.brandGradient,
    required this.onChipColor,
  });

  final Set<String> initial;
  final int max;
  final Map<String, List<String>> catalog;
  final Gradient brandGradient;
  final Color Function(int index) onChipColor;

  @override
  State<_InterestSelectorSheet> createState() =>
      _InterestSelectorSheetState();
}

class _InterestSelectorSheetState extends State<_InterestSelectorSheet> {
  late final Set<String> _chosen = {...widget.initial};
  String _query = '';

  // Background tints for selected rows (to mirror green/purple/yellow examples)
  final List<Color> _rowTints = const [
    Color(0xFFE9F8EF), // greenish
    Color(0xFFEDEBFF), // lilac
    Color(0xFFFFF5DF), // soft yellow
  ];

  int get _count => _chosen.length;

  List<(String section, String item)> get _flatItems {
    final List<(String, String)> out = [];
    widget.catalog.forEach((section, items) {
      for (final i in items) {
        if (_query.trim().isEmpty ||
            i.toLowerCase().contains(_query.toLowerCase())) {
          out.add((section, i));
        }
      }
    });
    return out;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.88;

    return SizedBox(
      height: height,
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 14, 18, 6),
              child: Row(
                children: [
                  const Text(
                    'Select Your Interests',
                    style: TextStyle(
                        fontWeight: FontWeight.w800, fontSize: 16),
                  ),
                  const Spacer(),
                  Container(
                    width: 56,
                    height: 6,
                    decoration: BoxDecoration(
                      gradient: widget.brandGradient,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                'Select interests to help find compatible people nearby. Choose up to 15.',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.black54),
              ),
            ),
            const SizedBox(height: 10),

            // Search
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: TextField(
                decoration: _input('Search interests'),
                onChanged: (s) => setState(() => _query = s),
              ),
            ),
            const SizedBox(height: 8),

            // Create custom interest link
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: _openCreateCustom,
                  child: const Text(
                    'Create Custom Interests',
                    style: TextStyle(
                      color: _InterestScreenState._brandBlue,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 4),

            // List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 12),
                itemCount: widget.catalog.length,
                itemBuilder: (context, sectionIndex) {
                  final section = widget.catalog.keys.elementAt(sectionIndex);
                  final items = widget.catalog[section]!;
                  final visible = items
                      .where((i) => _query.isEmpty ||
                      i.toLowerCase().contains(_query.toLowerCase()))
                      .toList();

                  if (visible.isEmpty) return const SizedBox.shrink();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section header
                      Padding(
                        padding: const EdgeInsets.fromLTRB(18, 14, 18, 10),
                        child: Text(
                          section,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w800),
                        ),
                      ),
                      ...visible.asMap().entries.map((e) {
                        final i = e.value;
                        final selected = _chosen.contains(i);
                        final tint =
                        selected ? _rowTints[e.key % _rowTints.length] : null;

                        return Container(
                          color: tint,
                          child: CheckboxListTile(
                            dense: true,
                            value: selected,
                            onChanged: (v) {
                              setState(() {
                                if (v == true) {
                                  if (_chosen.length >= widget.max) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'You can choose up to 15 interests.'),
                                      ),
                                    );
                                  } else {
                                    _chosen.add(i);
                                  }
                                } else {
                                  _chosen.remove(i);
                                }
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(i),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 0),
                          ),
                        );
                      }),
                      const Divider(height: 1),
                    ],
                  );
                },
              ),
            ),

            // Save button
            SafeArea(
              top: false,
              minimum: const EdgeInsets.fromLTRB(18, 8, 18, 12),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _InterestScreenState._brandBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(_chosen),
                  child: Text(
                    'Save Interest (${_count}/${widget.max})',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _input(String hint) => InputDecoration(
    hintText: hint,
    filled: true,
    fillColor: Colors.white,
    contentPadding:
    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide:
      const BorderSide(color: _InterestScreenState._border),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFBAC0FF)),
    ),
  );

  Future<void> _openCreateCustom() async {
    final created = await showDialog<(String, String)?>(
      context: context,
      builder: (_) => const _CreateCustomDialog(),
    );
    if (created != null) {
      final name = created.$1.trim();
      if (name.isNotEmpty) {
        setState(() {
          _chosen.add(name);
        });
      }
    }
  }
}

/* -------- Custom Interest Dialog (validates >= 3 chars) -------- */

class _CreateCustomDialog extends StatefulWidget {
  const _CreateCustomDialog();

  @override
  State<_CreateCustomDialog> createState() => _CreateCustomDialogState();
}

class _CreateCustomDialogState extends State<_CreateCustomDialog> {
  final _name = TextEditingController();
  final _desc = TextEditingController();
  bool _showError = false;

  @override
  void dispose() {
    _name.dispose();
    _desc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 18),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title + gradient tick
            Row(
              children: [
                const Text(
                  'Create Custom Interest',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                ),
                const Spacer(),
                Container(
                  width: 56,
                  height: 6,
                  decoration: const BoxDecoration(
                    gradient: _InterestScreenState._brandGradient,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Select interests to help find compatible people nearby. Choose up to 15.',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.black54),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _name,
              decoration: _input('Search interests'),
              onChanged: (_) => setState(() => _showError = false),
            ),
            if (_showError)
              const Padding(
                padding: EdgeInsets.only(top: 6),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Interest name must be at least 3 characters',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            const SizedBox(height: 10),
            TextField(
              controller: _desc,
              maxLines: 3,
              maxLength: 100,
              decoration: _input('Brief description')
                  .copyWith(counterText: ''),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _InterestScreenState._brandBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (_name.text.trim().length < 3) {
                    setState(() => _showError = true);
                    return;
                  }
                  Navigator.of(context).pop((_name.text, _desc.text));
                },
                child: const Text(
                  'Create Interests',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _input(String hint) => InputDecoration(
    hintText: hint,
    filled: true,
    fillColor: Colors.white,
    contentPadding:
    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide:
      const BorderSide(color: _InterestScreenState._border),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFBAC0FF)),
    ),
  );
}

/* ---------------- Brand mark used at screen top ---------------- */

// class _LogoMark extends StatelessWidget {
//   const _LogoMark();
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: const [
//         _GradientText(
//           'SPEET',
//           gradient: _InterestScreenState._brandGradient,
//           size: 18,
//         ),
//         SizedBox(height: 4),
//         _LogoUnderline(),
//       ],
//     );
//   }
// }

class _LogoUnderline extends StatelessWidget {
  const _LogoUnderline();

  @override
  Widget build(BuildContext context) {
    const grad = _InterestScreenState._brandGradient;
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
        gradient: _InterestScreenState._brandGradient,
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
