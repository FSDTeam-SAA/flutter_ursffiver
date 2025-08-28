import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/Button/button_widget.dart';
import 'package:flutter_ursffiver/core/theme/app_colors.dart';
import 'package:flutter_ursffiver/features/common/textfield.dart';

class ContactUS extends StatefulWidget {
  const ContactUS({super.key});

  @override
  State<ContactUS> createState() => _ContactUSState();
}

class _ContactUSState extends State<ContactUS> {
  final _formKey = GlobalKey<FormState>();

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
                    "Contact Us",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryTextblack,
                    ),
                  ),
                ),
 
                SizedBox(height: 40),
                SocialMediaURL(), ////////////////////SocialMediaURL

                SizedBox(height: 60),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Contact Information",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),

                    /// Email
                    const ContactInfoItem(
                      icon: Icons.email_outlined,
                      title: "Email Address",
                      subtitle: "example@gmail.com",
                    ),
                    const SizedBox(height: 24),

                    /// Phone
                    const ContactInfoItem(
                      icon: Icons.phone_outlined,
                      title: "Phone Number",
                      subtitle: "(406) 555-0120",
                    ),
                    const SizedBox(height: 24),

                    /// Location
                    const ContactInfoItem(
                      icon: Icons.location_on_outlined,
                      title: "Location",
                      subtitle: "70 Washington Square South, New York, USA",
                      isExpanded: true,
                    ),
                    const SizedBox(height: 24),

                    /// Business Hours
                    const ContactInfoItem(
                      icon: Icons.access_time,
                      title: "Business Hour",
                      subtitle: "Monday to Friday, from\n9:00 AM to 5:00 PM",
                    ),
                  ],
                ),
                
                SizedBox(height: 40),
                context.primaryButton(onPressed: () {}, text: "Send Message"),
              ],
            ),
          ),
        ),
      ),
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
                title: "Full Name*",
                hintText: "Enter Your First Name",
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: LabeledTextField(
                title: "Last Name* ",
                hintText: "Enter Your Last Name",
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: LabeledTextField(
                title: 'Address',
                hintText: 'Enter Here',
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: LabeledTextField(
                title: 'Phone Number',
                hintText: 'Enter Here',
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: LabeledTextField(
                title: 'Address',
                hintText: 'Enter Here',
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: LabeledTextField(
                title: 'Subject',
                hintText: 'Enter Here',
              ),
            ),
          ],
        ),
        //SizedBox(height: 40),
        Row(
          children: [
            Expanded(
              child: LabeledTextField(
                maxLines: 8,
                title: 'Your Company ',
                hintText: 'Tell us how we can help you',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ContactInfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isExpanded;

  const ContactInfoItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.isExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        Text(
          subtitle,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
      ],
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey.shade200,
          child: Icon(icon, color: Colors.black87, size: 32),
        ),
        const SizedBox(width: 64),
        isExpanded ? Expanded(child: content) : content,
      ],
    );
  }
}
