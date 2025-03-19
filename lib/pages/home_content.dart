import 'package:flutter/material.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> medications = [
      {"name": "Medication A", "time": "10:00 AM"},
      {"name": "Medication B", "time": "02:00 PM"},
      {"name": "Medication C", "time": "06:00 PM"},
    ];

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Welcome, John!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
                  const SizedBox(height: 10),

                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Health Summary", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[700])),
                          const SizedBox(height: 10),
                          Text("You've taken 80% of your medications this week.", style: TextStyle(fontSize: 14, color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Text("Upcoming Medication Reminders", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[700])),
                  const SizedBox(height: 10),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          ...medications.asMap().entries.map((entry) {
                            int index = entry.key;
                            Map<String, String> medication = entry.value;

                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(medication["name"]!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                    Text(medication["time"]!, style: const TextStyle(fontSize: 16, color: Colors.grey)),
                                  ],
                                ),

                                if (index < medications.length - 1) const Divider(),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text("Add Stock"),
                  style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor, padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications, color: Colors.white),
                  label: const Text("View Reminders"),
                  style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor, padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
