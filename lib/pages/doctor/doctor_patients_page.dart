import 'package:flutter/material.dart';

class DoctorPatientsPage extends StatelessWidget {
  const DoctorPatientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Patients")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Your Patients", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            // Example of patient list
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                title: const Text("Patient XYZ"),
                subtitle: const Text("Age: 45 | Condition: Diabetes"),
                onTap: () {
                  // Handle patient details navigation
                },
              ),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                title: const Text("Patient ABC"),
                subtitle: const Text("Age: 30 | Condition: Hypertension"),
                onTap: () {
                  // Handle patient details navigation
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
