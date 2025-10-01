import 'package:flutter/material.dart';
import 'bakery_setting.dart';
import 'package:mobile1/pages/apps/bakery/scan.dart';
import 'bakery_dashboard.dart';
import '../../../theme/app_colors.dart';

class BakeryNavbar extends StatefulWidget {
  const BakeryNavbar({super.key});

  @override
  State<BakeryNavbar> createState() => _BakeryNavbarState();
}

class _BakeryNavbarState extends State<BakeryNavbar> {
  int _currentIndex = 0;

  // 🔑 Key untuk akses state BakeryDashboard
  final GlobalKey<BakeryButtonState> dashboardKey = GlobalKey();

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      BakeryDashboard(key: dashboardKey),
      const Center(child: Text("Settings Page")),
      const BakerySetting(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      // Custom Navbar
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, 0),
            _buildNavItem(Icons.qr_code_scanner_rounded, 1), // scan
            _buildNavItem(Icons.person, 2),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    final isSelected =
        _currentIndex == index && index != 1; // scan bukan tab permanen

    return GestureDetector(
      onTap: () async {
        if (index == 1) {
          // 📷 buka Scanner
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ScannerScreen()),
          );

          if (result != null && result is String) {
            // balik ke dashboard
            setState(() {
              _currentIndex = 0;
            });

            // kasih delay biar dashboard kebuka dulu
            Future.delayed(const Duration(milliseconds: 300), () {
              final state = dashboardKey.currentState;
              if (state != null) {
                state.setState(() {
                  state.isSearching = true;
                  state.searchController.text = result;
                });
                state.filterProducts();
              }
            });
          }
        } else {
          setState(() {
            _currentIndex = index;
          });
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.secondary.withOpacity(0.5),
                    blurRadius: 25,
                    offset: const Offset(0, 5),
                  ),
                ]
              : [],
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.grey,
          size: 24,
        ),
      ),
    );
  }
}
