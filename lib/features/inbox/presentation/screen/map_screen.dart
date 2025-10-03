import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class LiveLocationSharingWidget extends StatefulWidget {
  final String sharingWith;
  final String userInitials;
  final String userName;

  const LiveLocationSharingWidget({
    super.key,
    required this.sharingWith,
    required this.userInitials,
    required this.userName,
  });

  @override
  State<LiveLocationSharingWidget> createState() =>
      _LiveLocationSharingWidgetState();
}

class _LiveLocationSharingWidgetState extends State<LiveLocationSharingWidget> {
  late Timer _timer;
  int _seconds = 29 * 60 + 44;

  GoogleMapController? _mapController;
  final LatLng _initialPosition = const LatLng(23.8103, 90.4125); // Example: Dhaka

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            /// Header
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(color: Colors.black12),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.blue),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Live Location Sharing",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "Sharing with ${widget.sharingWith}",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.access_time,
                              size: 18, color: Colors.blue),
                          const SizedBox(width: 4),
                          Text(
                            _formatTime(_seconds),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: const BorderSide(color: Colors.red),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Stop Sharing"),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close, color: Colors.black54),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /// Map + marker + controls
            Expanded(
              child: Stack(
                children: [
                  // Google Map
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: _initialPosition,
                      zoom: 14,
                    ),
                    onMapCreated: (controller) {
                      _mapController = controller;
                    },
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                  ),

                  // Custom center marker (user initials)
                  Center(
                    child: Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                      ),
                      child: Center(
                        child: Text(
                          widget.userInitials,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Zoom buttons
                  Positioned(
                    right: 16,
                    top: MediaQuery.of(context).size.height * 0.25,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () => _mapController?.animateCamera(
                            CameraUpdate.zoomIn(),
                          ),
                          child: _zoomButton(Icons.add),
                        ),
                        _divider(),
                        GestureDetector(
                          onTap: () => _mapController?.animateCamera(
                            CameraUpdate.zoomOut(),
                          ),
                          child: _zoomButton(Icons.remove),
                        ),
                      ],
                    ),
                  ),

                  // Location button
                  Positioned(
                    right: 16,
                    bottom: 80,
                    child: GestureDetector(
                      onTap: () => _mapController?.animateCamera(
                        CameraUpdate.newLatLng(_initialPosition),
                      ),
                      child: _circleButton(Icons.my_location),
                    ),
                  ),
                ],
              ),
            ),

            /// Bottom legend
            Container(
              padding: const EdgeInsets.all(12),
              color: Colors.white,
              child: Row(
                children: [
                  _legendDot(
                      color: Colors.blue, label: "${widget.userName} (You)"),
                  const SizedBox(width: 24),
                  _legendDot(color: Colors.red, label: widget.sharingWith),
                  const Spacer(),
                  Text(
                    "Updates every 2 seconds",
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _zoomButton(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Icon(icon, color: Colors.black54),
    );
  }

  Widget _divider() => Container(
        width: 40,
        height: 1,
        color: Colors.grey[300],
      );

  Widget _circleButton(IconData icon) {
    return Container(
      width: 48,
      height: 48,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.black54),
    );
  }

  Widget _legendDot({required Color color, required String label}) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 13)),
      ],
    );
  }
}
