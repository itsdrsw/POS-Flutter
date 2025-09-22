import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile1/theme/app_colors.dart';

class BakeryCheckout extends StatefulWidget {
  final double total;
  const BakeryCheckout({Key? key, required this.total}) : super(key: key);

  @override
  State<BakeryCheckout> createState() => _BakeryCheckoutState();
}

class _BakeryCheckoutState extends State<BakeryCheckout> {
  String? selectedUser;
  String? selectedPayment;

  final List<String> users = ["Hanoman", "Sinta", "Rama", "Sinda", "Hendy"];
  final List<String> payments = ["Cash", "Transfer Bank", "QRIS"];
  final formatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

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
              "Pilih Customer",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return const Iterable<String>.empty();
                }
                return users.where(
                  (user) => user.toLowerCase().contains(
                    textEditingValue.text.toLowerCase(),
                  ),
                );
              },
              onSelected: (String selection) {
                setState(() {
                  selectedUser = selection;
                });
              },
              fieldViewBuilder:
                  (context, controller, focusNode, onFieldSubmitted) {
                    return TextFormField(
                      controller: controller,
                      focusNode: focusNode,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.bold,
                            width: 2,
                          ),
                        ),
                        hintText: "Masukkan atau pilih customer",
                        isDense: true,
                      ),
                    );
                  },
            ),
            // DropdownButtonFormField<String>(
            //   value: selectedUser,
            //   items: users.map((user) {
            //     return DropdownMenuItem(value: user, child: Text(user));
            //   }).toList(),
            //   onChanged: (val) => setState(() => selectedUser = val),
            //   decoration: const InputDecoration(
            //     border: OutlineInputBorder(),
            //     hintText: "Pilih customer",
            //     isDense: true,
            //   ),
            // ),
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
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.bold, width: 2),
                ),
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
                  formatter.format(widget.total),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Tombol Konfirmasi
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: AppColors.primary,
                  fixedSize: const Size(80, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
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
                child: const Text(
                  "Konfirmasi Pesanan",
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
