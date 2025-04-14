import 'package:flutter/material.dart';
import 'package:health_guard/pages/auth/login_page.dart';

class PatientProfilePage extends StatefulWidget {
  const PatientProfilePage({super.key});

  @override
  State<PatientProfilePage> createState() => _PatientProfilePageState();
}

class _PatientProfilePageState extends State<PatientProfilePage> {
  // Mock user data (can be replaced with real data later)
  Map<String, String> userInfo = {"name": "Youssof Antar", "email": "youssof@example.com", "role": "Patient"};

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = userInfo["name"]!;
    _emailController.text = userInfo["email"]!;
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveChanges() {
    setState(() {
      userInfo["name"] = _nameController.text;
      userInfo["email"] = _emailController.text;
      _isEditing = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Profile updated successfully!")));
  }

  void _logout() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const LoginPage())); // Simulate logout
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile", style: TextStyle(color: Colors.white)), backgroundColor: Theme.of(context).primaryColor, iconTheme: const IconThemeData(color: Colors.white)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // Profile Picture
            CircleAvatar(radius: 50, backgroundColor: Colors.blue[50], child: const Icon(Icons.person, size: 50, color: Colors.blue)),
            const SizedBox(height: 16),

            // Name Field
            TextFormField(
              controller: _nameController,
              enabled: _isEditing,
              decoration: InputDecoration(labelText: "Full Name", border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)), prefixIcon: const Icon(Icons.person_outline)),
            ),
            const SizedBox(height: 16),

            // Email Field
            TextFormField(
              controller: _emailController,
              enabled: _isEditing,
              decoration: InputDecoration(labelText: "Email", border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)), prefixIcon: const Icon(Icons.email_outlined)),
            ),
            const SizedBox(height: 24),

            // Role Badge
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: ListTile(leading: const Icon(Icons.assignment_ind, color: Colors.green), title: const Text("Role"), subtitle: Text(userInfo["role"]!)),
            ),
            const SizedBox(height: 24),

            // Edit/Save Button
            ElevatedButton(
              onPressed: _isEditing ? _saveChanges : _toggleEdit,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text(_isEditing ? "Save Changes" : "Edit Profile", style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 16),

            // Logout Button
            OutlinedButton.icon(
              onPressed: _logout,
              icon: const Icon(Icons.logout, color: Colors.red),
              label: const Text("Logout", style: TextStyle(color: Colors.red)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
