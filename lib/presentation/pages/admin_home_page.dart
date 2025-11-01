import 'package:flutter/material.dart';
import './../navigation/sidebar_page.dart';

// --- Paleta del tema global ---
const Color accentColor = Color(0xFFFFB74D); // Naranja suave
const Color primaryColor = Color(0xFF00BFA5); // Verde agua
const Color lightBlue = Color(0xFF29B6F6); // Celeste

// --- Datos Ficticios (Simulación de Backend) ---
final List<Map<String, dynamic>> _coachRanking = [
  {'name': 'Martín López', 'score': 250, 'id': 1},
  {'name': 'Carla Rivas', 'score': 230, 'id': 2},
  {'name': 'Luis Fernández', 'score': 190, 'id': 3},
  {'name': 'Sofía Torres', 'score': 160, 'id': 4},
];

final List<Map<String, dynamic>> _activityStats = [
  {'name': 'Fútbol 5', 'today': 8, 'week': 30, 'month': 120},
  {'name': 'Yoga', 'today': 6, 'week': 25, 'month': 100},
  {'name': 'Crossfit', 'today': 5, 'week': 22, 'month': 95},
];

final List<Map<String, dynamic>> _zoneRanking = [
  {'zone': 'Parque Central', 'sessions': 75},
  {'zone': 'Godoy Cruz', 'sessions': 50},
  {'zone': 'Las Heras', 'sessions': 45},
];

final List<Map<String, dynamic>> _dayRanking = [
  {'day': 'Viernes', 'sessions': 35},
  {'day': 'Sábado', 'sessions': 30},
  {'day': 'Domingo', 'sessions': 25},
];

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel de Administración'),
        centerTitle: true,
      ),
      drawer: const Sidebar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildActivityStatistics(),
            const SizedBox(height: 30),
            _buildRankingSection(
              context,
              title: 'Ranking de Entrenadores (Top 4)',
              rankingList: _coachRanking,
              icon: Icons.emoji_events,
              isCoachRanking: true,
            ),
            const SizedBox(height: 30),
            _buildRankingSection(
              context,
              title: 'Zonas Más Activas',
              rankingList: _zoneRanking,
              icon: Icons.location_on,
              isCoachRanking: false,
            ),
            const SizedBox(height: 30),
            _buildRankingSection(
              context,
              title: 'Días Más Activos',
              rankingList: _dayRanking,
              icon: Icons.calendar_today,
              isCoachRanking: false,
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGETS AUXILIARES ---

  Widget _buildStatCard({required String title, required String value, required IconData icon, required Color color}) {
    return Expanded(
      child: Card(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color, size: 30),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(color: Colors.black87, fontSize: 14)),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(color: color, fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityStatistics() {
    const String todaySessions = '22';
    const String weekSessions = '120';
    const String monthSessions = '480';

    return Row(
      children: [
        _buildStatCard(title: 'Sesiones Hoy', value: todaySessions, icon: Icons.sports_soccer, color: primaryColor),
        const SizedBox(width: 10),
        _buildStatCard(title: 'Semana', value: weekSessions, icon: Icons.calendar_view_week, color: lightBlue),
        const SizedBox(width: 10),
        _buildStatCard(title: 'Mes', value: monthSessions, icon: Icons.calendar_month, color: accentColor),
      ],
    );
  }

  Widget _buildRankingSection(
      BuildContext context, {
        required String title,
        required List<Map<String, dynamic>> rankingList,
        required IconData icon,
        required bool isCoachRanking,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: rankingList.length,
            separatorBuilder: (context, index) => Divider(color: Colors.grey.shade200, height: 1),
            itemBuilder: (context, index) {
              final item = rankingList[index];
              final rank = Text(
                '#${index + 1}',
                style: TextStyle(
                  color: index == 0 ? accentColor : primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              );

              String primaryText;
              String secondaryText;

              if (isCoachRanking) {
                primaryText = item['name']!;
                secondaryText = '${item['score']} pts';
              } else {
                primaryText = item.values.elementAt(0).toString();
                secondaryText = '${item.values.elementAt(1)} sesiones';
              }

              return ListTile(
                leading: rank,
                title: Text(primaryText, style: const TextStyle(fontWeight: FontWeight.w600)),
                trailing: Text(
                  secondaryText,
                  style: TextStyle(color: accentColor, fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
