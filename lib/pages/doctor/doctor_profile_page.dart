import 'package:flutter/material.dart';

class DoctorProfilePage extends StatelessWidget {
  const DoctorProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Doctor's Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Dr. [Doctor's Name]", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            const Text("Specialization: General Medicine", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            const Text("Qualifications: MBBS, MD", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            const Text("Years of Experience: 10", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Edit profile logic
              },
              child: const Text("Edit Profile"),
            ),
          ],
        ),
      ),
    );
  }
}
