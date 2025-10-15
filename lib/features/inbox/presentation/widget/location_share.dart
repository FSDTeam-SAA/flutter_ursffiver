import 'package:flutter/material.dart';

class LocationShare extends StatelessWidget {
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  const LocationShare({
    super.key,
    required this.onAccept,
    required this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color.fromARGB(255, 187, 199, 225),
      insetPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Row with Icon
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.location_on_outlined,
                    color: Colors.blue, size: 28),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Live Location Sharing",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text.rich(
                        TextSpan(
                          text: "Ursusus ",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: "wants to share live locations with you",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Info Box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF4FF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                "You'll both see each other's real-time location on a map for 30 minutes",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black87,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    icon: const Icon(Icons.check, color: Colors.white, size: 18),
                    label: const Text(
                      "Accept",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      onAccept();
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    icon: const Icon(Icons.close, color: Colors.red, size: 18),
                    label: const Text(
                      "Decline",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      onDecline();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
