import 'package:flutter/material.dart';
import '../../../../core/theme/text_style.dart';

class TermsConditionScreen extends StatelessWidget {
  const TermsConditionScreen({super.key});

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: AppText.smRegular_14_400.copyWith(color: Colors.black),
      ),
    );
  }

  Widget buildParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        text,
        style: AppText.smRegular_14_400.copyWith(
          color: Colors.black87,
          height: 1.5,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Terms & Conditions",
          style: AppText.xlSemiBold_20_600.copyWith(color: Colors.black),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Last updated
                buildParagraph("Last Updated: July 14, 2025"),
                buildParagraph("Effective Date: July 14, 2025"),

                buildSectionTitle("1. General Disclaimer"),
                buildParagraph(
                  "SPEET is provided \"as is\" and \"as available\" without any "
                  "warranties of any kind, either express or implied, including "
                  "but not limited to warranties of merchantability, fitness for "
                  "a particular purpose, and non-infringement.",
                ),
                buildParagraph(
                  "The owners and operators of SPEET make no warranty that the "
                  "service will be uninterrupted, timely, secure, or error-free.",
                ),

                buildSectionTitle("2. User Safety & Responsibility"),
                buildParagraph("Users are solely responsible for:"),
                buildParagraph(
                    "- Their interactions with other users\n"
                    "- Verifying the identity of people they choose to meet\n"
                    "- Taking appropriate safety precautions when meeting in person\n"
                    "- Reporting inappropriate behavior or content"),
                buildParagraph("Safety Recommendations:"),
                buildParagraph(
                    "- Always meet new connections in public places\n"
                    "- Inform friends or family of your meeting plans\n"
                    "- Trust your personal instincts about safety"),

                buildSectionTitle("3. Location-Based Services"),
                buildParagraph(
                  "SPEET uses location-based services to connect users. Users acknowledge that:",
                ),
                buildParagraph(
                  "- Location data may not always be accurate or up-to-date\n"
                  "- The Company is not responsible for consequences arising from inaccurate location information\n"
                  "- Users are solely responsible for their safety when meeting other users\n"
                  "- The Company does not verify the identity or background of users",
                ),

                buildSectionTitle("4. Content Standards & Profile Pictures"),
                buildParagraph("Profile Picture Requirements:"),
                buildParagraph(
                    "- Must show your actual face\n"
                    "- Must not contain nudity or explicit content\n"
                    "- Must not contain offensive or harmful content\n"
                    "- Must not violate intellectual property or privacy rights"),
                buildParagraph("Prohibited Content:"),
                buildParagraph(
                    "- Nudity or sexually explicit images\n"
                    "- Offensive or discriminatory content\n"
                    "- Content violating others’ rights\n"
                    "- Images that are not of the account holder"),
                buildParagraph(
                    "SPEET may remove content or suspend accounts without notice "
                    "for violations. No refunds will be issued for terminated accounts."),

                buildSectionTitle("5. User-Generated Content & Communications"),
                buildParagraph(
                  "SPEET allows users to share content. The Company does not "
                  "endorse or guarantee any user-generated content and may remove "
                  "content at its discretion for safety or compliance reasons.",
                ),

                buildSectionTitle("6. Privacy & Data Protection"),
                buildParagraph(
                    "While the Company applies reasonable security measures, no "
                    "internet transmission is 100% secure. Users provide personal "
                    "information at their own risk, and the Company cannot "
                    "guarantee absolute data security."),
                
                buildSectionTitle("7. Age Restrictions"),
                buildParagraph(
                  "SPEET is for users 18+ only. Users must accurately represent "
                  "their age. The Company is not liable for interactions involving "
                  "users who misrepresent their age.",
                ),

                buildSectionTitle("8. Limitation of Liability"),
                buildParagraph(
                  "To the maximum extent permitted by law, the Company is not "
                  "liable for indirect, incidental, special, or consequential "
                  "damages, including loss of data, profits, or goodwill.",
                ),

                buildSectionTitle("9. Service Availability"),
                buildParagraph(
                  "The Company may modify, suspend, or discontinue the service at "
                  "any time, and may terminate accounts for violations.",
                ),

                buildSectionTitle("10. Modifications to Terms"),
                buildParagraph(
                  "These terms may be updated at any time. Users will be notified "
                  "via in-app alerts, email, or website updates. Continued use of "
                  "SPEET after changes constitutes acceptance.",
                ),
                buildParagraph(
                    "In case of a business sale, merger, or acquisition, these terms "
                    "may change under new ownership."),

                buildSectionTitle("11. Contact Information"),
                buildParagraph(
                    "For questions or issues, contact our support team through the "
                    "SPEET app or official support channels."),
                
                buildParagraph("© 2025 Appurs LLC. All rights reserved."),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
