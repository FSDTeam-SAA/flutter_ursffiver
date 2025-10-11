// on_boarding_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ursffiver/core/constants/route_names.dart';
import 'package:flutter_ursffiver/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter_ursffiver/features/auth/presentation/screens/signup_screen.dart';

import '../../../../main.dart';
import '../../../common/app_logo.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  // Brand look
  static const _brandGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFF4C5CFF), Color(0xFF8F79FF)],
  );
  static const _brandBlue = Color(0xFF4C5CFF);

  @override
  Widget build(BuildContext context) {
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
          child: DefaultTabController(
            length: 3,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ------- Header (use this where you build the Row) -------
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Welcome to',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 24,
                            fontWeight: FontWeight.w700, // SemiBold
                            height: 1.2, // 120%
                            letterSpacing: 0.0,
                            color: Color(0xFF030712), // base/black
                          ),
                        ),
                        const SizedBox(width: 8),
                        // const _BrandWordWithUnderline(text: 'SPEET'),
                        const AppLogo(height: 120, width: 80),
                      ],
                    ),
                  ),

                  Text(
                    "YoUrs truly local",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Spontaneously and on the spot, transform digital connections into real-life meetups with nearby people who share your interests - all within minutes.',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),

                  // Feature card
                  _Card(
                    child: Column(
                      children: const [
                        _FeatureTile(
                          icon: Icons.people_alt_outlined,
                          title: 'Real-World, In-Person Encounters',
                          subtitle:
                              'Break free from digital-only interaction and meet nearby people face-to-face who share your interests and passions.',
                        ),

                        _FeatureTile(
                          icon: Icons.place_outlined,
                          title: 'Location-Based Matching',
                          subtitle:
                              'Discover people nearby, from a few feet away to a few miles around you.',
                        ),

                        _FeatureTile(
                          icon: Icons.shield_outlined,
                          title: 'Verified Users',
                          subtitle:
                              'Choose to interact with unverified or verified users for enhanced safety.',
                        ),

                        _FeatureTile(
                          icon: Icons.cached_outlined,
                          title: 'Dynamic Availability',
                          subtitle:
                              'Let others know when you’re on or off and set your location range.',
                        ),

                        _FeatureTile(
                          icon: Icons.workspace_premium_outlined,
                          title: 'Social Badges System',
                          subtitle:
                              'Recognize qualities like communication skills, community contributions and more.',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),

                  Text(
                    'Find People Who Share\nYour Interests',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      height: 1.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Don’t see what you’re looking for? You’ll be able to suggest custom interests after signing up!",
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),

                  _SegmentedTabs(
                    tabs: const ['All Interests', 'Popular', 'Categories'],
                  ),
                  const SizedBox(height: 10),

                  // Tab content (fixed height inside scroll view)
                  SizedBox(
                    height: 300,
                    // width: 117,
                    child: TabBarView(
                      children: [
                        _ChipsGrid(groups: _demoAllInterests),
                        _ChipsGrid(groups: _demoPopular),
                        // _ChipsGrid(groups: _demoCategories),
                        _CategoriesGrid(groups: _demoCategories), // 👈 new
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Trust card
                  _Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Trust & Verification',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 12),
                        _TrustTile(
                          color: Colors.green,
                          icon: Icons.gpp_good_outlined,
                          title: 'Verified Member',
                          text:
                              'Sign up as a verified user to express the app’s highest commitment to trust and safety. Your account and identity details are securely verified.',
                        ),
                        SizedBox(height: 20),
                        _TrustTile(
                          color: Colors.red,
                          icon: Icons.gpp_bad_outlined,
                          title: 'Unverified Member',
                          text:
                              'Sign up as an unverified member to quickly access the app with fewer steps. You can convert to a verified account whenever you’re ready.',
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                  // Bottom actions (also duplicated in bottom bar for safe areas)
                  _PrimaryButton(
                    text: 'Sign In',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const SignInScreen()),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  _SecondaryButton(
                    text: 'Create Account',
                    onPressed: () {
                      //Navigator.pushNamed(context, RouteNames.signup);
                      navigatorKey.currentState?.pushNamed(RouteNames.signup);
                    },
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text.rich(
                      TextSpan(
                        text: 'By continuing, you agree to SPEET’s ',
                        style: Theme.of(
                          context,
                        ).textTheme.labelSmall?.copyWith(color: Colors.black54),
                        children: const [
                          TextSpan(
                            text: 'Terms of \nService',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: _brandBlue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: _brandBlue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(text: '.'),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CategoriesGrid extends StatelessWidget {
  const _CategoriesGrid({required this.groups});
  final Map<String, List<String>> groups;

  @override
  Widget build(BuildContext context) {
    final entries = groups.entries.toList(growable: false);

    return _Card(
      child: GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          // Wider than tall, like the comps
          childAspectRatio: 1.85,
        ),
        itemCount: entries.length,
        itemBuilder: (context, i) {
          final name = entries[i].key; // e.g. "Social Activities"
          final count = entries[i].value.length; // derive from items
          final color = _accentForIndex(i);

          return _CategoryCard(name: name, count: count, accent: color);
        },
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.name,
    required this.count,
    required this.accent,
  });

  final String name;
  final int count;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final parts = name.split(' ');
    final first = parts.isNotEmpty ? parts.first : name;
    final second = parts.length > 1 ? parts.sublist(1).join(' ') : '';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE6E6E9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title with colored second word
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Color(0xFF111827),
              ),
              children: [
                TextSpan(text: first),
                if (second.isNotEmpty) const TextSpan(text: ' '),
                if (second.isNotEmpty)
                  TextSpan(
                    text: second,
                    style: TextStyle(color: accent),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '$count interests',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: const Color(0xFF6B7280)),
          ),
          const Spacer(),
          // // Optional subtle chevron / affordance
          // Align(
          //   alignment: Alignment.bottomRight,
          //   child: Icon(Icons.chevron_right, size: 18, color: accent.withOpacity(.9)),
          // ),
        ],
      ),
    );
  }
}

/// Rotating accent palette that matches the mock’s vibe
Color _accentForIndex(int i) {
  const palette = <Color>[
    Color(0xFF6366F1), // indigo
    Color(0xFF10B981), // green
    Color(0xFFF59E0B), // amber
    Color(0xFF8B5CF6), // violet
    Color(0xFF06B6D4), // cyan
    Color(0xFFEF4444), // red
  ];
  return palette[i % palette.length];
}

class _GradientUnderline extends StatelessWidget {
  const _GradientUnderline({required this.width});
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 14, // total paint area
      child: CustomPaint(
        painter: _UnderlinePainter(
          barWidth: width - 20, // small inset so arrows are visible
          height: 8,
          radius: 8,
          arrow: 7,
        ),
      ),
    );
  }
}

class _UnderlinePainter extends CustomPainter {
  _UnderlinePainter({
    required this.barWidth,
    required this.height,
    required this.radius,
    required this.arrow,
  });

  final double barWidth;
  final double height;
  final double radius;
  final double arrow;

  @override
  void paint(Canvas canvas, Size size) {
    final left = (size.width - barWidth) / 2;
    final top = size.height - height;

    final shader = OnBoardingScreen._brandGradient.createShader(
      Rect.fromLTWH(left, top, barWidth, height),
    );

    final paint = Paint()..shader = shader;

    // rounded pill
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(left, top, barWidth, height),
      Radius.circular(radius),
    );
    canvas.drawRRect(rrect, paint);

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

/* ---------- Small UI pieces ---------- */

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

class _Card extends StatelessWidget {
  const _Card({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE6E6E9)),
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: 0,
            offset: Offset(0, 4),
            color: Color(0x0F000000),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _FeatureTile extends StatelessWidget {
  const _FeatureTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _GradientMask(
            gradient: OnBoardingScreen._brandGradient,
            child: CircleAvatar(
              radius: 16,

              backgroundColor: Colors.transparent,

              child: Center(child: Icon(icon, size: 22)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 4),
                Text(subtitle, style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SegmentedTabs extends StatelessWidget {
  const _SegmentedTabs({required this.tabs});
  final List<String> tabs;

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   border: Border.all(color: const Color(0xFFE6E6E9)),
      //   borderRadius: BorderRadius.circular(14),
      // ),
      padding: const EdgeInsets.all(6),
      child: TabBar(
        isScrollable: true,
        labelPadding: const EdgeInsets.symmetric(horizontal: 14),

        // simple underline under the selected label
        indicatorSize: TabBarIndicatorSize.label,
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(width: 3, color: OnBoardingScreen._brandBlue),
          insets: EdgeInsets.symmetric(horizontal: 0.001), // shorter line
        ),

        labelColor: OnBoardingScreen._brandBlue,
        unselectedLabelColor: Color(0xFF6B7280),
        overlayColor: WidgetStateProperty.all(Colors.transparent),

        // 👇 remove the black baseline
        dividerColor: Colors.transparent,

        tabs: tabs.map((t) => Tab(text: t)).toList(),
      ),
    );
  }
}

class _ChipsGrid extends StatelessWidget {
  const _ChipsGrid({required this.groups});
  final Map<String, List<String>> groups;

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: groups.length,
        separatorBuilder: (_, __) => const SizedBox(height: 26),
        itemBuilder: (context, index) {
          final title = groups.keys.elementAt(index);
          final items = groups[title]!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: items
                    .map((e) => _Tag(text: e))
                    .toList(growable: false),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE6E6E9)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(text, style: Theme.of(context).textTheme.labelMedium),
    );
  }
}

class _TrustTile extends StatelessWidget {
  const _TrustTile({
    required this.color,
    required this.icon,
    required this.title,
    required this.text,
  });

  final Color color;
  final IconData icon;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Transform.rotate(angle: 0, child: Icon(icon, color: color, size: 24)),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(text, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ],
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({required this.text, required this.onPressed});
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: OnBoardingScreen._brandBlue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: onPressed,
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.w700)),
      ),
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  const _SecondaryButton({required this.text, required this.onPressed});
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          side: const BorderSide(color: Color(0xFFCFD2D8)),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

/* ---------- Demo data ---------- */

const Map<String, List<String>> _demoAllInterests = {
  'Adventure': [
    'Expedition Travel',
    'Skydiving',
    'Climbing',
    'Backpacking',
    'Canyoneering',
    'Scuba Diving',
  ],
  'Creative Arts': [
    'Photography',
    'Street Photography',
    'Illustration',
    'Digital Art',
    'Writing',
    'DIY Crafts',
  ],
};

const Map<String, List<String>> _demoPopular = {
  'Trending': [
    'Social Activities',
    'Pick-up Sports',
    'Coffee Meetups',
    'Live Music',
    'Book Clubs',
  ],
  'Outdoors': ['Hiking', 'Camping', 'Cycling', 'Kayaking'],
};

const Map<String, List<String>> _demoCategories = {
  'Social Activities': [
    'Board Games',
    'Volunteering',
    'Trivia Nights',
    'Open Mic',
  ],
  'Tech & Learning': [
    'Hackathons',
    'Study Sessions',
    'Workshops',
    'Language Exchange',
  ],
};
