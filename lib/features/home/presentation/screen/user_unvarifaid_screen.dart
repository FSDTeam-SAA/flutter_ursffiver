import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class UnVerificationScreen extends StatefulWidget {
  const UnVerificationScreen({super.key});

  @override
  State<UnVerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<UnVerificationScreen> {
  String? fileName;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        fileName = result.files.single.name;
      });
      debugPrint("Selected file: ${result.files.single.path}");
    } else {
      debugPrint("File picking canceled");
    }
  }

  Future<void> takeImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        fileName = image.name;
      });
      debugPrint("Captured image: ${image.path}");
    } else {
      debugPrint("Image capture canceled");
    }
  }

  void _showDocumentOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: const Text(
            "Select Document Source",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  pickFile();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.blue.shade50,
                ),
                child: const Text(
                  "Upload Document",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  takeImage();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.blue.shade50,
                ),
                child: const Text(
                  "Take Image",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("•  ",
              style:
                  TextStyle(fontSize: 14, height: 1.5, color: Colors.black87)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                  fontSize: 14, height: 1.5, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStep(int number, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: Colors.blue.shade50,
            child: Text(
              "$number",
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.blue,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Verification"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Top Card: Not Verified
            Container(
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
                  // Status Row
                  Row(
                    children: const [
                      Icon(Icons.info_outline, color: Colors.grey),
                      SizedBox(width: 8),
                      Text(
                        "User Verification Status: Not Verified",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Why Get Verified
                  const Text(
                    "Why Get Verified?",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Getting verified allows you to connect with more users and build trust. Verified users can choose to only connect with other verified users.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Benefits box
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Benefits of Verification:",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        buildBullet("Enhanced trust and credibility"),
                        buildBullet("Optional access to verified-only user groups"),
                        buildBullet("Priority in search results"),
                        buildBullet("Green verification badge on your profile"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Document Selection Button
                  const Text(
                    "Select Document Type",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: () => _showDocumentOptions(context),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.blue),
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Choose your identification document",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Upload box (display if a file or image is selected)
                  if (fileName != null) ...[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.insert_drive_file,
                                  color: Colors.blue),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  fileName!,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 20),

            // How Verification Works Card
            Container(
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
                  const Text(
                    "How Verification Works",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),

                  buildStep(1, "Submit Document",
                      "Select and submit a government-issued ID for verification."),
                  buildStep(2, "Review Process",
                      "Our team reviews your document within 1-2 business days."),
                  buildStep(3, "Get Verified",
                      "Once approved, you'll receive a verification badge and access to all benefits."),

                  Divider(color: Colors.grey.shade300, height: 32),

                  const Text(
                    "Privacy & Security",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Your verification documents are processed securely and are not stored permanently. We only verify your identity and do not share your personal information with other users.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.5,
                    ),
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