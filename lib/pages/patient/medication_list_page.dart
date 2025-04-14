import 'package:flutter/material.dart';

class MedicationListPage extends StatefulWidget {
  const MedicationListPage({super.key});

  @override
  State<MedicationListPage> createState() => _MedicationListPageState();
}

class _MedicationListPageState extends State<MedicationListPage> {
  // Mock medication data
  List<Map<String, dynamic>> medications = [
    {"name": "Aspirin", "dose": "100mg", "time": "8:00 AM", "taken": false, "pillsLeft": 5, "type": "pill"},
    {"name": "Vitamin D", "dose": "2000 IU", "time": "12:00 PM", "taken": true, "pillsLeft": 2, "type": "pill"},
    {"name": "Insulin", "dose": "10 units", "time": "6:00 PM", "taken": false, "pillsLeft": null, "type": "injection"},
  ];

  // Device status mock data
  bool _isDeviceConnected = true;
  String _lastSyncedTime = "3 minutes ago";

  // Toggle medication status
  void toggleTaken(int index) {
    setState(() {
      medications[index]['taken'] = !medications[index]['taken'];
    });
  }

  // Request refill
  void requestRefill(String name) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Refill request sent for $name")));
  }

  // Show medication details
  void showDetails(Map<String, dynamic> med) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder:
          (_) => Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("${med['name']} Details", style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 20),
                ListTile(leading: const Icon(Icons.description), title: const Text("Dosage"), subtitle: Text(med['dose'])),
                ListTile(leading: const Icon(Icons.schedule), title: const Text("Time to take"), subtitle: Text(med['time'])),
                if (med['pillsLeft'] != null) ListTile(leading: const Icon(Icons.local_pharmacy), title: const Text("Pills Left"), subtitle: Text("${med['pillsLeft']} remaining")),
              ],
            ),
          ),
    );
  }

  // Device actions
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

  // Icon for medication type
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
          // Device Status Card
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
            final int index = medications.indexOf(med);
            final isLow = med['pillsLeft'] != null && med['pillsLeft'] <= 5;

            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              child: InkWell(
                onTap: () => showDetails(med),
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
                          if (isLow) IconButton(onPressed: () => requestRefill(med['name']), icon: const Icon(Icons.local_pharmacy, size: 18, color: Colors.red), tooltip: "Refill"),
                          Switch(value: med['taken'], onChanged: (_) => toggleTaken(index)),
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
