import 'package:flutter/material.dart';
import 'doctor_home_page.dart';
import 'doctor_patients_page.dart';
import 'doctor_profile_page.dart';

class DoctorMainPage extends StatefulWidget {
  const DoctorMainPage({super.key});

  @override
  State<DoctorMainPage> createState() => _DoctorMainPageState();
}

class _DoctorMainPageState extends State<DoctorMainPage> {
  int _selectedIndex = 0;

  // Pages for Doctor's navigation
  final List<Widget> _pages = const [DoctorHomePage(), DoctorPatientsPage(), DoctorProfilePage()];

  void _onTabTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed, // Allows more than 3 tabs
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Patients"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
