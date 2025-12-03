import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/theme/app_colors.dart';
import 'package:flutter_ursffiver/core/theme/app_gap.dart';
import 'package:flutter_ursffiver/core/theme/text_style.dart';
import 'package:flutter_ursffiver/features/auth/interface/auth_interface.dart';
import 'package:flutter_ursffiver/features/profile/presentation/screens/change_password_screen.dart';
import 'package:flutter_ursffiver/features/profile/presentation/screens/support_our_mission.dart';
import 'package:flutter_ursffiver/features/profile/presentation/screens/terms_condition_screen.dart';
import 'package:get/get.dart';
import '../widget/invite_friend.dart';
import '../widget/logout_widget.dart';
import 'edit_personal_informetion_scree.dart';
import 'privacy_policy_screen.dart';
import 'privacy_settings_screen.dart';
import 'report_problem_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
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
                    'My Account',
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
                    // _buildMenuItem(Icons.interests_outlined, 'Interests', () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(builder: (_) => InterestsPage()),
                    //   );
                    // }),
                    // _buildMenuItem(
                    //   Icons.settings_outlined,
                    //   'Privacy Settings',
                    //   () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (_) => PrivacySettingsScreen(),
                    //       ),
                    //     );
                    //   },
                    // ),
                    _buildMenuItem(
                      Icons.person_2_outlined,
                      'Invite Friend',
                      () {
                        showDialog(
                          context: context,
                          builder: (context) => const InviteFriend(
                            shareLink:
                                "https://speet.app", // pass your link here
                          ),
                        );
                      },
                      isLast: true,
                    ),

                    _buildMenuItem(
                      Icons.heart_broken_rounded,
                      'Support Our Mission',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => SupportScreen()),
                        );
                      },
                    ),
                    _buildMenuItem(
                      Icons.support_agent_outlined,
                      'Report a Problem',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ReportProblemScreen(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItem(
                      Icons.help_outline,
                      'Terms & Conditions',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => TermsConditionScreen(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItem(
                      Icons.payment_outlined,
                      'Privacy Policy',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => PrivacyPolicyScreen()),
                        );
                      },
                    ),
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
                            Get.find<AuthInterface>().logout();
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
