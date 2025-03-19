import 'package:flutter/material.dart';
import 'package:health_guard/pages/home_content.dart';
import 'package:health_guard/pages/medications.dart';
import 'package:health_guard/pages/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Simulated list of notifications
  final List<Map<String, String>> _notifications = [
    {"title": "Medication Reminder", "message": "Time to take your morning medication."},
    {"title": "Refill Alert", "message": "Your prescription for Aspirin needs to be refilled."},
    {"title": "Doctor's Note", "message": "Dr. Smith has updated your treatment plan."},
    {"title": "Medication Reminder", "message": "Time to take your morning medication."},
    {"title": "Refill Alert", "message": "Your prescription for Aspirin needs to be refilled."},
    {"title": "Doctor's Note", "message": "Dr. Smith has updated your treatment plan."},
    {"title": "Medication Reminder", "message": "Time to take your morning medication."},
    {"title": "Refill Alert", "message": "Your prescription for Aspirin needs to be refilled."},
    {"title": "Doctor's Note", "message": "Dr. Smith has updated your treatment plan."},
    {"title": "Medication Reminder", "message": "Time to take your morning medication."},
    {"title": "Refill Alert", "message": "Your prescription for Aspirin needs to be refilled."},
    {"title": "Doctor's Note", "message": "Dr. Smith has updated your treatment plan."},
  ];

  final List<Widget> _pages = [const HomeContent(), const MedicationsPage(), const ProfilePage(isDoctor: true)];

  // Function to show notifications in a modal bottom sheet
  void _showNotificationsModal() {
    showModalBottomSheet(
      context: context,
      // isScrollControlled: true, // Allows the modal to scroll if content overflows
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // Ensures the modal doesn't take full height
            children: [
              // Title
              Text("Notifications", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
              const SizedBox(height: 10),

              // Check if there are no notifications
              if (_notifications.isEmpty)
                const Padding(padding: EdgeInsets.symmetric(vertical: 20), child: Center(child: Text("No notifications available.")))
              else
                // Use Expanded to allow scrolling within the modal
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children:
                          _notifications.map((notification) {
                            return Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(backgroundColor: Colors.blue[100], child: Icon(Icons.notifications, color: Colors.blue)),
                                  title: Text(notification["title"]!, style: const TextStyle(fontWeight: FontWeight.bold)),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 4),
                                      Text(notification["message"]!),
                                      const SizedBox(height: 4),
                                      Text(
                                        "Just now", // Replace with dynamic timestamp
                                        style: TextStyle(fontSize: 12, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    // Handle notification tap (e.g., navigate to details page)
                                    Navigator.pop(context); // Close the modal
                                  },
                                ),
                                const Divider(indent: 72, color: Colors.grey), // Add divider after each notification
                              ],
                            );
                          }).toList(),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HealthGuard", style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.white),
                onPressed: _showNotificationsModal, // Open the modal on notification icon press
              ),
              Positioned(
                right: 15,
                top: 12,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(180)),
                  constraints: const BoxConstraints(minWidth: 10, minHeight: 10),
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.medication), label: "Medications"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
