import 'package:flutter/material.dart';
import './home_page.dart';
import './login_page.dart';
import 'register_page.dart';
import '../navigation/public_sidebar_page.dart';
import 'admin_home_page.dart';

// --- TEXTOS DE LA APP ---
const String _aboutAppText =
    'Bienvenido a ConectaDeportes. Encuentra, crea y gestiona grupos deportivos o recreativos en tu zona. Conecta con personas con tus mismos intereses y disfrutá de una vida más activa.';

const String _aboutUsText =
    'Somos NimbusOps, un equipo apasionado por la tecnología y el deporte. Nuestra misión es fomentar la actividad física y la conexión social mediante una plataforma accesible, moderna y confiable.';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  void _showInfoDialog(BuildContext context, String title, String content, Color accentColor) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(color: accentColor, width: 2.0),
        ),
        title: Text(
          title,
          style: TextStyle(color: accentColor, fontWeight: FontWeight.bold),
        ),
        content: Text(
          content,
          style: const TextStyle(color: Colors.black87, fontSize: 16, height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cerrar',
              style: TextStyle(color: accentColor, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
      BuildContext context, String label, Widget destination, Color color, IconData icon) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 3,
        ),
        icon: Icon(icon, size: 22),
        label: Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;
    final Color secondary = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sinergía +'),
        centerTitle: true,
      ),
      drawer: const PublicSidebar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // 🟢 Subtítulo principal
              const Center(
                child: Text(
                  "Vos pones el plan, nosotros la gente",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF00BFA5), // verde principal del tema
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ),

              // LOGO
              const ImageSection(image: 'assets/images/logo.png', aspectRatio: 1.5),

              const SizedBox(height: 20),

              // TITULO Y DESCRIPCIÓN
              const TitleSection(
                name: 'ConectaDeportes',
                location: 'Activá tu comunidad deportiva',
              ),

              const SizedBox(height: 20),

              // --- BOTONES PRINCIPALES ---
              _buildActionButton(context, 'Iniciar Sesión', const LoginPage(), primary, Icons.login),
              const SizedBox(height: 16),
              _buildActionButton(context, 'Registrarse', const RegisterPage(), secondary, Icons.person_add_alt_1),
              const SizedBox(height: 16),
              _buildActionButton(context, 'Ingresar como Usuario', const HomePage(), primary, Icons.sports_soccer),
              const SizedBox(height: 16),
              _buildActionButton(context, 'Ingresar como Admin', const AdminHomePage(), secondary, Icons.admin_panel_settings),

              const SizedBox(height: 30),

              // --- BOTONES DE INFORMACIÓN ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton.icon(
                    onPressed: () => _showInfoDialog(context, 'Sobre Nosotros', _aboutUsText, primary),
                    icon: Icon(Icons.group, color: primary),
                    label: const Text('Nosotros'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: primary,
                      side: BorderSide(color: primary, width: 1.5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => _showInfoDialog(context, 'Sobre la App', _aboutAppText, secondary),
                    icon: Icon(Icons.info_outline, color: secondary),
                    label: const Text('App'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: secondary,
                      side: BorderSide(color: secondary, width: 1.5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------
// --- SECCIONES AUXILIARES (LOGO, TÍTULO, ETC.) ---
// -----------------------------------------------------------------

class ImageSection extends StatelessWidget {
  const ImageSection({super.key, required this.image, this.aspectRatio = 1.0});
  final String image;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: Image.asset(
        image,
        width: double.infinity,
        fit: BoxFit.contain,
      ),
    );
  }
}

class TitleSection extends StatelessWidget {
  const TitleSection({super.key, required this.name, required this.location});
  final String name;
  final String location;

  @override
  Widget build(BuildContext context) {
    final Color accent = Theme.of(context).colorScheme.secondary;
    return Column(
      children: [
        Text(
          name,
          style: TextStyle(
            color: accent,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          location,
          style: const TextStyle(color: Colors.black54, fontSize: 14),
        ),
      ],
    );
  }
}
