import 'package:flutter/material.dart';

class MedicationDetailsPage extends StatelessWidget {
  final Map<String, dynamic> medication;

  const MedicationDetailsPage({super.key, required this.medication});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(medication["title"]), backgroundColor: Theme.of(context).primaryColor, foregroundColor: Colors.white),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Medication Image
            Center(child: ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.asset(medication["image"], width: 200, height: 200, fit: BoxFit.cover))),
            const SizedBox(height: 16),

            // Title
            Text(medication["title"], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            // Description
            Text(medication["description"], style: const TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 16),

            // Doctor Information
            Text("Prescribed by: ${medication["doctor"]}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            // Time and Dosage
            Text("Time: ${medication["time"]}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text("Dosage: ${medication["dosage"]}", style: const TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 16),

            // Stock Information
            Text("Stock: ${medication["stock"]} left", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text(medication["takenToday"] ? "Taken Today" : "Not Taken", style: TextStyle(fontSize: 16, color: medication["takenToday"] ? Colors.green : Colors.red)),
            const SizedBox(height: 16),

            // Action Buttons Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Request to Change Button
                  ElevatedButton.icon(
                    onPressed: () {
                      // Handle request to change medication
                      showDialog(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              title: const Text("Request to Change Medication"),
                              content: TextField(decoration: const InputDecoration(labelText: "Reason for change"), maxLines: 3),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cancel"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Submit"),
                                ),
                              ],
                            ),
                      );
                    },
                    icon: const Icon(Icons.edit, size: 20, color: Colors.white),
                    label: const Text("Request to Change", style: TextStyle(color: Colors.white, fontSize: 16)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      shadowColor: Colors.black.withOpacity(0.4),
                      elevation: 4,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Take Dosage and Restock Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Handle Take Dosage action
                          },
                          icon: const Icon(Icons.check, size: 20, color: Colors.white),
                          label: const Text("Take Dosage", style: TextStyle(color: Colors.white, fontSize: 16)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            shadowColor: Colors.black.withOpacity(0.4),
                            elevation: 4,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Handle Restock action
                          },
                          icon: const Icon(Icons.add_box, size: 20, color: Colors.white),
                          label: const Text("Restock", style: TextStyle(color: Colors.white, fontSize: 16)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            shadowColor: Colors.black.withOpacity(0.4),
                            elevation: 4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
