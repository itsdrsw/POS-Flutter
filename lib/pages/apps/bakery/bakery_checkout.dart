import 'package:flutter/material.dart';

class BakeryCheckout extends StatelessWidget {
  const BakeryCheckout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const ListTile(
              leading: Icon(Icons.location_on),
              title: Text("Alamat Pengiriman"),
              subtitle: Text("Jl. Contoh No.123, Jakarta"),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.payment),
              title: Text("Metode Pembayaran"),
              subtitle: Text("Transfer Bank"),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Pesanan berhasil dibuat!")),
                );
                Navigator.popUntil(context, ModalRoute.withName('/home'));
              },
              child: const Text("Konfirmasi Pesanan"),
            ),
          ],
        ),
      ),
    );
  }
}
