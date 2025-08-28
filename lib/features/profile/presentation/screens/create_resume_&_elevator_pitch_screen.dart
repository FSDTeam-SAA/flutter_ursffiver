import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/theme/app_colors.dart';
import 'package:flutter_ursffiver/features/common/textfield.dart';
import 'package:image_picker/image_picker.dart';

class RecruiterAccountPage extends StatefulWidget {
  const RecruiterAccountPage({super.key});

  @override
  State<RecruiterAccountPage> createState() => _RecruiterAccountPageState();
}

class _RecruiterAccountPageState extends State<RecruiterAccountPage> {
  final _formKey = GlobalKey<FormState>();
  File? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Recruiter Account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryTextblack,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Upload Elevator Speech Section
                const Text(
                  "Upload Your Elevator Speech",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        "Upload a 60-second elevator video pitch introducing your agency and what makes you stand out from the rest!",
                        style: TextStyle(
                          fontSize: 8,
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primarybutton,
                          minimumSize: const Size(double.infinity, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: Text(
                          "Upload/Change Elevator Pitch",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // File Upload Box
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.upload_file, color: Colors.white, size: 28),
                        SizedBox(height: 8),
                        Text(
                          "Drop your files here",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Choose File",
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Copy URL",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      //fontWeight: FontWeight.bold,
                      color: AppColors.primaryTextblack,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              //width: double.infinity,
                              height: 110,
                              width: 110,
                              color: Colors.grey[300],
                              child: _selectedImage != null
                                  ? Image.file(
                                      _selectedImage!,
                                      fit: BoxFit.cover,
                                    )
                                  : const Icon(
                                      Icons.image,
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          InkWell(
                            onTap: _pickImage,
                            borderRadius: BorderRadius.circular(4),
                            child: Container(
                              height: 20,
                              alignment: Alignment.center,
                              child: const Text(
                                "Upload Your Photo",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 3,
                      child: LabeledTextField(
                        borderColor: Colors.transparent,
                        backgroundColor: Colors.grey[100]!,
                        maxLines: 4,
                        title: ' Write Your Bio',
                        hintText: 'Write here',
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16),
                PersonalInfo(), /////////////////////////////PersonalInfo

                const SizedBox(height: 12),
                SocialMediaURL(), ////////////////////SocialMediaURL

                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                      side: BorderSide(color: Color(0xFF9EC7DC), width: 1.5),
                    ),
                  ),
                  child: Text(
                    "Add more",
                    style: TextStyle(color: AppColors.primaryTextblack),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Skills",
                  style: TextStyle(
                    color: AppColors.primaryTextblack,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 150,
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Wrap(
                    spacing: 8,
                    children: [
                      Chip(
                        label: Text("Web Design"),
                        backgroundColor: AppColors.primaryTextblack,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: Colors.white, width: 1.5),
                        ),
                      ),
                      ActionChip(label: const Text("+"), onPressed: () {}),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  "Experience",
                  style: TextStyle(
                    color: AppColors.primaryTextblack,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  "Highlight your work journey and key achievements.",
                  style: TextStyle(
                    color: AppColors.primaryTextblack,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 20),

                Experience(), /////////////////////Experiance Section

                const SizedBox(height: 12),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                          side: BorderSide(
                            color: Color(0xFF9EC7DC),
                            width: 1.5,
                          ),
                        ),
                      ),
                      child: Text(
                        "Add more +",
                        style: TextStyle(color: AppColors.primaryTextblack),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Text(
                  "Education",
                  style: TextStyle(
                    color: AppColors.primaryTextblack,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 12),
                Text("Showcase your academic background and certifications."),
                SizedBox(height: 20),

                Education(), ///////////////////// Education Section

                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                      side: BorderSide(color: Color(0xFF9EC7DC), width: 1.5),
                    ),
                  ),
                  child: Text(
                    "Add more",
                    style: TextStyle(color: AppColors.primaryTextblack),
                  ),
                ),
                SizedBox(height: 32),

                Text(
                  "Awards & Honors",
                  style: TextStyle(
                    color: AppColors.primaryTextblack,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 12),

                AwardsHonours(), /////////////////// Awards & Honors Section

                SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                      side: BorderSide(color: Color(0xFF9EC7DC), width: 1.5),
                    ),
                  ),
                  child: Text(
                    "Add more",
                    style: TextStyle(color: AppColors.primaryTextblack),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Education extends StatelessWidget {
  const Education({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Row 1
        Row(
          children: [
            Expanded(
              child: LabeledTextField(
                title: "Institution Name*",
                hintText: "e.g. Presidency University",
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: LabeledTextField(title: "City*", hintText: "e.g. Dhaka"),
            ),
          ],
        ),

        // Row 2
        Row(
          children: [
            Expanded(
              child: LabeledTextField(
                title: 'State*',
                hintText: 'e.g. Bangladesh',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: LabeledDropdown(
                title: "Degree*",
                hintText: "Select Degree",
                items: ["B.Sc.", "M.Sc.", "B.A.", "M.A.", "B.Com.", "M.Com."],
                onChanged: (v) {},
              ),
            ),
          ],
        ),

        // Row 3
        Row(
          children: [
            Expanded(
              child: LabeledTextField(
                title: "Field of Study",
                hintText: "Write here",
              ),
            ),
          ],
        ),

        // Row 4
        Row(
          children: [
            Expanded(
              child: LabeledDropdown(
                title: "Graduation Date*",
                hintText: "Month",
                items: [
                  "January",
                  "February",
                  "March",
                  "April",
                  "May",
                  "June",
                  "July",
                  "August",
                  "September",
                  "October",
                  "November",
                  "December",
                ],
                onChanged: (v) {},
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: LabeledDropdown(
                title: "Year*",
                hintText: "Year",
                items: [
                  "2018",
                  "2019",
                  "2020",
                  "2021",
                  "2022",
                  "2023",
                  "2024",
                  "2025",
                  "2026",
                  "2027",
                  "2028",
                  "2029",
                  "2030",
                  "2031",
                ],
                onChanged: (v) {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class Experience extends StatefulWidget {
  const Experience({super.key});

  @override
  State<Experience> createState() => _ExperienceState();
}

class _ExperienceState extends State<Experience> {
  String? selectedEmployer;
  String? selectedJobTitle;
  String? selectedStartMonth;
  String? selectedStartYear;
  String? selectedEndMonth;
  String? selectedEndYear;
  String? selectedCountry;
  String? selectedCity;
  String? selectedAvailability;
  String? selectedJobCategory;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Employer & Job Title
        Row(
          children: [
            Expanded(
              child: LabeledDropdown(
                title: "Employer*",
                hintText: "Select Employer",
                items: ["Company A", "Company B", "Company C"],
                value: selectedEmployer,
                onChanged: (v) => setState(() => selectedEmployer = v),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: LabeledDropdown(
                title: "Job Title*",
                hintText: "Select Job Title",
                items: ["Manager", "Developer", "Designer"],
                value: selectedJobTitle,
                onChanged: (v) => setState(() => selectedJobTitle = v),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Start Date
        Row(
          children: [
            Expanded(
              child: LabeledDropdown(
                title: "Start Date*",
                hintText: "Month",
                items: _months,
                value: selectedStartMonth,
                onChanged: (v) => setState(() => selectedStartMonth = v),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: LabeledDropdown(
                title: " ",
                hintText: "Year",
                items: _years,
                value: selectedStartYear,
                onChanged: (v) => setState(() => selectedStartYear = v),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // End Date
        Row(
          children: [
            Expanded(
              child: LabeledDropdown(
                title: "End Date*",
                hintText: "Month",
                items: _months,
                value: selectedEndMonth,
                onChanged: (v) => setState(() => selectedEndMonth = v),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: LabeledDropdown(
                title: " ",
                hintText: "Year",
                items: _years,
                value: selectedEndYear,
                onChanged: (v) => setState(() => selectedEndYear = v),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Country & City
        Row(
          children: [
            Expanded(
              child: LabeledDropdown(
                title: "Country*",
                hintText: "Select Country",
                items: ["Bangladesh", "India", "USA"],
                value: selectedCountry,
                onChanged: (v) => setState(() => selectedCountry = v),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: LabeledDropdown(
                title: "City*",
                hintText: "Select City",
                items: ["Dhaka", "Mumbai", "New York"],
                value: selectedCity,
                onChanged: (v) => setState(() => selectedCity = v),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Availability & Job Category
        Row(
          children: [
            Expanded(
              child: LabeledDropdown(
                title: "Availability to Start*",
                hintText: "Select Availability",
                items: ["Immediately", "1 Month", "3 Months"],
                value: selectedAvailability,
                onChanged: (v) => setState(() => selectedAvailability = v),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: LabeledDropdown(
                title: "Job Categories*",
                hintText: "Select Category",
                items: ["IT", "Finance", "Marketing"],
                value: selectedJobCategory,
                onChanged: (v) => setState(() => selectedJobCategory = v),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          "Job Description",
          style: TextStyle(
            color: AppColors.primaryTextblack,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                maxLines: 8,
                decoration: InputDecoration(
                  hintText: "Write here",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  List<String> get _months => [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  List<String> get _years => List.generate(15, (i) => (2015 + i).toString());
}

class AwardsHonours extends StatelessWidget {
  const AwardsHonours({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Row(
          children: [
            Expanded(
              child: LabeledTextField(
                title: "Award Title*",
                hintText: "Write Here",
              ),
            ),
          ],
        ),
        Row(
          spacing: 12,
          children: [
            Expanded(
              child: LabeledTextField(
                title: "Program Name*",
                hintText: "Write Here",
              ),
            ),
            Expanded(
              child: LabeledTextField(
                title: "Program Date*",
                hintText: "Write Here",
              ),
            ),
          ],
        ),
        //SizedBox(height: 4),
        Text(
          "Award Short Description*",
          style: TextStyle(
            color: AppColors.primaryTextblack,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        //SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                maxLines: 8,
                decoration: InputDecoration(
                  hintText: "Write here",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SocialMediaURL extends StatelessWidget {
  const SocialMediaURL({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: LabeledTextField(
                title: 'Website URL*',
                hintText: 'Enter Here',
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: LabeledTextField(
                title: 'LinkedIn URL*',
                hintText: 'Enter Here',
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: LabeledTextField(
                title: 'Twitter URL*',
                hintText: 'Enter Here',
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: LabeledTextField(
                title: 'Website URL*',
                hintText: 'Enter Here',
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: LabeledTextField(
                title: 'UPwork URL*',
                hintText: 'Enter Here',
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: LabeledTextField(
                title: 'Other URL*',
                hintText: 'Enter Here',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  String? selectedCountry;

  String? selectedCity;

  String? selectedPostalCode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: LabeledDropdown(
                title: "Title*",
                hintText: "",
                items: ["Mr.", "Ms.", "Mrs."],
                onChanged: (v) {},
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: LabeledTextField(
                title: 'First Name',
                hintText: 'e.g. Aliul',
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: LabeledTextField(
                title: 'Last Name',
                hintText: 'e.g. Aliul',
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: LabeledTextField(title: 'surname', hintText: 'e.g. Islam'),
            ),
          ],
        ),

        Row(
          children: [
            Expanded(
              child: LabeledDropdown(
                title: "Country",
                hintText: "Select Country",
                items: ["Bangladesh", "India", "USA"],
                value: selectedCountry,
                onChanged: (v) => setState(() => selectedCountry = v),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: LabeledDropdown(
                title: "City",
                hintText: "Select City",
                items: ["Dhaka", "Mumbai", "New York"],
                value: selectedCity,
                onChanged: (v) => setState(() => selectedCity = v),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: LabeledDropdown(
                title: "Postal Code*",
                hintText: 'Post Code',
                items: ["1212", "1213", "1214", "1215"],
                onChanged: (v) {},
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: LabeledTextField(
                title: 'Email',
                hintText: 'Enter your email',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
