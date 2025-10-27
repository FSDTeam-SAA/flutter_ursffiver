import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/common/widget/reactive_button/save_button.dart';
import 'package:flutter_ursffiver/core/notifiers/button_status_notifier.dart';
import 'package:flutter_ursffiver/core/notifiers/snackbar_notifier.dart';
import 'package:flutter_ursffiver/features/profile/controller/edit_profile_info_controller.dart';
import 'package:flutter_ursffiver/features/profile/controller/profile_data_controller.dart';
import 'package:flutter_ursffiver/features/profile/presentation/screens/profile_screen.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_ursffiver/core/theme/app_colors.dart';
import 'package:flutter_ursffiver/core/theme/app_gap.dart';
import 'package:flutter_ursffiver/features/profile/model/badge_model.dart';
import 'package:flutter_ursffiver/features/profile/presentation/widget/badgeg_widget.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final profileDataController = Get.put(ProfileDataController());
  final controller = Get.put(EditProfileInfoController());
  final ProcessStatusNotifier processNotifier = ProcessStatusNotifier(
    initialStatus: EnabledStatus(),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
              _buildVerificationCard(controller, showVerified),
              const SizedBox(height: 24),
              _buildProfilePhotoSection(controller),
              const SizedBox(height: 32),
              // _buildFormField(
              //   'Full Name',
              //   controller.fullNameController,
              //   alwaysDisabled: true,
              // ),
              const SizedBox(height: 20),
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
                      Navigator.push(
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

  Widget _buildProfilePhotoSection(EditProfileInfoController controller) {
    final profileController = Get.find<ProfileDataController>();

    return Obx(() {
      final user = profileController.userProfile.value;
      final localImage = controller.profileImage.value;

      ImageProvider imageProvider;

      if (localImage != null) {
        // picked from gallery or camera
        imageProvider = FileImage(localImage);
      } else if (user?.image != null && user!.image!.isNotEmpty) {
        // image from API
        imageProvider = NetworkImage(user.image!);
      } else {
        // fallback image
        imageProvider = const NetworkImage(
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
        );
      }

      return Center(
        child: Column(
          children: [
            CircleAvatar(radius: 50, backgroundImage: imageProvider),
            const SizedBox(height: 20),
            Column(
              children: [
                BadgeHeader(
                  nameAndAge:
                      '${controller.fullNameController.text}. ${controller.ageRangeController.text}',
                  username: controller.usernameController.text,
                  sectionTitle: 'Social Impact Badges',
                ),
                const SizedBox(height: 12),
              ],
            ),
            Gap.h20,
            BadgeList(
              badges: [
                IconBadgeModel(
                  icon: Icons.verified_user,
                  count: 5,
                  color: Colors.purpleAccent,
                ),
                IconBadgeModel(
                  icon: Icons.watch_later_outlined,
                  count: 4,
                  color: Colors.orangeAccent,
                ),
                IconBadgeModel(
                  icon: Icons.location_on_outlined,
                  count: 3,
                  color: Colors.blueAccent,
                ),
                IconBadgeModel(
                  icon: Icons.hearing_rounded,
                  count: 2,
                  color: Colors.pinkAccent,
                ),
                IconBadgeModel(
                  icon: Icons.lightbulb_outline,
                  count: 2,
                  color: Colors.lightBlueAccent,
                ),
                IconBadgeModel(
                  icon: Icons.link,
                  count: 2,
                  color: Colors.cyanAccent,
                ),
                IconBadgeModel(
                  icon: Icons.person_4_outlined,
                  count: 1,
                  color: Colors.greenAccent,
                ),
                IconBadgeModel(icon: Icons.star, color: Colors.orangeAccent),
              ],
            ),
            const SizedBox(height: 20),
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
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: controller.isEditing.value
                    ? controller.removePhoto
                    : null,
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
    });
  }

  Widget _buildPhotoButton(IconData icon, String label, VoidCallback onTap) {
    return OutlinedButton.icon(
      onPressed: Get.find<EditProfileInfoController>().isEditing.value
          ? onTap
          : null,
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
