import 'package:flutter/material.dart';
import 'package:mobile1/pages/apps/bakery/bakery_cart.dart';
import 'package:mobile1/pages/apps/bakery/bakery_checkout.dart';
import 'package:mobile1/pages/apps/bakery/bakery_menu.dart';
import 'package:mobile1/pages/apps/bakery/bakery_navbar.dart';
import 'package:mobile1/pages/apps/bakery/bakery_order.dart';

// Import pages
import 'pages/auth/splash_screen.dart';
import 'pages/auth/login_screen.dart';
import 'pages/auth/register_screen.dart';
import 'pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Odoo Mobile',
      debugShowCheckedModeBanner: false, // hilangin banner demo
      // Halaman pertama
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomePage(),

        //routing untuk aplikasi bakery
        '/bakery': (context) => const BakeryNavbar(),
        '/bakery/menu': (context) => const BakeryMenu(),
        '/bakery/order': (context) => const BakeryOrder(),
        '/bakery/cart': (context) => const BakeryCart(),
        '/bakery/checkout': (context) {
          final total = ModalRoute.of(context)!.settings.arguments as double;
          return BakeryCheckout(total: total);
        },
      },
    );
  }
}
