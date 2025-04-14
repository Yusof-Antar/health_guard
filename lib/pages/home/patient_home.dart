// ✅ Fully Interactive PatientHomePage
import 'package:flutter/material.dart';

class PatientHomePage extends StatefulWidget {
  const PatientHomePage({super.key});

  @override
  State<PatientHomePage> createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {
  final List<Map<String, String>> notifications = [
    {"title": "Refill Reminder", "message": "You have 5 pills left."},
    {"title": "Time to take your pill", "message": "Aspirin 100mg at 8:00 AM"},
    {"title": "Doctor Message", "message": "Dr. Smith updated your dosage."},
  ];

  final List<Map<String, String>> intakeHistory = [
    {"pill": "Aspirin", "time": "Today - 8:00 AM"},
    {"pill": "Vitamin D", "time": "Yesterday - 9:00 PM"},
  ];

  final List<Map<String, dynamic>> medicationSchedule = [
    {"name": "Aspirin", "time": "8:00 AM", "taken": true},
    {"name": "Vitamin D", "time": "12:00 PM", "taken": false},
    {"name": "Ibuprofen", "time": "8:00 PM", "taken": false},
  ];

  final List<String> wellnessTips = [
    "💧 Stay hydrated! Drink at least 8 glasses of water today.",
    "🧘 Take 5 minutes to stretch your body.",
    "😴 Get at least 7 hours of sleep tonight.",
    "🍎 Eat at least one fruit today.",
    "🚶‍♂️ Go for a short walk if you can!",
  ];

  late String selectedTip;

  @override
  void initState() {
    super.initState();
    selectedTip = (wellnessTips..shuffle()).first;
  }

  void _showModal(String title, List<Map<String, String>> items) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(height: 5, width: 40, margin: const EdgeInsets.only(bottom: 16), decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10))),
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (_, index) {
                  final item = items[index];
                  return ListTile(leading: const Icon(Icons.notifications), title: Text(item['title'] ?? item['pill']!), subtitle: Text(item['message'] ?? item['time']!));
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showEmergencyDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Confirm Emergency Dispense"),
            content: const Text("Are you sure you want to trigger emergency pill release?"),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Emergency dispense triggered!")));
                },
                child: const Text("Confirm"),
              ),
            ],
          ),
    );
  }

  void _showDeviceOptions() {
    showModalBottomSheet(
      context: context,
      builder:
          (_) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.sync),
                title: const Text("Reconnect Device"),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Reconnecting device...")));
                },
              ),
              ListTile(
                leading: const Icon(Icons.check_circle_outline),
                title: const Text("Test Device Dispense"),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Test dispense triggered.")));
                },
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("HealthGuard", style: TextStyle(color: Colors.white)),
        backgroundColor: theme.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(icon: const Icon(Icons.notifications), onPressed: () => _showModal("Notifications", notifications)),
          IconButton(icon: const Icon(Icons.history), onPressed: () => _showModal("Intake History", intakeHistory)),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text("Welcome back 👋", style: theme.textTheme.headlineSmall),
          const Text("Here's your medication summary", style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),

          // Schedule
          Text("📅 Today's Schedule", style: theme.textTheme.titleMedium),
          ...medicationSchedule.map(
            (med) => Card(child: ListTile(title: Text(med['name']), subtitle: Text(med['time']), trailing: Switch(value: med['taken'], onChanged: (val) => setState(() => med['taken'] = val)))),
          ),

          const SizedBox(height: 24),
          Text("🔌 Device Status", style: theme.textTheme.titleMedium),
          ListTile(
            leading: const Icon(Icons.memory, color: Colors.green),
            title: const Text("Dispenser Connected"),
            subtitle: const Text("Last synced: 3 mins ago"),
            trailing: IconButton(icon: const Icon(Icons.more_vert), onPressed: _showDeviceOptions),
          ),

          const SizedBox(height: 24),
          Text("💡 Wellness Tip", style: theme.textTheme.titleMedium),
          Card(color: Colors.lightBlue[50], shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), child: Padding(padding: const EdgeInsets.all(16), child: Text(selectedTip))),

          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.local_pharmacy),
                label: const Text("Request Refill"),
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Refill request sent!"))),
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.warning, color: Colors.red),
                label: const Text("Emergency", style: TextStyle(color: Colors.red)),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: _showEmergencyDialog,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
