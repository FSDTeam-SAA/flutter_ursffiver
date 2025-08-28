import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/theme/app_gap.dart';
import '../../../../core/theme/app_colors.dart';

class JobHistoryScreen extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String avatarUrl;

  JobHistoryScreen({
    super.key,
    this.firstName = "Brooklyn",
    this.lastName = "Simmons",
    this.email = "brooklynsimmons@gmail.com",
    this.avatarUrl = "https://i.pravatar.cc/300",
  });

  final List<Map<String, String>> jobs = [
    {
      "title": "Backend Developer",
      "company": "Arrex Digital",
      "date": "June 17",
      "status": "Reviewing",
    },
    {
      "title": "Flutter Developer",
      "company": "Arrex Digital",
      "date": "June 17",
      "status": "Reviewing",
    },
    {
      "title": "Backend Developer",
      "company": "Arrex Digital",
      "date": "June 17",
      "status": "Not Shortlisted",
    },
    {
      "title": "Backend Developer",
      "company": "Arrex Digital",
      "date": "June 17",
      "status": "Reviewing",
    },
    {
      "title": "Backend Developer",
      "company": "Arrex Digital",
      "date": "June 17",
      "status": "Not Shortlisted",
    },
    {
      "title": "Backend Developer",
      "company": "Arrex Digital",
      "date": "June 17",
      "status": "Reviewing",
    },
    {
      "title": "Backend Developer",
      "company": "Arrex Digital",
      "date": "June 17",
      "status": "Not Shortlisted",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // GestureDetector(
                //   onTap: () => Navigator.pop(context),
                //   child: Image.asset(
                //     AssetsPath.backarrow,
                //     height: 24,
                //     width: 24,
                //   ),
                // ),
                Expanded(
                  child: Column(
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(avatarUrl),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '$firstName $lastName',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        email,
                        style: TextStyle(
                          color: AppColors.primaryTextblack,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(color: Colors.grey[300], thickness: 1, height: 32),
            const SizedBox(height: 16),
            Center(
              child: const Text(
                "Job History",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: 200,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(6),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Job Title",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Company Name",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Applied Date",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Gap.w8,
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Status",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Job List
            ...List.generate(jobs.length, (index) {
              final job = jobs[index];
              final isEven = index % 2 == 0;
              final isReviewing = job["status"] == "Reviewing";

              return Container(
                color: isEven ? Colors.grey.shade50 : Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        job["title"] ?? "",
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                    Gap.w8,
                    Expanded(
                      flex: 3,
                      child: Text(
                        job["company"] ?? "",
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        job["date"] ?? "",
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        job["status"] ?? "",
                        style: TextStyle(
                          fontSize: 12,
                          color: isReviewing ? Colors.blue : Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
