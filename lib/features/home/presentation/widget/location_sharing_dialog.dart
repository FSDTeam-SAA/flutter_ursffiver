import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/theme/app_colors.dart';
import 'package:geolocator/geolocator.dart';

Future<void> showLocationPermissionDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.3),
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: const _LocationPermissionCard(),
        ),
      );
    },
  );
}

class _LocationPermissionCard extends StatelessWidget {
  const _LocationPermissionCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.location_on_rounded,
            size: 44,
            color: Colors.blue.shade700,
          ),

          const SizedBox(height: 16),

          const Text(
            "Allow Maps to access this device’s precise location?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Image(
                    image: AssetImage("assets/icon/1.png"),
                    height: 160,
                  ),
                  const SizedBox(height: 8),
                  const Text("Precise", style: TextStyle(fontSize: 16)),
                ],
              ),
              Column(
                children: [
                  Image(
                    image: AssetImage("assets/icon/2.png"),
                    height: 160,
                  ),
                  const SizedBox(height: 8),
                  const Text("Approximate", style: TextStyle(fontSize: 16)),
                ],
              ),
            ],
          ),

          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: _dialogButton(
                  title: "cancel",
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _dialogButton(
                  title: "continue",
                  onTap: () async {
                    await Geolocator.requestPermission();
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),

          // const SizedBox(height: 12),
          // _dialogButton(
          //   title: "Don't allow",
          //   bg: Colors.grey.shade200,
          //   textColor: Colors.black87,
          //   onTap: () {
          //     Navigator.pop(context);
          //   },
          // ),
        ],
      ),
    );
  }
  Widget _dialogButton({
    required String title,
    required VoidCallback onTap,
    Color? bg,
    Color? textColor,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: bg ?? AppColors.primarybutton,
          foregroundColor: textColor ?? Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
