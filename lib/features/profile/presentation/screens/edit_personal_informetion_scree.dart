import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/common/widget/reactive_button/save_button.dart';
import 'package:flutter_ursffiver/core/notifiers/button_status_notifier.dart';
import 'package:flutter_ursffiver/core/notifiers/snackbar_notifier.dart';
import 'package:flutter_ursffiver/features/badges/model/badge_model.dart';
import 'package:flutter_ursffiver/features/home/presentation/screen/user_unvarifaid_screen.dart';
import 'package:flutter_ursffiver/features/profile/controller/edit_profile_info_controller.dart';
import 'package:flutter_ursffiver/features/profile/controller/profile_data_controller.dart';
import 'package:flutter_ursffiver/features/profile/presentation/screens/profile_screen.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_ursffiver/core/theme/app_colors.dart';
import 'package:flutter_ursffiver/features/profile/presentation/widget/badgeg_widget.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final profileDataController = Get.put(ProfileDataProvider());
  final controller = Get.put(EditProfileInfoController());
  final ProcessStatusNotifier processNotifier = ProcessStatusNotifier(
    initialStatus: EnabledStatus(),
  );

  Map<BadgeModel, int> groupBadges(List<BadgeModel> badges) {
    final Map<BadgeModel, int> grouped = {};

    for (var badge in badges) {
      grouped.update(badge, (v) => v + 1, ifAbsent: () => 1);
    }

    return grouped;
  }

  final ProfileDataProvider profileController =
      Get.find<ProfileDataProvider>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<EditProfileInfoController>();
  }

  @override
  Widget build(BuildContext context) {
    profileDataController.getCurrentUserProfile().then((_) {
      controller.loadDataFromProfile();
    });

    return Obx(() {
      final bool emailChanged =
          controller.emailController.text != controller.originalEmail;
      final bool showVerified = controller.isVerified.value && !emailChanged;

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
              onPressed: () => controller.isEditing.toggle(),
              child: Text(
                controller.isEditing.value ? 'Cancel' : 'Edit Profile',
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
              Obx(() {
                if (profileController.userProfile.value?.adminVerify == true) {
                  return _buildVerificationCard(controller, showVerified);
                } else {
                  return _buildUnVerificationCard(controller);
                }
              }),
              const SizedBox(height: 24),
              _buildProfilePhotoSection(controller),
              const SizedBox(height: 20),
              // _buildFormField(
              //   'Full Name',
              //   controller.fullNameController,
              //   alwaysDisabled: true,
              // ),
              // const SizedBox(height: 20),
              _buildFormField('First Name', controller.firstNameController),
              const SizedBox(height: 20),
              _buildFormField('Last Name', controller.lastNameController),
              const SizedBox(height: 20),
              _buildFormField(
                'User Name',
                controller.usernameController,
                alwaysDisabled: true,
              ),
              const SizedBox(height: 20),
              _buildEmailField(controller, showVerified),
              const SizedBox(height: 20),
              _buildFormField(
                'Gender',
                controller.genderController,
                helperText:
                    'Your gender can be shown based on your privacy settings',
              ),
              const SizedBox(height: 20),
              _buildFormField(
                'Age Range',
                controller.ageRangeController,
                helperText:
                    'Your age range helps match you with people in similar life stages',
              ),
              const SizedBox(height: 20),
              _buildBioField(controller),
              const SizedBox(height: 20),
              if (controller.isEditing.value)
                SizedBox(
                  height: 50,
                  child: RSaveButton(
                    key: UniqueKey(),
                    width: double.infinity,
                    height: 54,
                    saveText: "Save Changes",
                    loadingText: "Saving...",
                    doneText: "Done",

                    onSaveTap: () async {
                      controller.saveProfile(
                        buttonNotifier: processNotifier,
                        snackbarNotifier: SnackbarNotifier(context: context),
                      );
                    },
                    onDone: () {
                      // Navigator.pushNamed(context, RouteNames.verifyScreen);
                      Navigator.pop(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(),
                        ),
                      );
                    },
                    buttonStatusNotifier: processNotifier,
                  ),
                ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildVerificationCard(
    EditProfileInfoController controller,
    bool showVerified,
  ) {
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
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.check, color: Colors.white, size: 16),
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
                        text: 'Verified',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                if (showVerified)
                  Text(
                    'Verified On: ${controller.verifiedDate.value}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  )
                else
                  TextButton(
                    onPressed: controller.verifyEmail,
                    child: const Text("Verify Now"),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnVerificationCard(EditProfileInfoController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFB3D9FF)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.close, color: Colors.white, size: 16),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // minimizes vertical space
              children: [
                RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 14),
                    children: [
                      TextSpan(text: 'User Verification Status: '),
                      TextSpan(
                        text: 'Unverified',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero, // remove extra padding
                    minimumSize: const Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UnVerificationScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Verify Now",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfilePhotoSection(EditProfileInfoController controller) {
    final profileController = Get.find<ProfileDataProvider>();

    return Obx(() {
      final user = profileController.userProfile.value;
      final localImage = controller.profileImage.value;

      ImageProvider imageProvider;

      if (localImage != null) {
        imageProvider = FileImage(localImage);
      } else if (user?.image != null && user!.image!.isNotEmpty) {
        imageProvider = NetworkImage(user.image!);
      } else {
        imageProvider = const NetworkImage(
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
        );
      }

      final badges = user?.badges ?? [];
      final grouped = groupBadges(badges);

      return Center(
        child: Column(
          children: [
            CircleAvatar(radius: 50, backgroundImage: imageProvider),
            const SizedBox(height: 20),

            /// Header (Name + Age + Username)
            BadgeHeader(
              nameAndAge:
                  '${controller.fullNameController.text}. ${controller.ageRangeController.text}',
              username: controller.usernameController.text,
              sectionTitle: 'Social Impact Badges',
            ),

            const SizedBox(height: 12),
            if (badges.isNotEmpty) ...[
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: grouped.entries.map((entry) {
                  final badge = entry.key;
                  final count = entry.value;

                  final badgeColor = badge.badgeColor;
                  final bgColor = badgeColor.withOpacity(0.1);

                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: badgeColor),
                      color: bgColor,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(badge.badgeIcon, color: badgeColor, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          "x$count",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: badgeColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ] else ...[
              const Text('No badges found'),
            ],

            const SizedBox(height: 20),

            /// Upload + Take Photo buttons
            Row(
              children: [
                Expanded(
                  child: _buildPhotoButton(
                    Icons.upload,
                    'Upload Photo',
                    () => controller.pickImage(ImageSource.gallery),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildPhotoButton(
                    Icons.camera_alt,
                    'Take Photo',
                    () => controller.pickImage(ImageSource.camera),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // /// Remove Photo
            // SizedBox(
            //   width: double.infinity,
            //   child: OutlinedButton.icon(
            //     onPressed: controller.isEditing.value
            //         ? controller.removePhoto
            //         : null,
            //     icon: const Icon(Icons.delete, color: Colors.red, size: 18),
            //     label: const Text(
            //       'Remove Photo',
            //       style: TextStyle(color: Colors.red),
            //     ),
            //     style: OutlinedButton.styleFrom(
            //       foregroundColor: Colors.red,
            //       side: const BorderSide(color: Colors.red),
            //       minimumSize: const Size(double.infinity, 48),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(8),
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 20),
          ],
        ),
      );
    });
  }

  Widget _buildPhotoButton(IconData icon, String label, VoidCallback onTap) {
    return OutlinedButton.icon(
      onPressed: Get.find<EditProfileInfoController>().isEditing.value
          ? onTap
          : null,
      icon: Icon(icon, size: 18, color: Colors.black87),
      label: Text(label, style: const TextStyle(color: Colors.black87)),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.grey[500]!),
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
          enabled: alwaysDisabled
              ? false
              : Get.find<EditProfileInfoController>().isEditing.value,
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

  Widget _buildEmailField(
    EditProfileInfoController controller,
    bool showVerified,
  ) {
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
            Obx(() {
              final isVerified =
                  profileController.userProfile.value?.adminVerify ?? false;

              return Text(
                isVerified ? 'Verified' : 'Unverified',
                style: TextStyle(
                  color: isVerified ? AppColors.interestsgreen : Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              );
            }),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller.emailController,
          enabled: controller.isEditing.value,
          style: const TextStyle(color: Colors.black),
          onChanged: (value) {
            controller.update();
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

  Widget _buildBioField(EditProfileInfoController controller) {
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
              '${controller.bioController.text.length}/500',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller.bioController,
          maxLines: 5,
          maxLength: 500,
          enabled: controller.isEditing.value,
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
