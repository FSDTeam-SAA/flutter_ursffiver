import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/theme/app_colors.dart';
import 'package:flutter_ursffiver/core/theme/app_gap.dart';
import 'package:flutter_ursffiver/features/profile/model/badge_model.dart';
import 'package:flutter_ursffiver/features/profile/presentation/widget/badgeg_widget.dart';
import 'package:image_picker/image_picker.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  String verifiedDate = "12/10/2025";
  bool isEditing = false;
  bool isVerified = true;

  /////////////////

  // Example badges
  final List<BadgeModel> badges = [
    BadgeModel(icon: Icons.verified_user, count: 5, color: Colors.purpleAccent),
    BadgeModel(
      icon: Icons.watch_later_outlined,
      count: 4,
      color: Colors.orangeAccent,
    ),
    BadgeModel(
      icon: Icons.location_on_outlined,
      count: 3,
      color: Colors.blueAccent,
    ),
    BadgeModel(icon: Icons.hearing_rounded, count: 2, color: Colors.pinkAccent),
    BadgeModel(
      icon: Icons.lightbulb_outline,
      count: 2,
      color: Colors.lightBlueAccent,
    ),
    BadgeModel(icon: Icons.link, count: 2, color: Colors.cyanAccent),
    BadgeModel(
      icon: Icons.person_4_outlined,
      count: 1,
      color: Colors.greenAccent,
    ),
    BadgeModel(icon: Icons.star, color: Colors.orangeAccent), // no count
  ];

  //////////////////

  final TextEditingController firstNameController = TextEditingController(
    text: "Urs",
  );
  final TextEditingController lastNameController = TextEditingController(
    text: "Fischer",
  );
  final TextEditingController userNameController = TextEditingController(
    text: "URSUSUS",
  );
  final TextEditingController emailController = TextEditingController(
    text: "hello@example.com",
  );
  final TextEditingController genderController = TextEditingController(
    text: "Male",
  );
  final TextEditingController ageRangeController = TextEditingController(
    text: "50 - 60",
  );
  final TextEditingController bioController = TextEditingController(
    text: "This Life Rocks. 🤘",
  );

  String originalEmail = "hello@example.com"; // Verified email
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    if (!isEditing) return;
    final pickedFile = await _picker.pickImage(
      source: source,
      imageQuality: 80,
    );
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void _removePhoto() {
    if (!isEditing) return;
    setState(() {
      _profileImage = null;
    });
  }

  void _toggleEdit() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  void _saveChanges() {
    setState(() {
      isEditing = false;
      // If email changed, mark as unverified
      if (emailController.text != originalEmail) {
        isVerified = false;
        verifiedDate = "";
      }
      originalEmail = emailController.text; // update baseline email
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Profile changes saved!")));
  }

  void _verifyEmail() {
    setState(() {
      isVerified = true;
      verifiedDate = "30/08/2025"; // Example date
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Email verified successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool emailChanged = emailController.text != originalEmail;
    bool showVerified = isVerified && !emailChanged;

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
          'My Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: _toggleEdit,
            child: Text(
              isEditing ? 'Cancel' : 'Edit Profile',
              style: const TextStyle(
                color: AppColors.primarybutton,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildVerificationCard(showVerified),
            const SizedBox(height: 24),
            _buildProfilePhotoSection(),
            const SizedBox(height: 32),

            _buildFormField(
              'First Name',
              firstNameController,
              alwaysDisabled: true,
            ),
            const SizedBox(height: 20),
            _buildFormField(
              'Last Name',
              lastNameController,
              alwaysDisabled: true,
            ),
            const SizedBox(height: 20),
            _buildFormField('User Name', userNameController),
            const SizedBox(height: 20),
            _buildEmailField(showVerified),
            const SizedBox(height: 20),
            _buildFormField(
              'Gender',
              genderController,
              helperText:
                  'Your gender can be shown based on your privacy settings',
            ),
            const SizedBox(height: 20),
            _buildFormField(
              'Age Range',
              ageRangeController,
              helperText:
                  'Your age range helps match you with people in similar life stages',
            ),
            const SizedBox(height: 20),
            _buildBioField(),
            const SizedBox(height: 20),

            if (isEditing)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveChanges,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primarybutton,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Save Changes",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildVerificationCard(bool showVerified) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFB3D9FF)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: showVerified ? Colors.green : Colors.red,
              shape: BoxShape.circle,
            ),
            child: Icon(
              showVerified ? Icons.check : Icons.close,
              color: Colors.white,
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                    children: [
                      const TextSpan(text: 'User Verification Status: '),
                      TextSpan(
                        text: showVerified ? 'Verified' : 'Unverified',
                        style: TextStyle(
                          color: showVerified ? Colors.green : Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                if (showVerified)
                  Text(
                    'Verified On: $verifiedDate',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  )
                else
                  TextButton(
                    onPressed: _verifyEmail,
                    child: const Text("Verify Now"),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfilePhotoSection() {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: _profileImage != null
                ? FileImage(_profileImage!)
                : const NetworkImage(
                        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
                      )
                      as ImageProvider,
          ),
          const SizedBox(height: 20),

          //BadgeSection(badges: _badges),

          //////////////
          Column(
            children: const [
              BadgeHeader(
                nameAndAge: 'Kien Fischer. 29 - 36',
                username: 'kimac',
                sectionTitle: 'Social Impact Badges',
              ),
              SizedBox(height: 12),
              // No badges
            ],
          ),

          Gap.h20,

          BadgeList(badges: badges),

          //////////////
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildPhotoButton(
                  Icons.upload,
                  'Upload Photo',
                  () => _pickImage(ImageSource.gallery),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildPhotoButton(
                  Icons.camera_alt,
                  'Take Photo',
                  () => _pickImage(ImageSource.camera),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: isEditing ? _removePhoto : null,
              icon: const Icon(Icons.delete, color: Colors.red, size: 18),
              label: const Text(
                'Remove Photo',
                style: TextStyle(color: Colors.red),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildPhotoButton(IconData icon, String label, VoidCallback onTap) {
    return OutlinedButton.icon(
      onPressed: isEditing ? onTap : null,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.black,
        side: BorderSide(color: Colors.grey[300]!),
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildFormField(
    String label,
    TextEditingController controller, {
    String? helperText,
    bool alwaysDisabled = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          enabled: alwaysDisabled ? false : isEditing,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.primarybutton),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
        if (helperText != null) ...[
          const SizedBox(height: 4),
          Text(
            helperText,
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
        ],
      ],
    );
  }

  Widget _buildEmailField(bool showVerified) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Email Address',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Text(
                showVerified ? 'Verified' : 'Unverified',
                style: TextStyle(
                  color: showVerified ? AppColors.interestsgreen : Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: emailController,
          enabled: isEditing,
          style: const TextStyle(color: Colors.black),
          onChanged: (value) {
            setState(() {}); // Refresh UI when email changes
          },
          decoration: InputDecoration(
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primarybutton),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBioField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Bio (Optional)',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Text(
              '0/500',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: bioController,
          maxLines: 4,
          maxLength: 500,
          enabled: isEditing,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primarybutton),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            counterText: '',
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Tell the world a bit about yourself',
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
        ),
      ],
    );
  }
}
