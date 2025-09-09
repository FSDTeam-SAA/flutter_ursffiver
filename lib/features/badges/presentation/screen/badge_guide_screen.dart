import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/theme/app_colors.dart';

import '../../../../core/theme/app_gap.dart';
import '../../../../core/theme/text_style.dart';

class BadgeGuideScreen extends StatelessWidget {
  const BadgeGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Row(
          children: [
            Icon(
              Icons.workspace_premium_outlined,
              size: 28,
              color: AppColors.primarybutton,
            ),
            const SizedBox(width: 8),
            const Text(
              "Badge Guide",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap.h8,
            // Subtitle
            const Text(
              "Understanding the Speet badge system and how it builds trust in our community",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
                height: 1.4,
              ),
            ),
            Gap.h20,
            WhatisBadges(),
            Gap.h20,
            const Text(
              "Badge Types",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            Gap.h12,

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const BadgeList(),
            ),
            Gap.h20,
            FAQScreen(),

            Gap.h40,

            BadgeEtiquette(),
          ],
        ),
      ),
    );
  }
}

//================= Badge List Widget =================//

class BadgeList extends StatelessWidget {
  const BadgeList({super.key});

  @override
  Widget build(BuildContext context) {
    final badges = [
      BadgeItem(
        icon: Icons.hearing,
        color: Colors.indigoAccent,
        title: "Great Listener",
        subtitle: "Listens with attention and care",
      ),
      BadgeItem(
        icon: Icons.question_answer,
        color: Colors.pinkAccent,
        title: "Thoughtful Questions",
        subtitle: "Asks meaningful questions",
      ),
      BadgeItem(
        icon: Icons.lightbulb_outline,
        color: Colors.greenAccent.shade400,
        title: "Knowledge Sharer",
        subtitle: "Shares valuable insights",
      ),
      BadgeItem(
        icon: Icons.location_on,
        color: Colors.orangeAccent,
        title: "Local Expert",
        subtitle: "Knows great local spots",
      ),
      BadgeItem(
        icon: Icons.check_circle_outline,
        color: Colors.lightBlueAccent,
        title: "Reliable",
        subtitle: "Always follows through",
      ),
      BadgeItem(
        icon: Icons.shield_outlined,
        color: Colors.purpleAccent,
        title: "Respectful",
        subtitle: "Mindful of boundaries",
      ),
      BadgeItem(
        icon: Icons.people_alt_outlined,
        color: Colors.redAccent,
        title: "Community Builder",
        subtitle: "Creates positive social connections",
      ),
      BadgeItem(
        icon: Icons.link,
        color: Colors.teal,
        title: "Connector",
        subtitle: "Introduces people who should meet",
      ),
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: badges.length,
      separatorBuilder: (_, __) => const SizedBox(height: 0),
      itemBuilder: (context, index) => BadgeTile(item: badges[index]),
    );
  }
}

//================= Badge Item Model =================//

class BadgeItem {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;

  BadgeItem({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
  });
}

//================= Badge Tile =================//

class BadgeTile extends StatelessWidget {
  final BadgeItem item;

  const BadgeTile({super.key, required this.item});
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: BorderSide(color: Colors.grey.shade300, width: 1),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: item.color.withOpacity(0.15),
              child: Icon(item.icon, color: item.color, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    item.subtitle,
                    style: const TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//================= What is Badges =================//

class WhatisBadges extends StatelessWidget {
  const WhatisBadges({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "What are badges?",
            style: AppText.xxlSemiBold_24_600.copyWith(color: Colors.black),
          ),
          const SizedBox(height: 4),
          Text(
            "Understanding the Speet badge system and how it builds trust in our community",
            style: AppText.smRegular_14_400.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Badges are a way for Speet users to recognize positive interactions and build community trust. Unlike ratings or reviews, badges are always positive and focus on specific qualities or behaviors that make someone a great person to meet.\n\n"
            "When you meet someone through Speet and have a positive experience, you can award them a badge that represents what made the interaction valuable. Each badge includes a brief personal message explaining why you're giving it (limited to 120 characters to keep things positive and focused).\n\n"
            "Badges appear on user profiles to help others understand what makes this person special in the community. You can manage the visibility of badges you've received in your badge settings.",
            style: TextStyle(fontSize: 14, height: 1.5, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}

//================= Badge Etiquette =================//

class BadgeEtiquette extends StatelessWidget {
  const BadgeEtiquette({super.key});

  Widget buildBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "•  ",
            style: TextStyle(fontSize: 14, height: 1.5, color: Colors.black87),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const Text(
            "Badge Etiquette",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),

          // Subtitle
          Text(
            "Guidelines for effective badge use",
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 16),

          // Do Section
          const Text(
            "Do:",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          buildBullet("Award badges after meaningful in-person interactions"),
          buildBullet(
            "Focus on specific qualities or actions that made the interaction positive",
          ),
          buildBullet("Keep badge messages authentic and personal"),
          buildBullet(
            "Use different badge types to recognize various strengths",
          ),
          buildBullet(
            "Consider which badge type best reflects your experience",
          ),

          const SizedBox(height: 16),
          Divider(color: Colors.grey.shade300, thickness: 1, height: 1),
          const SizedBox(height: 16),

          // Don't Section
          const Text(
            "Don't:",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          buildBullet(
            "Exchange badges merely as social currency or without genuine interaction",
          ),
          buildBullet("Include personal contact information in badge messages"),
          buildBullet(
            "Use badge messages for negative feedback (badges are for positive recognition only)",
          ),
          buildBullet(
            "Award badges to people you haven't met in person through the app",
          ),
          buildBullet("Pressure others to award you badges in return"),
        ],
      ),
    );
  }
}


//================= FAQ Section =================//

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final faqs = [
      {
        "question": "Why do badges have a 120 character limit for messages?",
        "answer":
            "The limit keeps messages positive, concise, and focused on specific strengths."
      },
      {
        "question": "Can I hide badges I've received?",
        "answer":
            "Yes, you can manage the visibility of any badge you've received through your Badge Management page. Hidden badges will still be visible to you but won't appear on your public profile. You can toggle visibility at any time."
      },
      {
        "question": "Can I award multiple badges to the same person?",
        "answer":
            "Yes, you can award different badges to the same person if they’ve demonstrated multiple strengths."
      },
      {
        "question": "How are badges displayed on my profile?",
        "answer":
            "Badges appear in your profile’s badge section, highlighting the qualities recognized by others."
      },
      {
        "question": "Can I edit or delete a badge I've awarded?",
        "answer":
            "No, once a badge is awarded, it cannot be edited or removed to preserve authenticity."
      },
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const Text(
            "Frequently Asked Questions",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),

          // Subtitle
          Text(
            "Common questions about the badge system",
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 16),

          // FAQ List
          ...faqs.map((faq) {
            return Column(
              children: [
                ExpansionTile(
                  tilePadding: EdgeInsets.zero,
                  childrenPadding: const EdgeInsets.only(left: 0, right: 0, bottom: 12),
                  title: Text(
                    faq["question"]!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  iconColor: Colors.black,
                  collapsedIconColor: Colors.black,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Text(
                        faq["answer"]!,
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(color: Colors.grey.shade300, height: 1),
              ],
            );
          }),
        ],
      ),
    );
  }
}
