import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/features/common/app_logo.dart';

import 'login_screen.dart';
// import 'package:flutter_ursffiver/features/auth/presentation/screens/login_screen.dart';


class AfterInterestSelectedScreen extends StatefulWidget {
  const AfterInterestSelectedScreen({super.key});

  @override
  State<AfterInterestSelectedScreen> createState() =>
      _AfterInterestSelectedScreenState();
}

class _AfterInterestSelectedScreenState
    extends State<AfterInterestSelectedScreen> {
  // Brand tokens
  static const _brandBlue = Color(0xFF4C5CFF);
  static const _brandPurple = Color(0xFF8F79FF);
  static const _brandGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [_brandBlue, _brandPurple],
  );

  // Neutrals
  static const _baseBlack = Color(0xFF030712);
  static const _border = Color(0xFFE6E6E9);

  // Demo selection (already chosen)
  static const int _maxInterests = 15;
  final List<_InterestTag> _selected = [
    _InterestTag('Acting/Improv', Color(0xFF3B82F6)),
    _InterestTag('Expeditions', Color(0xFF22C55E)),
    _InterestTag('Escape Rooms', Color(0xFFEF4444)),
    _InterestTag('Arcade Games', Color(0xFFF59E0B)),
    _InterestTag('Board Games', Color(0xFF3B82F6)),
    _InterestTag('Photography', Color(0xFF22C55E)),
    _InterestTag('Cooking', Color(0xFFEF4444)),
    _InterestTag('Hiking', Color(0xFF3B82F6)),
    _InterestTag('Language Exch.', Color(0xFF6366F1)),
  ];

  int get _count => _selected.length;
  double get _progress => _count / _maxInterests;

  @override
  Widget build(BuildContext context) {
    final caption = Theme.of(context)
        .textTheme
        .bodySmall
        ?.copyWith(color: const Color(0xFF6B7280), height: 1.35);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 6),
              // SPEET badge
              // const Center(child: _BrandWordWithUnderline(gradient: _brandGradient)),
              Center(child: const AppLogo(height: 90,width: 50,)),

              const SizedBox(height: 18),

              // Title & subtitle
              const Text(
                'What interests you?',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: _baseBlack,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Select interests to find people who share your passions.',
                style: caption,
              ),
              const SizedBox(height: 16),

              // Card
              _Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Card header
                    Row(
                      children: [
                        const Text(
                          'My Primary Interests',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: _baseBlack,
                          ),
                        ),
                        const Spacer(),
                        _MiniProgress(value: _progress),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your primary Interests will be visible to nearby users as a preview of who you are.',
                      style: caption,
                    ),
                    const SizedBox(height: 12),

                    // Selected chips
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _selected
                          .map((t) => _ChipPill(text: t.name, color: t.color))
                          .toList(),
                    ),
                    const SizedBox(height: 12),

                    // Selected count field
                    SizedBox(
                      height: 44,
                      child: TextField(
                        readOnly: true,
                        controller: TextEditingController(
                          text: '$_count interests selected',
                        ),
                        decoration: InputDecoration(
                          hintText: '',
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: _border),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                            const BorderSide(color: Color(0xFFBAC0FF)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // "Selected: n/15 interests"
                    Text(
                      'Selected: $_count/$_maxInterests interests',
                      style: caption,
                    ),
                    const SizedBox(height: 12),

                    // Card footer hint (soft gradient background)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0x11BAC0FF),
                            Color(0x08BAC0FF),
                            Color(0x00BAC0FF),
                          ],
                        ),
                      ),
                      child: Text(
                        'Your interests help us connect you with like minded people nearby',
                        textAlign: TextAlign.center,
                        style: caption,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // Bottom CTA
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: SizedBox(
            height: 52,
            child: _GradientButton(
              gradient: _brandGradient,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SignInScreen()),
                );
              },
              child: Text(
                'Save Interest ($_count/$_maxInterests)',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/* ======================= Pieces ======================= */

class _InterestTag {
  final String name;
  final Color color;
  const _InterestTag(this.name, this.color);
}

class _Card extends StatelessWidget {
  const _Card({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _AfterInterestSelectedScreenState._border),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _ChipPill extends StatelessWidget {
  const _ChipPill({required this.text, required this.color});
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      constraints: const BoxConstraints(maxWidth: 140),
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12.5,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _MiniProgress extends StatelessWidget {
  const _MiniProgress({required this.value});
  final double value;

  @override
  Widget build(BuildContext context) {
    final bg = const Color(0xFFE9ECFF);
    final fg = const LinearGradient(
      colors: [_AfterInterestSelectedScreenState._brandBlue,
        _AfterInterestSelectedScreenState._brandPurple],
    );

    return Container(
      width: 70,
      height: 6,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: LayoutBuilder(builder: (_, cs) {
        final w = cs.maxWidth * value.clamp(0, 1);
        return Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: w,
            height: 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: fg,
            ),
          ),
        );
      }),
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
          fontFamily: 'Poppins',
          fontSize: size,
          fontWeight: weight,
          letterSpacing: 1.1,
        ),
      ),
    );
  }
}

class _GradientButton extends StatelessWidget {
  const _GradientButton({
    required this.gradient,
    required this.child,
    this.onPressed,
  });

  final Gradient gradient;
  final Widget child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: Ink(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onPressed,
          child: Center(child: child),
        ),
      ),
    );
  }
}

class _BrandWordWithUnderline extends StatelessWidget {
  const _BrandWordWithUnderline({required this.gradient});
  final Gradient gradient;

  static const _style = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18,
    fontWeight: FontWeight.w900,
    letterSpacing: 1.1,
  );

  @override
  Widget build(BuildContext context) {
    // measure “SPEET” so underline width matches the word
    final tp = TextPainter(
      text: const TextSpan(text: 'SPEET', style: _style),
      textDirection: TextDirection.ltr,
    )..layout();

    final w = tp.width;

    return SizedBox(
      width: w,
      height: 32, // room for the underline
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: _GradientMask(
              gradient: gradient,
              child: const Text('SPEET', style: _style),
            ),
          ),
          Positioned(
            bottom: 0,
            child: _GradientUnderline(width: w, gradient: gradient),
          ),
        ],
      ),
    );
  }
}

class _GradientUnderline extends StatelessWidget {
  const _GradientUnderline({required this.width, required this.gradient});
  final double width;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 12,
      child: CustomPaint(
        painter: _UnderlinePainter(
          gradient: gradient,
          barWidth: width - 20, // small inset so arrows show
          height: 6,
          radius: 6,
          arrow: 6,
        ),
      ),
    );
  }
}

class _UnderlinePainter extends CustomPainter {
  _UnderlinePainter({
    required this.gradient,
    required this.barWidth,
    required this.height,
    required this.radius,
    required this.arrow,
  });

  final Gradient gradient;
  final double barWidth;
  final double height;
  final double radius;
  final double arrow;

  @override
  void paint(Canvas canvas, Size size) {
    final left = (size.width - barWidth) / 2;
    final top = size.height - height;

    final shader = gradient.createShader(
      Rect.fromLTWH(left, top, barWidth, height),
    );
    final paint = Paint()..shader = shader;

    // rounded pill
    final pill = RRect.fromRectAndRadius(
      Rect.fromLTWH(left, top, barWidth, height),
      Radius.circular(radius),
    );
    canvas.drawRRect(pill, paint);

    // left arrow
    final cy = top + height / 2;
    final lp = Path()
      ..moveTo(left - arrow, cy)
      ..lineTo(left, top)
      ..lineTo(left, top + height)
      ..close();
    canvas.drawPath(lp, paint);

    // right arrow
    final right = left + barWidth;
    final rp = Path()
      ..moveTo(right + arrow, cy)
      ..lineTo(right, top)
      ..lineTo(right, top + height)
      ..close();
    canvas.drawPath(rp, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
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

