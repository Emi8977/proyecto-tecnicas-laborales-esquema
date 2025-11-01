// lib/main.dart

import 'package:flutter/material.dart';
import 'theme.dart';

// Importa las páginas principales
import './presentation/pages/main_screen_page.dart';
import './presentation/pages/home_page.dart';
import './presentation/pages/login_page.dart';
import './presentation/pages/register_page.dart';
import './presentation/navigation/public_sidebar_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ConectaDeportes',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.mainTheme,
      // Página inicial (puede cambiar luego por Login si deseas flujo con auth)
      home: MainScreen(),
      routes: {
        '/home': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
      },
    );
  }
}
