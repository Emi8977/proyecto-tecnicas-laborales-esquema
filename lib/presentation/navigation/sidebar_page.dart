import 'package:flutter/material.dart';
import '../pages/main_screen_page.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;
    final Color secondary = Theme.of(context).colorScheme.secondary;

    return Drawer(
      width: MediaQuery.of(context).size.width * 0.8,
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text(
              "Lilia García",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            accountEmail: const Text("garcia.lilia@uncuyo.edu.ar"),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage("assets/images/logo.png"),
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primary, secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          _buildTile(context, Icons.home, "Inicio", primary, () => Navigator.pop(context)),
          _buildTile(context, Icons.sports_soccer, "Mis Actividades", secondary, () {}),
          _buildTile(context, Icons.history, "Historial", primary, () {}),
          _buildTile(context, Icons.person, "Perfil", secondary, () {}),
          _buildTile(context, Icons.star, "Ranking", primary, () {}),
          _buildTile(context, Icons.settings, "Preferencias", secondary, () {}),
          _buildTile(context, Icons.support_agent, "Soporte", primary, () {}),

          const Divider(),

          // Cerrar sesión
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red.shade400),
            title: const Text('Cerrar sesión', style: TextStyle(color: Colors.black87)),
            onTap: () {
              final accent = Theme.of(context).colorScheme.secondary;

              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 300),
                  backgroundColor: accent,
                  content: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.exit_to_app, color: Colors.white),
                      SizedBox(width: 12),
                      Text(
                        "Saliendo de la aplicación...",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MainScreen()),
                    (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTile(
      BuildContext context,
      IconData icon,
      String title,
      Color color,
      VoidCallback onTap,
      ) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: const TextStyle(color: Colors.black87)),
      onTap: onTap,
    );
  }
}
