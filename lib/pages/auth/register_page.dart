import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  int currentStep = 1;
  String? selectedRole;
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final tokenController = TextEditingController();

  void goToForm(String role) {
    setState(() {
      selectedRole = role;
      currentStep = 2;
    });
  }

  // Register user API
  Future<void> registerUser() async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse('${dotenv.env['API_URL']}/auth/register');

    try {
      final response = await http.post(
        url,
        body: {
          'name': nameController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'role': selectedRole!,
          'token': selectedRole == 'Doctor' ? tokenController.text : '', // Pass token only if the user is a doctor
        },
      );

      final responseData = json.decode(response.body);
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$selectedRole registered successfully!")));
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const LoginPage()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(responseData['message'])));
      }
    } catch (error) {
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("An error occurred, please try again.!!")));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void submitForm() {
    if (formKey.currentState!.validate()) {
      registerUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F8FF),
      body: Center(child: SingleChildScrollView(padding: const EdgeInsets.symmetric(horizontal: 24), child: currentStep == 1 ? _buildRoleSelection() : _buildRegistrationForm())),
    );
  }

  Widget _buildRoleSelection() {
    return Column(
      children: [
        Image.asset('assets/icons/logo.png', height: 100),
        const SizedBox(height: 20),
        Text('Register as', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 40),

        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [_roleCard('Patient', Icons.person, Colors.green), _roleCard('Doctor', Icons.medical_services, Colors.blue)]),

        const SizedBox(height: 40),
        TextButton(onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const LoginPage())), child: const Text("Already have an account? Login")),
      ],
    );
  }

  Widget _roleCard(String role, IconData icon, Color color) {
    return GestureDetector(
      onTap: () => goToForm(role),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Colors.white,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(children: [Icon(icon, size: 40, color: color), const SizedBox(height: 10), Text(role, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color))]),
        ),
      ),
    );
  }

  Widget _buildRegistrationForm() {
    return Card(
      elevation: 12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Create Your Account', style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.black)),
              const SizedBox(height: 10),
              Text('Registering as $selectedRole', style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 30),

              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Full Name', prefixIcon: Icon(Icons.person_outline)),
                validator: (value) => value!.isEmpty ? 'Enter your name' : null,
              ),
              const SizedBox(height: 20),

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
                validator: (value) => value!.length < 6 ? 'Password too short' : null,
              ),
              const SizedBox(height: 20),

              if (selectedRole == 'Doctor') ...[
                TextFormField(
                  controller: tokenController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Company Token', prefixIcon: Icon(Icons.vpn_key)),
                  validator: (value) => value!.isEmpty ? 'Enter your company token' : null,
                ),
                const SizedBox(height: 20),
              ],

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : submitForm,
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1976D2), padding: const EdgeInsets.symmetric(vertical: 14)),
                  child: isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text('Register', style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),

              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  setState(() {
                    currentStep = 1;
                    selectedRole = null;
                  });
                },
                child: const Text("← Go back"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
