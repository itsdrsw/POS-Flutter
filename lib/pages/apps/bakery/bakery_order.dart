import 'package:flutter/material.dart';

class BakeryOrder extends StatelessWidget {
  const BakeryOrder({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> orders = [
      {"id": "ORD001", "status": "Pending"},
      {"id": "ORD002", "status": "Completed"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("My Orders")),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: const Icon(Icons.receipt_long),
              title: Text("Order ${order['id']}"),
              subtitle: Text("Status: ${order['status']}"),
            ),
          );
        },
      ),
    );
  }
}
