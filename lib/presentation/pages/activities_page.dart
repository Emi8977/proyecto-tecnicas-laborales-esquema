import 'package:flutter/material.dart';

// --- COLORES DEL TEMA ---
const Color primaryColor = Color(0xFF00BFA5); // Verde agua
const Color accentColor = Color(0xFFFFB74D); // Naranja suave
const Color lightBlue = Color(0xFF29B6F6); // Celeste

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({super.key});

  @override
  State<ActivitiesPage> createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  final List<Map<String, dynamic>> _activities = [];

  // Controladores del formulario
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _groupNameController = TextEditingController();
  DateTime? _selectedDate;
  String _selectedSport = "Fútbol";

  // Lista de deportes predefinidos
  final List<String> _sports = ["Fútbol", "Basquet", "Tenis", "Running", "Yoga", "Crossfit"];

  // --- MÉTODO PARA CREAR UNA ACTIVIDAD ---
  void _createActivity() {
    if (_nameController.text.isEmpty || _locationController.text.isEmpty || _selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor completa todos los campos'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    setState(() {
      _activities.add({
        'sport': _selectedSport,
        'name': _nameController.text,
        'group': _groupNameController.text.isEmpty ? "General" : _groupNameController.text,
        'location': _locationController.text,
        'date': _selectedDate!,
      });
    });

    // Limpiar el formulario
    _nameController.clear();
    _locationController.clear();
    _groupNameController.clear();
    _selectedDate = null;

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Actividad creada con éxito'),
        backgroundColor: primaryColor,
      ),
    );
  }

  // --- DIALOG PARA CREAR NUEVA ACTIVIDAD ---
  void _showCreateDialog() {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 20,
            left: 20,
            right: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "Crear nueva actividad",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                // Nombre de la actividad
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "Nombre de la actividad",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 12),

                // Deporte
                DropdownButtonFormField<String>(
                  value: _selectedSport,
                  items: _sports.map((sport) {
                    return DropdownMenuItem(
                      value: sport,
                      child: Text(sport),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedSport = value!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Deporte",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 12),

                // Grupo
                TextField(
                  controller: _groupNameController,
                  decoration: InputDecoration(
                    labelText: "Nombre del grupo (opcional)",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 12),

                // Lugar
                TextField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    labelText: "Ubicación",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 12),

                // Fecha
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedDate == null
                          ? "Selecciona una fecha"
                          : "Fecha: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}",
                      style: const TextStyle(fontSize: 16),
                    ),
                    ElevatedButton.icon(
                      onPressed: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2024),
                          lastDate: DateTime(2026),
                        );
                        if (picked != null) {
                          setState(() {
                            _selectedDate = picked;
                          });
                        }
                      },
                      icon: const Icon(Icons.calendar_today),
                      label: const Text("Elegir"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Botón Crear
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _createActivity,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    child: const Text(
                      "Crear Actividad",
                      style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  // --- LISTADO DE ACTIVIDADES CREADAS ---
  Widget _buildActivityList() {
    if (_activities.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.only(top: 100),
          child: Text(
            "No hay actividades creadas aún.",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _activities.length,
      itemBuilder: (context, index) {
        final activity = _activities[index];
        return Card(
          color: Colors.white,
          margin: const EdgeInsets.symmetric(vertical: 8),
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: primaryColor,
              child: Icon(Icons.sports, color: Colors.white),
            ),
            title: Text(activity['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(
              "${activity['sport']} • ${activity['location']}\n${activity['date'].day}/${activity['date'].month}/${activity['date'].year}",
            ),
            trailing: Text(
              "Grupo: ${activity['group']}",
              style: const TextStyle(color: Colors.black54, fontSize: 13),
            ),
          ),
        );
      },
    );
  }

  // --- BUILD ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Actividades Deportivas"),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildActivityList(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showCreateDialog,
        backgroundColor: accentColor,
        icon: const Icon(Icons.add, color: Colors.black),
        label: const Text(
          "Nueva Actividad",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
