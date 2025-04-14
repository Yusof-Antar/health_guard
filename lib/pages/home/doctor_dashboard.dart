import 'package:flutter/material.dart';

class DoctorDashboard extends StatelessWidget {
  const DoctorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final patients = [
      {"name": "John Doe", "meds": "3 medications", "status": "2 due soon"},
      {"name": "Sarah Lee", "meds": "1 medication", "status": "All taken"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Doctor Dashboard", style: TextStyle(color: Colors.white)), automaticallyImplyLeading: false, backgroundColor: theme.primaryColor),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome back 👨‍⚕️", style: theme.textTheme.headlineSmall),
            const Text("Your patients today", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 24),

            Expanded(
              child: ListView.separated(
                itemCount: patients.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final patient = patients[index];
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: CircleAvatar(backgroundColor: Colors.blue[100], child: const Icon(Icons.person, color: Colors.blue)),
                      title: Text(patient["name"]!),
                      subtitle: Text("${patient["meds"]} • ${patient["status"]}"),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        // TODO: Navigate to PatientDetailPage
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
