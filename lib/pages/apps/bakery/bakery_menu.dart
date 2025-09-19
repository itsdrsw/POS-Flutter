import 'package:flutter/material.dart';

class BakeryMenu extends StatelessWidget {
  const BakeryMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> products = [
      {"name": "Croissant", "price": 20000},
      {"name": "Chocolate Cake", "price": 50000},
      {"name": "Donut", "price": 15000},
      {"name": "Baguette", "price": 25000},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Bakery Menu")),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final item = products[index];
          return ListTile(
            leading: const Icon(Icons.bakery_dining),
            title: Text(item['name']),
            subtitle: Text("Rp ${item['price']}"),
            trailing: IconButton(
              icon: const Icon(Icons.add_shopping_cart),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("${item['name']} added to cart")),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
