import 'package:flutter/material.dart';
import 'package:health_guard/pages/medication_details.dart';

class MedicationsPage extends StatefulWidget {
  const MedicationsPage({super.key});

  @override
  State<MedicationsPage> createState() => _MedicationsPageState();
}

class _MedicationsPageState extends State<MedicationsPage> {
  // List of medications with dynamic data
  final List<Map<String, dynamic>> medications = [
    {
      "image": "assets/images/medication_a.jpg",
      "title": "Medication A",
      "description": "This medication helps reduce inflammation and pain.",
      "time": "10:00 AM",
      "dosage": "Take 1 tablet",
      "takenToday": false,
      "stock": 10,
      "doctor": "Dr. John Doe",
      "reasonForChange": "",
    },
    {
      "image": "assets/images/medication_b.jpg",
      "title": "Medication B",
      "description": "This medication is used to treat high blood pressure.",
      "time": "02:00 PM",
      "dosage": "Take 2 tablets",
      "takenToday": true,
      "stock": 5,
      "doctor": "Dr. Jane Smith",
      "reasonForChange": "",
    },
    {
      "image": "assets/images/medication_c.jpg",
      "title": "Medication C",
      "description": "This medication improves sleep quality.",
      "time": "06:00 PM",
      "dosage": "Take 1 capsule",
      "takenToday": false,
      "stock": 3,
      "doctor": "Dr. Emily Johnson",
      "reasonForChange": "",
    },
  ];

  // Function to handle "Take Dosage" action
  void _takeDosage(int index) {
    setState(() {
      medications[index]["takenToday"] = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${medications[index]["title"]} marked as taken.")));
  }

  // Function to handle "Restock" action
  void _restockMedication(int index) {
    final TextEditingController quantityController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Restock Medication"),
          content: TextField(controller: quantityController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Enter Quantity")),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final String quantity = quantityController.text;
                if (quantity.isNotEmpty) {
                  setState(() {
                    medications[index]["stock"] += int.parse(quantity);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Added $quantity units to ${medications[index]["title"]}")));
                  Navigator.pop(context); // Close the dialog after restocking
                }
              },
              child: const Text("Restock"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: medications.length,
      itemBuilder: (context, index) {
        final medication = medications[index];
        return InkWell(
          onTap: () {
            // Navigate to the details page for the selected medication
            Navigator.push(context, MaterialPageRoute(builder: (context) => MedicationDetailsPage(medication: medication)));
          },
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Medication Image
                      ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.asset(medication["image"], width: 100, height: 100, fit: BoxFit.cover)),
                      const SizedBox(width: 16),

                      // Medication Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title and Taken/Not Taken Status
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(medication["title"], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                Text(medication["takenToday"] ? "Taken Today" : "Not Taken", style: TextStyle(fontSize: 14, color: medication["takenToday"] ? Colors.green : Colors.red)),
                              ],
                            ),
                            const SizedBox(height: 5),

                            // Description
                            Text(medication["description"], maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                            const SizedBox(height: 10),

                            // Stock and Dosage
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Stock: ${medication["stock"]} left", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                Text("${medication["dosage"]}", style: const TextStyle(fontSize: 14, color: Colors.grey)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Buttons Section (Below Image and Content)
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Take Dosage Button
                      ElevatedButton.icon(
                        onPressed: () {
                          _takeDosage(index);
                        },
                        icon: const Icon(Icons.check, size: 16, color: Colors.white),
                        label: const Text("Take Dosage", style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),

                      // Restock Button
                      ElevatedButton.icon(
                        onPressed: () {
                          _restockMedication(index);
                        },
                        icon: const Icon(Icons.add_box, size: 16, color: Colors.white),
                        label: const Text("Restock", style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
