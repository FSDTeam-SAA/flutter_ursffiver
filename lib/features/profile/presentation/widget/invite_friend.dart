import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_gap.dart';

class InviteFriend extends StatelessWidget {
  final String shareLink;

  const InviteFriend({super.key, required this.shareLink});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      "Invite Friends to SPEET",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.black54),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Text(
              "Share SPEET with your friends!",
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 20),

            // Share link field with copy button
            const Text(
              "Share Link",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      shareLink,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.copy,
                      size: 20,
                      color: Colors.black54,
                    ),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: shareLink));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Link copied!")),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // QR Code
            const Text(
              "QR Code",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: QrImageView(
                data: shareLink,
                version: QrVersions.auto,
                size: 256.0,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSocialButton(
                  imagePath: 'assets/icon/wh.png',
                  onTap: () {},
                ),
                _buildSocialButton(
                  imagePath: 'assets/icon/fa.png',
                  onTap: () {},
                ),
                _buildSocialButton(
                  imagePath: 'assets/icon/in.png',
                  onTap: () {},
                ),
                _buildSocialButton(
                  imagePath: 'assets/icon/tw.png',
                  onTap: () {},
                ),
                _buildSocialButton(
                  imagePath: 'assets/icon/we.png',
                  onTap: () {},
                ),
              ],
            ),

            Gap.h20,
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required String imagePath, // local asset image path
    required VoidCallback onTap,
    double size = 40, // button size
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle, // circular button
          // no border
        ),
        child: Image.asset(imagePath, fit: BoxFit.contain),
      ),
    );
  }
}
