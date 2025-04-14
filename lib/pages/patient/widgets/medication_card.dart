import 'package:flutter/material.dart';

class MedicationCard extends StatelessWidget {
  final String name;
  final String dosage;
  final String time;
  final bool isTaken;
  final int? pillsLeft;
  final VoidCallback onToggleTaken;
  final VoidCallback onRequestRefill;

  const MedicationCard({super.key, required this.name, required this.dosage, required this.time, required this.isTaken, this.pillsLeft, required this.onToggleTaken, required this.onRequestRefill});

  @override
  Widget build(BuildContext context) {
    final isLow = pillsLeft != null && pillsLeft! <= 5;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: Colors.blue[50], child: Icon(Icons.medication, color: Colors.blue)),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('$dosage • $time'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Switch(value: isTaken, onChanged: (_) => onToggleTaken()), if (isLow) TextButton(onPressed: onRequestRefill, child: const Text('Refill', style: TextStyle(fontSize: 12)))],
        ),
      ),
    );
  }
}
