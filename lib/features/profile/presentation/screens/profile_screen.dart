import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/theme/app_colors.dart';
import 'package:flutter_ursffiver/core/theme/app_gap.dart';
import 'package:flutter_ursffiver/core/theme/text_style.dart';
import 'package:flutter_ursffiver/features/profile/presentation/screens/change_password_scree.dart';
import 'package:flutter_ursffiver/features/profile/presentation/screens/interests_screen.dart';
import 'package:flutter_ursffiver/features/profile/presentation/screens/terms_condition_screen.dart';
import '../widget/logout_widget.dart';
import 'edit_personal_informetion_scree.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Profile',
                    style: AppText.xxlSemiBold_24_600.copyWith(
                      color: AppColors.primaryTextblack,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildMenuItem(Icons.person_2_outlined, 'My Profile', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => MyProfileScreen()),
                      );
                    }),
                    _buildMenuItem(Icons.key, 'Change Password', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChangePasswordScreen(),
                        ),
                      );
                    }),
                    _buildMenuItem(Icons.interests_outlined, 'Interests', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => InterestsScreen(currentInterests: []),
                        ),
                      );
                    }),
                    _buildMenuItem(
                      Icons.settings_outlined,
                      'Privacy Settings',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => Scaffold()),
                        );
                      },
                    ),
                    _buildMenuItem(
                      Icons.person_2_outlined,
                      'Invite Friend',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => Scaffold()),
                        );
                      },
                    ),
                    _buildMenuItem(
                      Icons.heart_broken_rounded,
                      'Support Our Mission',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => Scaffold()),
                        );
                      },
                    ),
                    _buildMenuItem(
                      Icons.support_agent_outlined,
                      'Report a Problem',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => Scaffold()),
                        );
                      },
                    ),
                    _buildMenuItem(
                      Icons.help_outline,
                      'Terms & Conditions',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => TermsConditionScreen()),
                        );
                      },
                    ),
                    // _buildMenuItem(
                    //   Icons.payment_outlined,
                    //   'Payment History',
                    //   () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(builder: (_) => Scaffold()),
                    //     );
                    //   },
                    // ),
                    // _buildMenuItem(Icons.payment_outlined, 'CV', () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (_) => RecruiterAccountPage(),
                    //     ),
                    //   );
                    // }),
                    // _buildMenuItem(Icons.payment_outlined, 'ContuctUs', () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(builder: (_) => ContactUS()),
                    //   );
                    // }),
                    _buildMenuItem(Icons.logout, 'Logout', () {
                      showDialog(
                        context: context,
                        builder: (context) => LogoutDialog(
                          onConfirm: () {
                          },
                        ),
                      );
                    }, isLast: true),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    IconData icon,
    String title,
    VoidCallback onTap, {
    bool isLast = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primaryTextblack, size: 24),
            Gap.w16,
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryTextblack,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
