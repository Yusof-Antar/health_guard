import 'package:flutter/material.dart';
import 'dart:math';

class PatientHomePage extends StatefulWidget {
  const PatientHomePage({super.key});

  @override
  State<PatientHomePage> createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {
  // Mock data for today's medications
  final List<Map<String, dynamic>> _medications = [
    {"name": "Aspirin", "dose": "100mg", "time": "8:00 AM", "taken": false, "pillsLeft": 5},
    {"name": "Vitamin D", "dose": "2000 IU", "time": "12:00 PM", "taken": true, "pillsLeft": 2},
    {"name": "Insulin", "dose": "10 units", "time": "6:00 PM", "taken": false, "pillsLeft": null},
  ];

  // Wellness tips
  final List<String> _wellnessTips = [
    "💧 Stay hydrated! Drink at least 8 glasses of water today.",
    "🧘 Take 5 minutes to stretch your body.",
    "😴 Get at least 7 hours of sleep tonight.",
    "🍎 Eat at least one fruit today.",
    "🚶‍♂️ Go for a short walk if you can!",
  ];

  // Randomly selected wellness tip
  String _currentTip = "";

  @override
  void initState() {
    super.initState();
    _currentTip = _wellnessTips[Random().nextInt(_wellnessTips.length)];
  }

  // Toggle medication status
  void _toggleTaken(int index) {
    setState(() {
      _medications[index]['taken'] = !_medications[index]['taken'];
    });
  }

  // Request refill for a medication
  void _requestRefill(String name) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Refill request sent for $name")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HealthGuard", style: TextStyle(color: Colors.white)),
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Welcome Header
          Text("Welcome back 👋", style: Theme.of(context).textTheme.headlineSmall),
          const Text("Here's your medication summary", style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),

          // Today's Medications Section
          Text("📅 Today's Medications", style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          ..._medications.map((med) {
            final int index = _medications.indexOf(med);
            final bool isLow = med['pillsLeft'] != null && med['pillsLeft'] <= 5;
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              child: ListTile(
                leading: CircleAvatar(backgroundColor: Colors.blue[50], child: Icon(Icons.medication, color: Colors.blue)),
                title: Text(med['name']),
                subtitle: Text("${med['dose']} • ${med['time']}"),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Switch(value: med['taken'], onChanged: (_) => _toggleTaken(index)),
                    if (isLow) TextButton(onPressed: () => _requestRefill(med['name']), child: const Text("Refill", style: TextStyle(fontSize: 12))),
                  ],
                ),
              ),
            );
          }),

          // Wellness Tip Section
          const SizedBox(height: 24),
          Text("💡 Wellness Tip", style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          Card(
            color: Colors.lightBlue[50],
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(padding: const EdgeInsets.all(16), child: Text(_currentTip, style: const TextStyle(fontSize: 14))),
          ),
        ],
      ),
    );
  }
}
