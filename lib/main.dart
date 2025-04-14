import 'package:flutter/material.dart';
import 'package:health_guard/pages/splash_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const HealthGuardApp());
}

class HealthGuardApp extends StatelessWidget {
  const HealthGuardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Guard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF2196F3),
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch().copyWith(primary: const Color(0xFF2196F3), secondary: const Color(0xFF9E9E9E)),
        textTheme: const TextTheme(headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), bodyMedium: TextStyle(fontSize: 16)),
        inputDecorationTheme: InputDecorationTheme(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)), labelStyle: const TextStyle(color: Colors.black)),
      ),
      home: const SplashScreen(),
    );
  }
}
