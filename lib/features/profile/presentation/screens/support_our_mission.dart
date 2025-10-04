import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/theme/app_colors.dart';
import 'package:flutter_ursffiver/core/theme/app_gap.dart';
import 'package:flutter_ursffiver/core/theme/text_style.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Support Our Mission')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF3F42EE), Color(0xFF898BF5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Card(
                  color: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.people_alt_outlined,
                          color: Colors.white,
                          size: 40,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Fostering Genuine Human Connections',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "SPEET was created to combat loneliness by prioritizing authentic human connections over virtual interactions. We're committed to keeping SPEET ad-free as long as possible, so you can connect without distractions. Real social bonds are essential for wellbeing—as vital as healthy sleep and nutritious food for our longevity and happiness.",
                          textAlign: TextAlign.center,
                          style: AppText.xsRegular_12_400.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title Row
                      Row(
                        children: const [
                          Icon(
                            Icons.favorite_border,
                            color: Colors.red,
                            size: 28,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Our Mission',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Blue box: Our Ad-Free Promise
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFFE8F0FE,
                          ), // light blue background
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Our Ad-Free Promise',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4A90E2),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        'We’re committed to keeping SPEET ad-free as long as possible. ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        'No invasive tracking, no data harvesting, no algorithmic manipulation. Just authentic connections between real people.',
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                ],
                              ),
                              style: TextStyle(fontSize: 14, height: 1.5),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Body text
                      const Text(
                        "We strive to keep SPEET’s core features free and accessible to everyone. However, maintaining a reliable platform without advertising revenue requires community support. Your contribution helps us stay independent and user-focused.",
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F0FE),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'What Your Support Enables:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Bullet items with icons
                            Row(
                              children: const [
                                Icon(
                                  Icons.verified_user,
                                  color: Color(0xFF4A90E2),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    "Enhanced safety and verification systems",
                                    style: TextStyle(fontSize: 14, height: 1.5),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: const [
                                Icon(Icons.storage, color: Color(0xFF4A90E2)),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    "Reliable servers for growing user base",
                                    style: TextStyle(fontSize: 14, height: 1.5),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: const [
                                Icon(Icons.people, color: Color(0xFF4A90E2)),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    "Continued development of connection features",
                                    style: TextStyle(fontSize: 14, height: 1.5),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: const [
                                Icon(Icons.flash_on, color: Color(0xFF4A90E2)),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    "Ad-free experience without data monetization",
                                    style: TextStyle(fontSize: 14, height: 1.5),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16),
              Text(
                'What Your Support Enables:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.security, color: Color(0xFF4A90E2)),
                          SizedBox(width: 8),
                          Text('Enhanced safety and verification systems'),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.group, color: Color(0xFF4A90E2)),
                          SizedBox(width: 8),
                          Text('Reliable servers for growing user base'),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.favorite, color: Color(0xFF4A90E2)),
                          SizedBox(width: 8),
                          Text('Continued development of connection features'),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.monetization_on, color: Color(0xFF4A90E2)),
                          SizedBox(width: 8),
                          Text('Ad-free experience without data monetization'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Card(
                //color: Color(0xFF4A90E2),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.payment_outlined,
                            color: Color(0xFF4A90E2),
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Support SPEET',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Choose an amount that feels right for you',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Gap.h20,
                      Row(
                        children: [
                          Icon(
                            Icons.payment_outlined,
                            color: Color(0xFF4A90E2),
                            size: 16,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Quick Contribution',
                            style: TextStyle(
                              //fontSize: 1,
                              //fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      // ElevatedButton.icon(
                      //   onPressed: () {},
                      //   style: ElevatedButton.styleFrom(
                      //     foregroundColor: AppColors.white,
                      //     backgroundColor: AppColors.primarybutton,
                      //     minimumSize: const Size(double.infinity, 48),
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(
                      //         12,
                      //       ),
                      //       side: const BorderSide(
                      //         color: AppColors.primarybutton,
                      //         width: 2,
                      //       ),
                      //     ),
                      //     elevation: 4,
                      //   ),
                      //   icon: const Icon(Icons.message_outlined),
                      //   label: const Text(
                      //     'Quick Contribution',
                      //     style: TextStyle(
                      //       fontSize: 16,
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      // ),
                      ElevatedButton.icon(
                        onPressed: () {
                          final TextEditingController _controller =
                              TextEditingController();

                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              title: const Text(
                                "Quick Contribution",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              content: ContributionDialogField(
                                controller: _controller,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: AppColors.white,
                          backgroundColor: AppColors.primarybutton,
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(
                              color: AppColors.primarybutton,
                              width: 2,
                            ),
                          ),
                          elevation: 4,
                        ),
                        icon: const Icon(Icons.message_outlined),
                        label: const Text(
                          'Quick Contribution',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Secure payment processing - One-time contribution - No recurring charges',
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContributionDialogField extends StatelessWidget {
  final TextEditingController controller;

  const ContributionDialogField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "Enter a short note with your contribution",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: Colors.black54),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "Write your message...",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
          ),
          maxLines: 3,
        ),
        Gap.h12,
        TextField(
          //controller: controller,
          decoration: InputDecoration(
            hintText: "Enter Ammount...",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: () {
                String message = controller.text.trim();
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Contribution submitted: $message")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primarybutton,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Submit"),
            ),
          ],
        ),
      ],
    );
  }
}
