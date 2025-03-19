import 'package:flutter/material.dart';

class PatientsListPage extends StatelessWidget {
  const PatientsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> patients = [
      {"name": "John Doe", "adherence": "80%", "status": "Active"},
      {"name": "Jane Smith", "adherence": "90%", "status": "Active"},
      {"name": "Emily Johnson", "adherence": "70%", "status": "Inactive"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Patients List"), backgroundColor: Theme.of(context).primaryColor, foregroundColor: Colors.white),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: patients.length,
        itemBuilder: (context, index) {
          final patient = patients[index];
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              title: Text(patient["name"]!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("Adherence: ${patient["adherence"]}, Status: ${patient["status"]}"),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // Navigate to patient details or edit prescriptions
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
