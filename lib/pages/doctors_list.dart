import 'package:flutter/material.dart';

class DoctorsListPage extends StatelessWidget {
  const DoctorsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> doctors = [
      {"name": "Dr. John Doe", "specialty": "Cardiologist", "contact": "+961 1234567"},
      {"name": "Dr. Jane Smith", "specialty": "Neurologist", "contact": "+961 2345678"},
      {"name": "Dr. Emily Johnson", "specialty": "Dermatologist", "contact": "+961 3456789"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Doctors List"),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doctor = doctors[index];
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              title: Text(doctor["name"]!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("${doctor["specialty"]} | ${doctor["contact"]}"),
              trailing: IconButton(
                icon: const Icon(Icons.info_outline),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(doctor["name"]!),
                      content: Text("Specialty: ${doctor["specialty"]}\nContact: ${doctor["contact"]}"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Close"),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}