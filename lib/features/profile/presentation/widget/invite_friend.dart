import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class InviteFriend extends StatelessWidget {
  final String shareLink;

  const InviteFriend({super.key, required this.shareLink});

  /// ------------ SAFE SHARE ACTIONS for Android + iOS ------------ ///

  void _shareToWhatsApp(String url) async {
    final uri = Uri.parse("https://wa.me/?text=$url");

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Share.share(url);
    }
  }

  void _shareToFacebook(String url) async {
    final uri = Uri.parse("https://www.facebook.com/sharer/sharer.php?u=$url");

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Share.share(url);
    }
  }

  void _shareToInstagram(String url) async {
    Share.share("Check this out: $url");
  }

  void _shareToTwitter(String url) async {
    final uri = Uri.parse("https://twitter.com/intent/tweet?text=$url");

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Share.share(url);
    }
  }

  void _shareGeneric(String url) {
    Share.share(url);
  }

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
            
            /// ---------- HEADER ---------- ///
            Row(
              children: [
                const Text(
                  "Invite Friends to SPEET",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),

            const Text(
              "Share SPEET with your friends!",
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 20),

            /// ---------- SHARE LINK ---------- ///
            const Text(
              "Share Link",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
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
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy),
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

            /// ---------- QR CODE ---------- ///
            const Text(
              "QR Code",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),

            Center(
              child: QrImageView(
                data: shareLink,
                version: QrVersions.auto,
                size: 200,
              ),
            ),

            const SizedBox(height: 20),

            /// ---------- SHARE BUTTONS ---------- ///
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSocialButton(
                  imagePath: 'assets/icon/wh.png',
                  onTap: () => _shareToWhatsApp(shareLink),
                ),
                _buildSocialButton(
                  imagePath: 'assets/icon/fa.png',
                  onTap: () => _shareToFacebook(shareLink),
                ),
                _buildSocialButton(
                  imagePath: 'assets/icon/in.png',
                  onTap: () => _shareToInstagram(shareLink),
                ),
                _buildSocialButton(
                  imagePath: 'assets/icon/tw.png',
                  onTap: () => _shareToTwitter(shareLink),
                ),
                _buildSocialButton(
                  imagePath: 'assets/icon/we.png',
                  onTap: () => _shareGeneric(shareLink),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required String imagePath,
    required VoidCallback onTap,
    double size = 40,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: size,
        height: size,
        child: Image.asset(imagePath),
      ),
    );
  }
}
