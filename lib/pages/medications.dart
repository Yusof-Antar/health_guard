import 'package:flutter/material.dart';
import 'package:health_guard/pages/medication_details.dart';

class MedicationsPage extends StatelessWidget {
  const MedicationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Example list of medications with dynamic data
    final List<Map<String, dynamic>> medications = [
      {
        "image": "assets/images/medication_a.jpg", // Replace with actual image path
        "title": "Medication A",
        "description": "This medication helps reduce inflammation and pain.",
        "time": "10:00 AM",
        "dosage": "Take 1 tablet",
        "takenToday": false, // Tracks if the user has taken the dose today
        "stock": 10, // Number of pills left in stock
        "doctor": "Dr. John Doe", // Doctor who prescribed the medication
        "reasonForChange": "", // Reason for requesting a change (initially empty)
      },
      {
        "image": "assets/images/medication_b.jpg", // Replace with actual image path
        "title": "Medication B",
        "description": "This medication is used to treat high blood pressure.",
        "time": "02:00 PM",
        "dosage": "Take 2 tablets",
        "takenToday": true, // Tracks if the user has taken the dose today
        "stock": 5, // Number of pills left in stock
        "doctor": "Dr. Jane Smith", // Doctor who prescribed the medication
        "reasonForChange": "", // Reason for requesting a change (initially empty)
      },
      {
        "image": "assets/images/medication_c.jpg", // Replace with actual image path
        "title": "Medication C",
        "description": "This medication improves sleep quality.",
        "time": "06:00 PM",
        "dosage": "Take 1 capsule",
        "takenToday": false, // Tracks if the user has taken the dose today
        "stock": 3, // Number of pills left in stock
        "doctor": "Dr. Emily Johnson", // Doctor who prescribed the medication
        "reasonForChange": "", // Reason for requesting a change (initially empty)
      },
    ];

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
            elevation: 4, // Increased elevation for depth
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), // Rounded corners
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Medication Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          medication["image"],
                          width: 100, // Smaller image size
                          height: 100, // Smaller image size
                          fit: BoxFit.cover,
                        ),
                      ),
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
                          // Update the "takenToday" status for this medication
                          // In a real app, update the state or database here
                        },
                        icon: const Icon(Icons.check, size: 16, color: Colors.white), // White icon
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
                          // Open a dialog or navigate to restock the medication
                          // In a real app, update the stock count or trigger an API call
                        },
                        icon: const Icon(Icons.add_box, size: 16, color: Colors.white), // White icon
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
