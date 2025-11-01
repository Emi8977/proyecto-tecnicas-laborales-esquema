import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Estados de las preferencias
  bool _darkMode = false;
  bool _notifications = true;
  bool _location = true;
  bool _autoUpdate = true;
  bool _backup = false;

  // Colores de tema global
  static const Color primaryColor = Color(0xFF00BFA5); // Verde agua
  static const Color accentBlue = Color(0xFF29B6F6);   // Celeste
  static const Color accentOrange = Color(0xFFFFB74D); // Naranja suave
  static const Color background = Colors.white;

  @override
  Widget build(BuildContext context) {
    final bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Configuración"),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      backgroundColor: background,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // --- ÍCONO PRINCIPAL ---
          const Icon(
            Icons.settings,
            color: accentOrange,
            size: 90,
          ),
          const SizedBox(height: 20),

          const Center(
            child: Text(
              "Opciones de la Aplicación",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              "Activa o desactiva las funciones según tus preferencias.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54, fontSize: 15),
            ),
          ),
          const SizedBox(height: 30),

          // --- LISTADO DE OPCIONES ---
          _buildSwitchTile(
            icon: isIOS ? CupertinoIcons.moon_stars : Icons.dark_mode_outlined,
            label: "Modo oscuro",
            value: _darkMode,
            color: accentBlue,
            onChanged: (val) => setState(() => _darkMode = val),
          ),
          _buildSwitchTile(
            icon: isIOS ? CupertinoIcons.bell : Icons.notifications_active,
            label: "Notificaciones",
            value: _notifications,
            color: primaryColor,
            onChanged: (val) => setState(() => _notifications = val),
          ),
          _buildSwitchTile(
            icon: isIOS ? CupertinoIcons.location : Icons.location_on_outlined,
            label: "Ubicación",
            value: _location,
            color: accentOrange,
            onChanged: (val) => setState(() => _location = val),
          ),
          _buildSwitchTile(
            icon: isIOS ? CupertinoIcons.arrow_2_circlepath : Icons.system_update,
            label: "Actualizaciones automáticas",
            value: _autoUpdate,
            color: accentBlue,
            onChanged: (val) => setState(() => _autoUpdate = val),
          ),
          _buildSwitchTile(
            icon: isIOS ? CupertinoIcons.cloud_upload : Icons.backup_outlined,
            label: "Copia de seguridad",
            value: _backup,
            color: primaryColor,
            onChanged: (val) => setState(() => _backup = val),
          ),
          const SizedBox(height: 20),

          // --- BOTÓN FINAL ---
          ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Cambios guardados correctamente"),
                  backgroundColor: primaryColor,
                ),
              );
            },
            icon: const Icon(Icons.save, color: Colors.white),
            label: const Text(
              "Guardar Cambios",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // --- COMPONENTE PERSONALIZADO DE CADA OPCIÓN ---
  Widget _buildSwitchTile({
    required IconData icon,
    required String label,
    required bool value,
    required Color color,
    required ValueChanged<bool> onChanged,
  }) {
    return Card(
      elevation: 3,
      shadowColor: Colors.grey.shade300,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.15),
          child: Icon(icon, color: color),
        ),
        title: Text(
          label,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Switch.adaptive(
          value: value,
          onChanged: onChanged,
          activeColor: color,
        ),
      ),
    );
  }
}
