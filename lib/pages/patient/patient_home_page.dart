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

  IconData _medTypeIcon(String? type) {
    switch (type) {
      case 'pill':
        return Icons.medication;
      case 'injection':
        return Icons.vaccines;
      case 'syrup':
        return Icons.local_drink;
      default:
        return Icons.medical_services;
    }
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
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Leading Icon
                    CircleAvatar(backgroundColor: Colors.blue[50], child: Icon(_medTypeIcon(med['type']), color: Colors.blue)),
                    const SizedBox(width: 16),

                    // Medication Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(med['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text("${med['dose']} • ${med['time']}", style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),

                    // Trailing Actions
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (isLow) IconButton(onPressed: () => _requestRefill(med['name']), icon: const Icon(Icons.local_pharmacy, size: 18, color: Colors.red), tooltip: "Refill"),
                        Switch(
                          value: med['taken'],
                          trackOutlineColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
                            return const Color.fromARGB(255, 201, 201, 201);
                          }),
                          onChanged: (_) => _toggleTaken(index),
                        ),
                      ],
                    ),
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
