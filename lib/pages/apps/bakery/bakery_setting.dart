import 'package:flutter/material.dart';
import 'package:mobile1/theme/app_colors.dart';

class BakerySetting extends StatelessWidget {
  const BakerySetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pengaturan",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.background,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.background,
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),
          // Foto profil / logo di tengah
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: Image.asset(
                'assets/images/kasir.png',
                height: 120,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 32),

          // Menu Pengaturan
          _buildMenuItem(Icons.person, "Akun Saya", () {
            // TODO: aksi untuk akun
          }),
          _buildMenuItem(Icons.history, "Riwayat Order", () {
            // TODO: aksi untuk riwayat
          }),
          _buildMenuItem(Icons.add_box, "Tambah Produk", () {
            // TODO: aksi untuk tambah produk
          }),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.primary),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
