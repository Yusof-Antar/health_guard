import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  // Variable to switch between patient and doctor profiles
  final bool isDoctor; // Set this variable to true for doctor, false for patient

  const ProfilePage({super.key, required this.isDoctor});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Email and Role Section (Dynamic for Patient or Doctor)
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.only(bottom: 15),
            child: Container(
              width: double.infinity, // Full width
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Email", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey[600])),
                  const SizedBox(height: 5),
                  Text(
                    isDoctor ? "doctor@example.com" : "user@example.com", // Dynamic email
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    isDoctor ? "Doctor" : "Patient", // Dynamic role
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
            ),
          ),

          // Account Actions Title
          Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: Text("Account Actions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[700]))),

          // Show All Patients Button (Only for Doctors)
          if (isDoctor)
            GestureDetector(
              onTap: () {
                // Navigate to the list of patients
              },
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(Icons.people, color: Theme.of(context).primaryColor, size: 24),
                      const SizedBox(width: 15),
                      Expanded(child: Text("Show All Patients", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
                      Icon(Icons.arrow_forward_ios, color: Colors.grey[500], size: 16),
                    ],
                  ),
                ),
              ),
            ),

          // Show All Doctors Button (Only for Patients)
          if (!isDoctor)
            GestureDetector(
              onTap: () {
                // Navigate to the list of doctors
              },
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(Icons.people, color: Theme.of(context).primaryColor, size: 24),
                      const SizedBox(width: 15),
                      Expanded(child: Text("Show All Doctors", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
                      Icon(Icons.arrow_forward_ios, color: Colors.grey[500], size: 16),
                    ],
                  ),
                ),
              ),
            ),

          // Scan Dispenser Button (Only for Patients)
          if (!isDoctor)
            GestureDetector(
              onTap: () {
                // Open QR code scanner or connect to the dispenser
              },
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(Icons.qr_code_scanner, color: Theme.of(context).primaryColor, size: 24),
                      const SizedBox(width: 15),
                      Expanded(child: Text("Scan Dispenser", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
                      Icon(Icons.arrow_forward_ios, color: Colors.grey[500], size: 16),
                    ],
                  ),
                ),
              ),
            ),

          // Settings Button (Common for Both)
          GestureDetector(
            onTap: () {
              // Navigate to settings page
            },
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.settings, color: Theme.of(context).primaryColor, size: 24),
                    const SizedBox(width: 15),
                    Expanded(child: Text("Settings", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
                    Icon(Icons.arrow_forward_ios, color: Colors.grey[500], size: 16),
                  ],
                ),
              ),
            ),
          ),

          // Logout Button (Aligned to the Right)
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // Handle logout functionality
              },
              child: const Text("Logout", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.red)),
            ),
          ),
        ],
      ),
    );
  }
}
