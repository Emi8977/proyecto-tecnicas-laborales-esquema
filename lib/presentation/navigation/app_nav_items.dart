import 'package:flutter/material.dart';
import '../pages/activities_page.dart';
import '../pages/home_page.dart';
import '../pages/activities_page.dart';
import '../pages/profile_page.dart';
import '../pages/settings_page.dart';

class AppNavItem {
  final IconData icon;
  final String label;
  final Widget pageContent;

  const AppNavItem({required this.icon, required this.label, required this.pageContent});
}

final List<AppNavItem> mainNavItems = [
  AppNavItem(
    icon: Icons.sports_soccer,
    label: 'Inicio',
    pageContent: ProductListPage(), // Página principal adaptada
  ),
  AppNavItem(
    icon: Icons.calendar_month,
    label: 'Eventos',
    pageContent: ActivitiesPage(), // Reutilizable para actividades futuras
  ),
  AppNavItem(
    icon: Icons.person_outline,
    label: 'Perfil',
    pageContent: ProfilePage(),
  ),
  AppNavItem(
    icon: Icons.settings,
    label: 'Ajustes',
    pageContent: SettingsPage(),
  ),
];
