import 'package:flutter/material.dart';

class BakeryCheckout extends StatefulWidget {
  final double total;
  const BakeryCheckout({Key? key, required this.total}) : super(key: key);

  @override
  State<BakeryCheckout> createState() => _BakeryCheckoutState();
}

class _BakeryCheckoutState extends State<BakeryCheckout> {
  String? selectedUser;
  String? selectedPayment;

  final List<String> users = ["Hanoman", "Sinta", "Rama"];
  final List<String> payments = ["Cash", "Transfer Bank", "QRIS"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pilih User
            const Text(
              "Pilih User",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedUser,
              items: users.map((user) {
                return DropdownMenuItem(value: user, child: Text(user));
              }).toList(),
              onChanged: (val) => setState(() => selectedUser = val),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Pilih user",
                isDense: true,
              ),
            ),

            const SizedBox(height: 20),

            // Metode Pembayaran
            const Text(
              "Metode Pembayaran",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedPayment,
              items: payments.map((method) {
                return DropdownMenuItem(value: method, child: Text(method));
              }).toList(),
              onChanged: (val) => setState(() => selectedPayment = val),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Pilih metode pembayaran",
                isDense: true,
              ),
            ),

            const Spacer(),

            // Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total Pembayaran:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  "Rp ${widget.total.toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Tombol Konfirmasi
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedUser == null || selectedPayment == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Harap pilih user dan metode pembayaran!",
                        ),
                      ),
                    );
                    return;
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Pesanan berhasil dibuat untuk $selectedUser",
                      ),
                    ),
                  );

                  Navigator.popUntil(context, ModalRoute.withName('/home'));
                },
                child: const Text("Konfirmasi Pesanan"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
