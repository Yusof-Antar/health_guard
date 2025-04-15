import 'package:flutter/material.dart';
import 'medication_details_page.dart';

class MedicationListPage extends StatefulWidget {
  const MedicationListPage({super.key});

  @override
  State<MedicationListPage> createState() => _MedicationListPageState();
}

class _MedicationListPageState extends State<MedicationListPage> {
  List<Map<String, dynamic>> medications = [
    {"name": "Aspirin", "dose": "100mg", "time": "8:00 AM", "taken": false, "pillsLeft": 5, "type": "pill"},
    {"name": "Vitamin D", "dose": "2000 IU", "time": "12:00 PM", "taken": true, "pillsLeft": 2, "type": "pill"},
    {"name": "Insulin", "dose": "10 units", "time": "6:00 PM", "taken": false, "pillsLeft": null, "type": "injection"},
  ];

  bool _isDeviceConnected = true;
  String _lastSyncedTime = "3 minutes ago";

  void toggleTaken(int index) {
    setState(() => medications[index]['taken'] = !medications[index]['taken']);
  }

  void requestRefill(String name) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Refill request sent for $name")));
  }

  void _handleDeviceAction(String action) {
    switch (action) {
      case "Test Device":
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Device test successful!")));
        break;
      case "Reconnect":
        setState(() {
          _isDeviceConnected = true;
          _lastSyncedTime = "Just now";
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Device reconnected successfully!")));
        break;
    }
  }

  IconData _medTypeIcon(String type) {
    switch (type) {
      case "pill":
        return Icons.medication;
      case "injection":
        return Icons.vaccines;
      default:
        return Icons.local_hospital;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Medications", style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Device Status
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("🔌 Device Status", style: Theme.of(context).textTheme.titleMedium),
                      PopupMenuButton<String>(
                        onSelected: _handleDeviceAction,
                        itemBuilder: (context) => [const PopupMenuItem(value: "Test Device", child: Text("Test Device")), const PopupMenuItem(value: "Reconnect", child: Text("Reconnect"))],
                        icon: const Icon(Icons.more_vert),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    leading: Icon(_isDeviceConnected ? Icons.check_circle : Icons.warning, color: _isDeviceConnected ? Colors.green : Colors.red),
                    title: Text(_isDeviceConnected ? "Dispenser Connected" : "Dispenser Offline"),
                    subtitle: Text("Last synced: $_lastSyncedTime"),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Medication List
          ...medications.map((med) {
            final index = medications.indexOf(med);
            final isLow = med['pillsLeft'] != null && med['pillsLeft'] <= 5;

            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => MedicationDetailsPage(med: med)));
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(backgroundColor: Colors.blue[50], child: Icon(_medTypeIcon(med['type']), color: Colors.blue)),
                      const SizedBox(width: 16),
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
                      Row(
                        children: [
                          if (isLow) IconButton(onPressed: () => requestRefill(med['name']), icon: const Icon(Icons.local_pharmacy, size: 18, color: Colors.red), tooltip: "Refill"),
                          Switch(
                            value: med['taken'],
                            trackOutlineColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
                              return const Color.fromARGB(255, 201, 201, 201);
                            }),
                            onChanged: (_) => toggleTaken(index),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
