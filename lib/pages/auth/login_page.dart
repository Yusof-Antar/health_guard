import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:health_guard/pages/patient/patient_main_page.dart';
import 'register_page.dart';
import '../home/doctor_dashboard.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFFF1F8FF),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Card(
            elevation: 12,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/icons/logo.png', height: 80),
                    const SizedBox(height: 20),
                    Text('Welcome Back 👋', style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.black)),
                    const SizedBox(height: 8),
                    const Text('Login to continue', style: TextStyle(color: Colors.grey)),

                    const SizedBox(height: 30),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email_outlined)),
                      validator: (value) => value!.isEmpty ? 'Enter your email' : null,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Password', prefixIcon: Icon(Icons.lock_outline)),
                      validator: (value) => value!.isEmpty ? 'Enter your password' : null,
                    ),

                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            try {
                              final response = await http.post(
                                Uri.parse('${dotenv.env['API_URL']}/auth/login'),
                                headers: {'Content-Type': 'application/json'},
                                body: jsonEncode({'email': emailController.text.trim(), 'password': passwordController.text.trim()}),
                              );

                              if (response.statusCode == 200) {
                                final data = jsonDecode(response.body);
                                final role = data['user']['role'];

                                if (role == 'doctor') {
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const DoctorDashboard()));
                                } else if (role == 'patient') {
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const PatientMainPage()));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Unknown user role')));
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login failed: ${jsonDecode(response.body)["message"]}')));
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1976D2), padding: const EdgeInsets.symmetric(vertical: 14)),
                        child: const Text('Login', style: TextStyle(fontSize: 16, color: Colors.white)),
                      ),
                    ),

                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const RegisterPage()));
                      },
                      child: const Text("Don't have an account? Register"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
