import 'package:flutter/material.dart';

class MedicationDetailsPage extends StatefulWidget {
  final Map<String, dynamic> medication;

  const MedicationDetailsPage({super.key, required this.medication});

  @override
  State<MedicationDetailsPage> createState() => _MedicationDetailsPageState();
}

class _MedicationDetailsPageState extends State<MedicationDetailsPage> {
  late Map<String, dynamic> _medication; // Local copy of the medication data

  @override
  void initState() {
    super.initState();
    _medication = Map<String, dynamic>.from(widget.medication); // Initialize with passed data
  }

  // Function to handle "Take Dosage" action
  void _takeDosage() {
    setState(() {
      _medication["takenToday"] = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${_medication["title"]} marked as taken.")));
  }

  // Function to handle "Restock" action
  void _restockMedication() {
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
                    _medication["stock"] += int.parse(quantity);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Added $quantity units to ${_medication["title"]}")));
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
    return Scaffold(
      appBar: AppBar(title: Text(_medication["title"]), backgroundColor: Theme.of(context).primaryColor, foregroundColor: Colors.white),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Medication Image
            Center(child: ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.asset(_medication["image"], width: 200, height: 200, fit: BoxFit.cover))),
            const SizedBox(height: 16),

            // Title
            Text(_medication["title"], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            // Description
            Text(_medication["description"], style: const TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 16),

            // Doctor Information
            Text("Prescribed by: ${_medication["doctor"]}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            // Time and Dosage
            Text("Time: ${_medication["time"]}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text("Dosage: ${_medication["dosage"]}", style: const TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 16),

            // Stock Information
            Text("Stock: ${_medication["stock"]} left", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text(_medication["takenToday"] ? "Taken Today" : "Not Taken", style: TextStyle(fontSize: 16, color: _medication["takenToday"] ? Colors.green : Colors.red)),
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
                          onPressed: _takeDosage,
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
                          onPressed: _restockMedication,
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
