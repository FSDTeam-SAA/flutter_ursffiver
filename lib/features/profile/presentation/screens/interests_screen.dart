import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/features/profile/data/model/interests_model.dart';

class InterestsScreen extends StatefulWidget {
  final List<Interest> currentInterests;

  const InterestsScreen({
    super.key,
    required this.currentInterests,
  });

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  List<Interest> selectedInterests = [];

  @override
  void initState() {
    super.initState();
    selectedInterests = widget.currentInterests;
  }

  Color _getInterestColor(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'yellow':
        return Colors.amber;
      case 'green':
        return Colors.green;
      case 'blue':
        return Colors.blue;
      case 'red':
        return Colors.red;
      case 'orange':
        return Colors.orange;
      case 'purple':
        return Colors.purple;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Interests',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Navigate to Edit Interests screen
              // You can push EditInterestsScreen here
            },
            child: const Text(
              "edit Interests",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Primary Interests",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              "Your bio will be visible to nearby users as a preview of who you are.",
              style: TextStyle(
                fontSize: 13,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: selectedInterests.map((interest) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: _getInterestColor(interest.color),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        interest.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
