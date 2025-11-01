import 'package:flutter/material.dart';
import '../navigation/app_nav_items.dart';
import '../navigation/sidebar_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;
    final Color secondary = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const Sidebar(),
      appBar: AppBar(
        backgroundColor: primary,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            color: Colors.white,
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text(
          mainNavItems[_currentIndex].label,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: IndexedStack(
        index: _currentIndex,
        children: mainNavItems.map((item) => item.pageContent).toList(),
      ),

      bottomNavigationBar: NavigationBar(
        backgroundColor: primary,
        indicatorColor: secondary.withOpacity(0.2),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: [
          for (var item in mainNavItems)
            NavigationDestination(
              icon: Icon(item.icon, color: Colors.white),
              label: item.label,
            ),
        ],
      ),
    );
  }
}

// Página de ejemplo para contenido principal
class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color accent = Theme.of(context).colorScheme.secondary;

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: const [
          ProductCard(title: "Partido de fútbol 5", price: "Nivel: Intermedio", icon: Icons.sports_soccer),
          ProductCard(title: "Trekking en el parque", price: "Duración: 2h", icon: Icons.terrain),
          ProductCard(title: "Clase de yoga grupal", price: "Nivel: Principiante", icon: Icons.self_improvement),
          ProductCard(title: "Básquet recreativo", price: "Mixto - Todos los niveles", icon: Icons.sports_basketball),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final IconData icon;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;
    final Color secondary = Theme.of(context).colorScheme.secondary;

    return Card(
      color: Colors.grey.shade100,
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: primary, size: 32),
        title: Text(
          title,
          style: TextStyle(
            color: secondary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          price,
          style: const TextStyle(color: Colors.black87, fontSize: 15),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black45),
      ),
    );
  }
}
