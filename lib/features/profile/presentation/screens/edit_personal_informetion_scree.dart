// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class MyProfileScreen extends StatefulWidget {
//   const MyProfileScreen({super.key});

//   @override
//   State<MyProfileScreen> createState() => _MyProfileScreenState();
// }

// class _MyProfileScreenState extends State<MyProfileScreen> {
//   bool isVerified = true;
//   String verifiedDate = "12/10/2025";
//   bool isEditing = false; // <--- Track editing state

//   final TextEditingController firstNameController =
//       TextEditingController(text: "Urs");
//   final TextEditingController lastNameController =
//       TextEditingController(text: "Fischer");
//   final TextEditingController userNameController =
//       TextEditingController(text: "URSUSUS");
//   final TextEditingController emailController =
//       TextEditingController(text: "hello@example.com");
//   final TextEditingController genderController =
//       TextEditingController(text: "Male");
//   final TextEditingController ageRangeController =
//       TextEditingController(text: "50 - 60");
//   final TextEditingController bioController =
//       TextEditingController(text: "This Life Rocks. 🤘");

//   File? _profileImage;
//   final ImagePicker _picker = ImagePicker();

//   Future<void> _pickImage(ImageSource source) async {
//     if (!isEditing) return; // prevent when not editing
//     final pickedFile =
//         await _picker.pickImage(source: source, imageQuality: 80);
//     if (pickedFile != null) {
//       setState(() {
//         _profileImage = File(pickedFile.path);
//       });
//     }
//   }

//   void _removePhoto() {
//     if (!isEditing) return;
//     setState(() {
//       _profileImage = null;
//     });
//   }

//   void _toggleEdit() {
//     setState(() {
//       isEditing = !isEditing;
//     });
//   }

//   void _saveChanges() {
//     setState(() {
//       isEditing = false;
//     });
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Profile changes saved!")),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           'My Profile',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         centerTitle: false,
//         actions: [
//           TextButton(
//             onPressed: _toggleEdit,
//             child: Text(
//               isEditing ? 'Cancel' : 'Edit Profile',
//               style: const TextStyle(color: Colors.blue, fontSize: 16),
//             ),
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildVerificationCard(),
//                 const SizedBox(height: 24),
//                 _buildProfilePhotoSection(),
//                 const SizedBox(height: 32),
//                 _buildFormField('First Name', firstNameController),
//                 const SizedBox(height: 20),
//                 _buildFormField('Last Name', lastNameController),
//                 const SizedBox(height: 20),
//                 _buildFormField('User Name', userNameController),
//                 const SizedBox(height: 20),
//                 _buildEmailField(),
//                 const SizedBox(height: 20),
//                 _buildFormField('Gender', genderController,
//                     helperText:
//                         'Your gender can be shown based on your privacy settings'),
//                 const SizedBox(height: 20),
//                 _buildFormField('Age Range', ageRangeController,
//                     helperText:
//                         'Your age range helps match you with people in similar life stages'),
//                 const SizedBox(height: 20),
//                 _buildBioField(),
//                 const SizedBox(height: 80),
//               ],
//             ),
//           ),

//           // Save Changes button (only in edit mode)
//           if (isEditing)
//             Positioned(
//               bottom: 16,
//               left: 16,
//               right: 16,
//               child: ElevatedButton(
//                 onPressed: _saveChanges,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue,
//                   minimumSize: const Size(double.infinity, 50),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8)),
//                 ),
//                 child: const Text(
//                   "Save Changes",
//                   style: TextStyle(color: Colors.white, fontSize: 16),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildVerificationCard() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: const Color(0xFFE8F4FD),
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: const Color(0xFFB3D9FF)),
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(4),
//             decoration: const BoxDecoration(
//               color: Colors.green,
//               shape: BoxShape.circle,
//             ),
//             child: const Icon(
//               Icons.check,
//               color: Colors.white,
//               size: 16,
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 RichText(
//                   text: const TextSpan(
//                     style: TextStyle(color: Colors.black, fontSize: 14),
//                     children: [
//                       TextSpan(text: 'User Verification Status: '),
//                       TextSpan(
//                         text: 'Verified',
//                         style: TextStyle(
//                           color: Colors.green,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   'Verified On: $verifiedDate',
//                   style: TextStyle(color: Colors.grey[600], fontSize: 12),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildProfilePhotoSection() {
//     return Center(
//       child: Column(
//         children: [
//           CircleAvatar(
//             radius: 50,
//             backgroundImage: _profileImage != null
//                 ? FileImage(_profileImage!)
//                 : const NetworkImage(
//                         'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face')
//                     as ImageProvider,
//           ),
//           const SizedBox(height: 20),
//           Row(
//             children: [
//               Expanded(
//                 child: _buildPhotoButton(Icons.upload, 'Upload Photo',
//                     () => _pickImage(ImageSource.gallery)),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: _buildPhotoButton(Icons.camera_alt, 'Take Photo',
//                     () => _pickImage(ImageSource.camera)),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           SizedBox(
//             width: double.infinity,
//             child: OutlinedButton.icon(
//               onPressed: _removePhoto,
//               icon: const Icon(Icons.delete, color: Colors.red, size: 18),
//               label: const Text('Remove Photo',
//                   style: TextStyle(color: Colors.red)),
//               style: OutlinedButton.styleFrom(
//                 foregroundColor: Colors.red,
//                 side: const BorderSide(color: Colors.red),
//                 minimumSize: const Size(double.infinity, 48),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPhotoButton(IconData icon, String label, VoidCallback onTap) {
//     return OutlinedButton.icon(
//       onPressed: isEditing ? onTap : null, // disabled if not editing
//       icon: Icon(icon, size: 18),
//       label: Text(label),
//       style: OutlinedButton.styleFrom(
//         foregroundColor: Colors.black,
//         side: BorderSide(color: Colors.grey[300]!),
//         minimumSize: const Size(double.infinity, 48),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//       ),
//     );
//   }

//   Widget _buildFormField(String label, TextEditingController controller,
//       {String? helperText}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label,
//             style: const TextStyle(
//                 color: Colors.black,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500)),
//         const SizedBox(height: 8),
//         TextFormField(
//           controller: controller,
//           enabled: isEditing, // <--- toggle editable
//           style: const TextStyle(color: Colors.black),
//           decoration: InputDecoration(
//             filled: true,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide(color: Colors.grey[300]!),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide(color: Colors.grey[300]!),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.blue),
//             ),
//             contentPadding:
//                 const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           ),
//         ),
//         if (helperText != null) ...[
//           const SizedBox(height: 4),
//           Text(helperText,
//               style: TextStyle(color: Colors.grey[600], fontSize: 12)),
//         ]
//       ],
//     );
//   }

//   Widget _buildEmailField() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             const Text('Email Address',
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500)),
//             const Spacer(),
//             Container(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//               child: const Text(
//                 'Verified',
//                 style: TextStyle(
//                   color: Colors.lightGreen,
//                   fontSize: 12,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           controller: emailController,
//           enabled: isEditing,
//           style: const TextStyle(color: Colors.black),
//           decoration: InputDecoration(
//             filled: true,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide(color: Colors.grey[300]!),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide(color: Colors.grey[300]!),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.blue),
//             ),
//             contentPadding:
//                 const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildBioField() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             const Text('Bio (Optional)',
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500)),
//             const Spacer(),
//             Text('0/500',
//                 style: TextStyle(color: Colors.grey[600], fontSize: 12)),
//           ],
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           controller: bioController,
//           maxLines: 4,
//           maxLength: 500,
//           enabled: isEditing,
//           style: const TextStyle(color: Colors.black),
//           decoration: InputDecoration(
//             filled: true,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide(color: Colors.grey[300]!),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide(color: Colors.grey[300]!),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.blue),
//             ),
//             contentPadding:
//                 const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//             counterText: '',
//           ),
//         ),
//         const SizedBox(height: 4),
//         Text('Tell the world a bit about yourself',
//             style: TextStyle(color: Colors.grey[600], fontSize: 12)),
//       ],
//     );
//   }
// }






import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  bool isVerified = true;
  String verifiedDate = "12/10/2025";
  bool isEditing = false; // <--- Track editing state

  final TextEditingController firstNameController =
      TextEditingController(text: "Urs");
  final TextEditingController lastNameController =
      TextEditingController(text: "Fischer");
  final TextEditingController userNameController =
      TextEditingController(text: "URSUSUS");
  final TextEditingController emailController =
      TextEditingController(text: "hello@example.com");
  final TextEditingController genderController =
      TextEditingController(text: "Male");
  final TextEditingController ageRangeController =
      TextEditingController(text: "50 - 60");
  final TextEditingController bioController =
      TextEditingController(text: "This Life Rocks. 🤘");

  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    if (!isEditing) return; // prevent when not editing
    final pickedFile =
        await _picker.pickImage(source: source, imageQuality: 80);
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
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profile changes saved!")),
    );
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
              style: const TextStyle(color: Colors.blue, fontSize: 16),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildVerificationCard(),
            const SizedBox(height: 24),
            _buildProfilePhotoSection(),
            const SizedBox(height: 32),
            _buildFormField('First Name', firstNameController),
            const SizedBox(height: 20),
            _buildFormField('Last Name', lastNameController),
            const SizedBox(height: 20),
            _buildFormField('User Name', userNameController),
            const SizedBox(height: 20),
            _buildEmailField(),
            const SizedBox(height: 20),
            _buildFormField('Gender', genderController,
                helperText:
                    'Your gender can be shown based on your privacy settings'),
            const SizedBox(height: 20),
            _buildFormField('Age Range', ageRangeController,
                helperText:
                    'Your age range helps match you with people in similar life stages'),
            const SizedBox(height: 20),
            _buildBioField(),
            const SizedBox(height: 20),

            // Save button just below Bio field
            if (isEditing)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveChanges,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
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

  Widget _buildVerificationCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F4FD),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFB3D9FF)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check,
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
                  text: const TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 14),
                    children: [
                      TextSpan(text: 'User Verification Status: '),
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
                Text(
                  'Verified On: $verifiedDate',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
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
                        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face')
                    as ImageProvider,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildPhotoButton(Icons.upload, 'Upload Photo',
                    () => _pickImage(ImageSource.gallery)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildPhotoButton(Icons.camera_alt, 'Take Photo',
                    () => _pickImage(ImageSource.camera)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: isEditing ? _removePhoto : null,
              icon: const Icon(Icons.delete, color: Colors.red, size: 18),
              label: const Text('Remove Photo',
                  style: TextStyle(color: Colors.red)),
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
        ],
      ),
    );
  }

  Widget _buildPhotoButton(IconData icon, String label, VoidCallback onTap) {
    return OutlinedButton.icon(
      onPressed: isEditing ? onTap : null, // disabled if not editing
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.black,
        side: BorderSide(color: Colors.grey[300]!),
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildFormField(String label, TextEditingController controller,
      {String? helperText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          enabled: isEditing, // <--- toggle editable
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
              borderSide: const BorderSide(color: Colors.blue),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        if (helperText != null) ...[
          const SizedBox(height: 4),
          Text(helperText,
              style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        ]
      ],
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Email Address',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500)),
            const Spacer(),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: const Text(
                'Verified',
                style: TextStyle(
                  color: Colors.lightGreen,
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
              borderSide: const BorderSide(color: Colors.blue),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
            const Text('Bio (Optional)',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500)),
            const Spacer(),
            Text('0/500',
                style: TextStyle(color: Colors.grey[600], fontSize: 12)),
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
              borderSide: const BorderSide(color: Colors.blue),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            counterText: '',
          ),
        ),
        const SizedBox(height: 4),
        Text('Tell the world a bit about yourself',
            style: TextStyle(color: Colors.grey[600], fontSize: 12)),
      ],
    );
  }
}
