import 'package:flutter/material.dart';

class HealthGuardTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1976D2),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      primaryColor: const Color(0xFF2196F3),
      colorScheme: ColorScheme.fromSwatch().copyWith(primary: const Color(0xFF2196F3), secondary: const Color(0xFF9E9E9E)),
      scaffoldBackgroundColor: Colors.white,
      textTheme: const TextTheme(headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), bodyLarge: TextStyle(fontSize: 18), bodyMedium: TextStyle(fontSize: 16)),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2196F3),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 32),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelStyle: const TextStyle(color: Colors.black),
        hintStyle: const TextStyle(color: Colors.grey),
      ),
    );
  }
}
