import 'package:flutter/material.dart';

class MedicationDetailsPage extends StatelessWidget {
  final Map<String, dynamic> med;

  const MedicationDetailsPage({super.key, required this.med});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(foregroundColor: Colors.white, title: Text("${med['name']} Details"), backgroundColor: Theme.of(context).primaryColor),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            ListTile(leading: const Icon(Icons.description), title: const Text("Dosage"), subtitle: Text(med['dose'])),
            ListTile(leading: const Icon(Icons.schedule), title: const Text("Time to Take"), subtitle: Text(med['time'])),
            if (med['pillsLeft'] != null) ListTile(leading: const Icon(Icons.local_pharmacy), title: const Text("Pills Left"), subtitle: Text("${med['pillsLeft']} remaining")),
            ListTile(leading: const Icon(Icons.healing), title: const Text("Medication Type"), subtitle: Text(med['type'])),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Refill request sent for ${med['name']}")));
              },
              icon: const Icon(Icons.local_pharmacy),
              label: const Text("Request Refill"),
            ),
          ],
        ),
      ),
    );
  }
}
