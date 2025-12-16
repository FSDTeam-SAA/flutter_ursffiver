// import 'package:flutter/material.dart';

// import '../../../../core/theme/text_style.dart';

// class PrivacyPolicyScreen extends StatelessWidget {
//   const PrivacyPolicyScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: Text(
//           "Privacy Policy",
//           style: AppText.xlSemiBold_20_600.copyWith(color: Colors.black),
//         ),
//         centerTitle: false,
//       ),
//       body: SafeArea(
//         // child: SingleChildScrollView(
//         //   child: Padding(
//         //     padding: const EdgeInsets.all(16.0), // Add padding here
//         //     child: Column(
//         //       children: const [
//         //         Text(
//         //           "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean non convallis ex, mattis vehicula magna. Proin luctus quis velit eu bibendum. In eget massa vestibulum, feugiat nisl sed, varius diam. Etiam tincidunt rhoncus justo vitae cursus. Pellentesque ac lectus ac felis pharetra dapibus sed sit amet purus. Cras odio erat, sodales ac arcu eget, tincidunt pretium nibh. Phasellus ornare efficitur mi id blandit. ",
//         //         ),
//         //         Text(
//         //           "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean non convallis ex, mattis vehicula magna. Proin luctus quis velit eu bibendum. In eget massa vestibulum, feugiat nisl sed, varius diam. Etiam tincidunt rhoncus justo vitae cursus. Pellentesque ac lectus ac felis pharetra dapibus sed sit amet purus. Cras odio erat, sodales ac arcu eget, tincidunt pretium nibh. Phasellus ornare efficitur mi id blandit. ",
//         //         ),
//         //         Text(
//         //           "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean non convallis ex, mattis vehicula magna. Proin luctus quis velit eu bibendum. In eget massa vestibulum, feugiat nisl sed, varius diam. Etiam tincidunt rhoncus justo vitae cursus. Pellentesque ac lectus ac felis pharetra dapibus sed sit amet purus. Cras odio erat, sodales ac arcu eget, tincidunt pretium nibh. Phasellus ornare efficitur mi id blandit. ",
//         //         ),
//         //         Text(
//         //           "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean non convallis ex, mattis vehicula magna. Proin luctus quis velit eu bibendum. In eget massa vestibulum, feugiat nisl sed, varius diam. Etiam tincidunt rhoncus justo vitae cursus. Pellentesque ac lectus ac felis pharetra dapibus sed sit amet purus. Cras odio erat, sodales ac arcu eget, tincidunt pretium nibh. Phasellus ornare efficitur mi id blandit. ",
//         //         ),
//         //         Text(
//         //           "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean non convallis ex, mattis vehicula magna. Proin luctus quis velit eu bibendum. In eget massa vestibulum, feugiat nisl sed, varius diam. Etiam tincidunt rhoncus justo vitae cursus. Pellentesque ac lectus ac felis pharetra dapibus sed sit amet purus. Cras odio erat, sodales ac arcu eget, tincidunt pretium nibh. Phasellus ornare efficitur mi id blandit. ",
//         //         ),
//         //         Text(
//         //           "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean non convallis ex, mattis vehicula magna. Proin luctus quis velit eu bibendum. In eget massa vestibulum, feugiat nisl sed, varius diam. Etiam tincidunt rhoncus justo vitae cursus. Pellentesque ac lectus ac felis pharetra dapibus sed sit amet purus. Cras odio erat, sodales ac arcu eget, tincidunt pretium nibh. Phasellus ornare efficitur mi id blandit. ",
//         //         ),
//         //       ],
//         //     ),
//         //   ),
//         // ),
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: const [
//                 Text(
//                   "# SPEET Privacy Policy\n\n"
//                   "Developed and operated by Appurs LLC\n\n"
//                   "Last Updated: July 14, 2025\n"
//                   "Effective Date: July 14, 2025\n\n"
//                   "By using SPEET, you agree to this Privacy Policy. This document explains how your information is collected, used, and protected when using the SPEET mobile application.",
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),

//                 SizedBox(height: 16),

//                 Text(
//                   "## 1. Introduction\n\n"
//                   "SPEET is developed and operated by Appurs LLC. We are committed to protecting your privacy and being transparent about how your information is handled. "
//                   "This policy explains how we collect, use, disclose, and safeguard your data while using our mobile app and related services.",
//                 ),

//                 SizedBox(height: 16),

//                 Text(
//                   "## 2. Information We Collect\n\n"
//                   "### Personal Information You Provide\n"
//                   "- Account Information: Email, username, date of birth, optional profile picture\n"
//                   "- Profile Information: Bio, age range, gender preferences, interests\n"
//                   "- Communication Data: Messages sent through the platform\n\n"
//                   "### Location Information\n"
//                   "- Precise GPS location when enabled\n"
//                   "- Approximate location for discovery\n"
//                   "- Real-time shared location during active sharing sessions\n\n"
//                   "### Automatically Collected Data\n"
//                   "- Device type, OS, identifiers\n"
//                   "- Usage patterns and feature interactions\n"
//                   "- IP address, technical logs",
//                 ),

//                 SizedBox(height: 16),

//                 Text(
//                   "## 3. How We Use Your Information\n\n"
//                   "- User matching and discovery\n"
//                   "- Enabling messaging and communication\n"
//                   "- Location sharing features\n"
//                   "- Age verification and safety checks\n"
//                   "- Analytics, performance monitoring, and customer support\n"
//                   "- Content moderation for policy compliance\n",
//                 ),

//                 SizedBox(height: 16),

//                 Text(
//                   "## 4. Information Sharing\n\n"
//                   "### What We Share\n"
//                   "- Profile info based on your privacy settings\n"
//                   "- Profile photos if enabled\n"
//                   "- Approximate location for user discovery\n"
//                   "- Activity status\n\n"
//                   "### What We Do NOT Share\n"
//                   "- Email addresses\n"
//                   "- Precise location (except during active sharing)\n"
//                   "- Private messages\n"
//                   "- Personal data to advertisers (never sold)\n\n"
//                   "### Third-Party Sharing\n"
//                   "- Cloud hosting, analytics, and support partners\n"
//                   "- Legal authorities when required\n"
//                   "- Business transfers in mergers or acquisitions",
//                 ),

//                 SizedBox(height: 16),

//                 Text(
//                   "## 5. Data Security & Retention\n\n"
//                   "- Encryption of transmitted data\n"
//                   "- Strict access controls\n"
//                   "- Regular security audits\n"
//                   "- Data retained only as long as necessary\n"
//                   "- Location data deleted immediately after sessions end\n"
//                   "- Moderation logs may be kept for policy enforcement",
//                 ),

//                 SizedBox(height: 16),

//                 Text(
//                   "## 6. Children's Privacy\n\n"
//                   "SPEET is for users **18+ only**. We do not knowingly collect data from children under 18.",
//                 ),

//                 SizedBox(height: 16),

//                 Text(
//                   "## 7. International Users & Legal Rights\n\n"
//                   "- Data may be transferred to and processed in the USA\n"
//                   "- GDPR rights (EU): access, correction, deletion, portability, objection\n"
//                   "- CCPA rights (California): know, delete, opt-out (we do not sell data)",
//                 ),

//                 SizedBox(height: 16),

//                 Text(
//                   "## 8. Cookies & Tracking\n\n"
//                   "- Authentication\n"
//                   "- Preference storage\n"
//                   "- Analytics & performance enhancements",
//                 ),

//                 SizedBox(height: 16),

//                 Text(
//                   "## 9. Updates to This Policy\n\n"
//                   "We may update this policy and notify you via:\n"
//                   "- In-app notifications\n"
//                   "- Email\n"
//                   "- Website updates",
//                 ),

//                 SizedBox(height: 16),

//                 Text(
//                   "## 10. Contact Information\n\n"
//                   "Appurs LLC\n"
//                   "Email: admin@appurs.app\n"
//                   "Address: Appurs LLC, PO Box 5, Shrub Oak, NY 10588, USA",
//                 ),

//                 SizedBox(height: 16),

//                 Text(
//                   "## 11. Effective Date\n\n"
//                   "This Privacy Policy is effective as of July 14, 2025.",
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/text_style.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.3,
        title: Text(
          "Privacy Policy",
          style: AppText.xlSemiBold_20_600.copyWith(color: Colors.black),
        ),
        centerTitle: false,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              _sectionCard(
                title: "SPEET Privacy Policy",
                content:
                    "Developed and operated by Appurs LLC\n\n"
                    "Last Updated: July 14, 2025\n"
                    "Effective Date: July 14, 2025\n\n"
                    "By using SPEET, you agree to this Privacy Policy. This document explains how your data is collected, used, and protected.",
              ),

              _sectionCard(
                title: "1. Introduction",
                content:
                    "SPEET is developed and operated by Appurs LLC. We are committed to protecting your privacy and ensuring transparency about how your information is used.",
              ),

              _sectionCard(
                title: "2. Information We Collect",
                content:
                    "• Personal Information: Email, username, date of birth, profile picture\n"
                    "• Profile Details: Bio, age range, preferences, interests\n"
                    "• Messages sent within the app\n\n"
                    "• GPS location when enabled\n"
                    "• Approximate location for discovery\n"
                    "• Real-time shared location during sharing sessions\n\n"
                    "• Device details (OS, model)\n"
                    "• Usage analytics and interaction patterns\n"
                    "• IP address and technical logs",
              ),

              _sectionCard(
                title: "3. How We Use Your Information",
                content:
                    "• Matching you with nearby users\n"
                    "• Enabling chat and communication\n"
                    "• Location-based features\n"
                    "• Age verification & safety enforcement\n"
                    "• App improvement analytics\n"
                    "• Content moderation & compliance",
              ),

              _sectionCard(
                title: "4. Information Sharing",
                content:
                    "WHAT WE SHARE:\n"
                    "• Profile info (based on your privacy settings)\n"
                    "• Profile photos\n"
                    "• Approximate location\n"
                    "• Activity status\n\n"
                    "WHAT WE DO NOT SHARE:\n"
                    "• Email\n"
                    "• Precise GPS location (unless shared)\n"
                    "• Private messages\n"
                    "• Personal data for advertising\n\n"
                    "THIRD-PARTY SHARING:\n"
                    "• Hosting & analytics providers\n"
                    "• Legal authorities if required\n"
                    "• Business transfers during mergers",
              ),

              _sectionCard(
                title: "5. Data Security & Retention",
                content:
                    "• Encrypted data transmission\n"
                    "• Strict access control measures\n"
                    "• Regular safety audits\n"
                    "• Location deleted instantly after sessions\n"
                    "• Messages stored only when needed",
              ),

              _sectionCard(
                title: "6. Children's Privacy",
                content:
                    "SPEET is for users aged 18+. We do not knowingly collect information from minors.",
              ),

              _sectionCard(
                title: "7. International Users & Rights",
                content:
                    "• Data may be processed in the USA\n"
                    "• GDPR Rights: Access, Rectify, Delete, Portability, Object\n"
                    "• CCPA Rights: Know, Delete, Opt-Out",
              ),

              _sectionCard(
                title: "8. Cookies & Tracking",
                content:
                    "• Login authentication\n"
                    "• Saving preferences\n"
                    "• Performance analytics",
              ),

              _sectionCard(
                title: "9. Policy Updates",
                content:
                    "We may update this Privacy Policy. You will be notified via app alerts, email, or website updates.",
              ),

              _sectionCard(
                title: "10. Contact Information",
                content:
                    "Appurs LLC\n"
                    "Email: admin@appurs.app\n"
                    "Address: PO Box 5, Shrub Oak, NY 10588, USA",
              ),

              _sectionCard(
                title: "11. Effective Date",
                content: "This Privacy Policy is effective as of July 14, 2025.",
              ),

              const SizedBox(height: 20),
            ],
          ),
        ).animate()
              .slideY(
                begin: .8,
                end: 0,
                duration: 500.ms,
                curve: Curves.easeOutCubic,
              )
              .fadeIn(duration: 500.ms, curve: Curves.easeOutCubic),
      ),
    );
  }

  /// Card UI Builder
  static Widget _sectionCard({required String title, required String content}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
