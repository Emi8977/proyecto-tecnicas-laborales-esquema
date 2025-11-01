import 'package:flutter/material.dart';

// --- COLORES BASE DEL TEMA ---
const Color primaryColor = Color(0xFF00BFA5); // Verde agua
const Color accentColor = Color(0xFFFFB74D); // Naranja suave
const Color lightBlue = Color(0xFF29B6F6);   // Celeste

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isEditing = false;

  final TextEditingController _nameController =
  TextEditingController(text: "Emiliano Luna");
  final TextEditingController _emailController =
  TextEditingController(text: "emi.luna@conectadeportes.com");
  final TextEditingController _phoneController =
  TextEditingController(text: "+54 9 261 123 4567");
  final TextEditingController _sportController =
  TextEditingController(text: "Fútbol y Running");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil de Usuario"),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });

              if (!_isEditing) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Perfil actualizado correctamente"),
                    backgroundColor: primaryColor,
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // --- FOTO DE PERFIL ---
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: accentColor,
                    child: const Icon(Icons.person, size: 80, color: Colors.black),
                  ),
                  if (_isEditing)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: lightBlue,
                        radius: 20,
                        child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // --- INFORMACIÓN DEL PERFIL ---
            _buildEditableField(
              label: "Nombre completo",
              controller: _nameController,
              icon: Icons.person,
            ),
            _buildEditableField(
              label: "Email",
              controller: _emailController,
              icon: Icons.email,
            ),
            _buildEditableField(
              label: "Teléfono",
              controller: _phoneController,
              icon: Icons.phone,
            ),
            _buildEditableField(
              label: "Deportes favoritos",
              controller: _sportController,
              icon: Icons.sports_soccer,
            ),
            const SizedBox(height: 30),

            // --- BOTÓN DE GUARDAR O CANCELAR ---
            if (_isEditing)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _isEditing = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Cambios descartados"),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                    },
                    icon: const Icon(Icons.close),
                    label: const Text("Cancelar"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade300,
                      foregroundColor: Colors.black,
                      padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _isEditing = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Perfil guardado correctamente"),
                          backgroundColor: primaryColor,
                        ),
                      );
                    },
                    icon: const Icon(Icons.save),
                    label: const Text("Guardar"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentColor,
                      foregroundColor: Colors.black,
                      padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET PERSONALIZADO PARA CAMPOS EDITABLES ---
  Widget _buildEditableField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        enabled: _isEditing,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: primaryColor),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: lightBlue, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
