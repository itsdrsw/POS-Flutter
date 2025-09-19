import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> apps = [
      {"icon": Icons.bakery_dining, "label": "Bakery", "route": "/bakery"},
      {
        "icon": Icons.local_bar,
        "label": "Bar",
        "route": "/bar",
      }, // nanti ditambah
      {"icon": Icons.restaurant, "label": "Restaurant", "route": "/restaurant"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Apps Point of Sale",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF9DC183),
          ),
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: apps.length,
        itemBuilder: (context, index) {
          final app = apps[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, app['route']);
            },
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(app['icon'], size: 40, color: const Color(0xFF9DC183)),
                    const SizedBox(height: 10),
                    Text(app['label']),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
