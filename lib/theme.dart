// lib/theme.dart

import 'package:flutter/material.dart';

class AppTheme {
  // 🎨 Paleta de colores principal
  static const Color _primaryGreen = Color(0xFF00BFA5);     // Verde agua
  static const Color _accentBlue = Color(0xFF29B6F6);       // Celeste
  static const Color _accentOrange = Color(0xFFFFB74D);     // Naranja suave
  static const Color _white = Colors.white;

  static final mainTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: _primaryGreen,
    scaffoldBackgroundColor: _white,
    fontFamily: 'Roboto',

    colorScheme: ColorScheme.light(
      primary: _primaryGreen,
      secondary: _accentOrange,
      surface: _white,
      background: _white,
      error: Colors.redAccent,
    ),

    // 🟩 AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: _primaryGreen,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),

    // 🔵 TabBar
    tabBarTheme: const TabBarThemeData(
      labelColor: _accentBlue,
      unselectedLabelColor: Colors.grey,
      indicatorColor: _accentOrange,
      labelStyle: TextStyle(fontWeight: FontWeight.bold),
    ),



    // 🟠 BottomNavigationBar
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: _primaryGreen,
      selectedItemColor: _accentOrange,
      unselectedItemColor: Colors.white70,
    ),

    // ⚪ Botones elevados (ElevatedButton)
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _accentBlue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),

    // 🧾 Inputs (TextField)
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _accentBlue),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: _primaryGreen, width: 2),
      ),
      labelStyle: const TextStyle(color: Colors.black87),
    ),
  );
}
