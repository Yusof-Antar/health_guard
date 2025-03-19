import 'package:flutter/material.dart';
import 'package:health_guard/pages/home.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool isLogin = true; // Toggle between login and registration

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Top-left circle
          Positioned(top: -125, left: -125, child: Container(height: 300, width: 300, decoration: BoxDecoration(borderRadius: BorderRadius.circular(180), color: Theme.of(context).primaryColor))),
          // Right-middle circle
          Positioned(
            top: MediaQuery.of(context).size.height * 0.35,
            right: -150,
            child: Container(height: 300, width: 300, decoration: BoxDecoration(borderRadius: BorderRadius.circular(180), color: Theme.of(context).primaryColor)),
          ),
          // Bottom-left circle
          Positioned(bottom: -100, left: -100, child: Container(height: 300, width: 300, decoration: BoxDecoration(borderRadius: BorderRadius.circular(180), color: Theme.of(context).primaryColor))),
          // Centered white container for input fields
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8, // Responsive width
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [BoxShadow(color: Colors.black.withAlpha(20), blurRadius: 10, spreadRadius: 2)]),
              child: AnimatedSwitcher(duration: const Duration(milliseconds: 300), child: isLogin ? _buildLoginForm() : _buildRegistrationForm()),
            ),
          ),
        ],
      ),
    );
  }

  // Login Form
  Widget _buildLoginForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Title
        Text("Login", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        // Email Input Field
        TextField(decoration: InputDecoration(labelText: "Email", border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
        const SizedBox(height: 15),
        // Password Input Field
        TextField(obscureText: true, decoration: InputDecoration(labelText: "Password", border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
        const SizedBox(height: 20),
        // Login Button
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));
          },
          style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor, padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
          child: const Text("Login", style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
        const SizedBox(height: 10),
        // Switch to Registration
        TextButton(
          onPressed: () {
            setState(() {
              isLogin = false;
            });
          },
          child: Text("Don't have an account? Register!"),
        ),
      ],
    );
  }

  // Registration Form
  Widget _buildRegistrationForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Title
        Text("Register", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        // Email Input Field
        TextField(decoration: InputDecoration(labelText: "Email", border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
        const SizedBox(height: 15),
        // Password Input Field
        TextField(obscureText: true, decoration: InputDecoration(labelText: "Password", border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
        const SizedBox(height: 15),
        // Confirm Password Input Field
        TextField(obscureText: true, decoration: InputDecoration(labelText: "Confirm Password", border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
        const SizedBox(height: 20),
        // Register Button
        ElevatedButton(
          onPressed: () {
            // Handle registration
          },
          style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor, padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
          child: const Text("Register", style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
        const SizedBox(height: 10),
        // Switch to Login
        TextButton(
          onPressed: () {
            setState(() {
              isLogin = true;
            });
          },
          child: Text("Already have an account? Login!"),
        ),
      ],
    );
  }
}
