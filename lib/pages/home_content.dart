import 'package:flutter/material.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    // List of predefined medications
    final List<String> medicationList = ["Medication A", "Medication B", "Medication C"];

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
                  onPressed: () {
                    _showAddStockDialog(context, medicationList);
                  },
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text("Add Stock"),
                  style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor, padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const RemindersPage()));
                  },
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

  // Function to show a dialog for adding stock with a dropdown list
  void _showAddStockDialog(BuildContext context, List<String> medicationList) {
    String? selectedMedication; // To store the selected medication from the dropdown
    final TextEditingController quantityController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Stock"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: "Select Medication"),
                value: selectedMedication,
                items:
                    medicationList.map((String medication) {
                      return DropdownMenuItem<String>(value: medication, child: Text(medication));
                    }).toList(),
                onChanged: (value) {
                  selectedMedication = value; // Update the selected medication
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please select a medication";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextField(controller: quantityController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Quantity")),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle stock addition logic here
                if (selectedMedication != null && quantityController.text.isNotEmpty) {
                  final String quantity = quantityController.text;

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Added $quantity units of $selectedMedication")));
                  Navigator.pop(context); // Close the dialog after adding
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }
}

// New Page for Reminders
class RemindersPage extends StatelessWidget {
  const RemindersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> reminders = [
      {"name": "Medication A", "time": "10:00 AM", "status": "Pending"},
      {"name": "Medication B", "time": "02:00 PM", "status": "Completed"},
      {"name": "Medication C", "time": "06:00 PM", "status": "Pending"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Reminders"), backgroundColor: Theme.of(context).primaryColor, foregroundColor: Colors.white),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: reminders.length,
        itemBuilder: (context, index) {
          final reminder = reminders[index];
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              title: Text(reminder["name"]!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("Time: ${reminder["time"]}, Status: ${reminder["status"]}"),
              trailing: IconButton(
                icon: const Icon(Icons.check_circle_outline),
                onPressed: () {
                  // Mark reminder as completed
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${reminder["name"]} marked as completed")));
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
