import 'package:flutter/material.dart';
import 'package:mobile1/theme/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> apps = [
      {
        "icon": Icons.bakery_dining,
        "label": "Casier Bakery",
        "route": "/bakery",
      },
      {
        "icon": Icons.local_bar,
        "label": "Kitchen Bakery",
        "route": "/bar",
      }, // nanti ditambah
      {
        "icon": Icons.restaurant,
        "label": "Casier Restaurant",
        "route": "/restaurant",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Point of Sales",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemCount: apps.length,
        itemBuilder: (context, index) {
          final app = apps[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, app['route']);
            },
            child: Container(
              height: 100, // Tinggi container utama
              margin: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 16,
              ), // Margin bawah antar container
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ), // Padding kiri dan kanan
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(
                  0.2,
                ), // Warna latar belakang
                borderRadius: BorderRadius.circular(24), // Sudut lebih membulat
              ),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // Memberi jarak antar item
                children: [
                  Text(
                    app['label'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.dark,
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF5E0), // Warna krem muda
                      borderRadius: BorderRadius.circular(
                        100,
                      ), // Sudut membulat (bukan lingkaran)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(
                        8.0,
                      ), // Padding di dalam gambar
                      child: Image.asset(
                        "assets/images/kasir.png", // PASTIKAN PATH INI BENAR
                        fit: BoxFit.contain,
                      ),
                    ),
                  ), // Jarak antara gambar dan teks
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
