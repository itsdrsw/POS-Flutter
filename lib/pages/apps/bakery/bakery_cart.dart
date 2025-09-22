import 'package:flutter/material.dart';
import 'package:mobile1/pages/apps/bakery/bakery_checkout.dart';
import 'package:intl/intl.dart';
import 'package:mobile1/theme/app_colors.dart';

class BakeryCart extends StatefulWidget {
  const BakeryCart({super.key});

  @override
  State<BakeryCart> createState() => _BakeryCartState();
}

class _BakeryCartState extends State<BakeryCart> {
  final List<Map<String, dynamic>> cartItems = [
    {"name": "Croissant", "qty": 2, "price": 20000},
    {"name": "Donut", "qty": 3, "price": 150000},
  ];

  final formatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  late List<TextEditingController> qtyControllers;

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller sesuai jumlah cartItems
    qtyControllers = cartItems
        .map((item) => TextEditingController(text: item['qty'].toString()))
        .toList();
  }

  @override
  void dispose() {
    for (var controller in qtyControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Cart",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final item = cartItems[index];

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bagian utama pakai Expanded biar fleksibel
                Expanded(
                  child: ListTile(
                    leading: const Icon(
                      Icons.bakery_dining,
                      color: AppColors.secondary,
                    ),
                    title: Text(item['name']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Baris QTY
                        Row(
                          children: [
                            const Text("Qty: "),
                            SizedBox(
                              width: 60,
                              child: TextField(
                                controller: qtyControllers[index],
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: const InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 12,
                                  ),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.bold,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                onChanged: (val) {
                                  int? newQty = int.tryParse(val);
                                  if (newQty != null) {
                                    setState(() {
                                      item['qty'] = newQty;
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        if (item['note'] != null &&
                            item['note'].toString().isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              "Note: ${item['note']}",
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                      ],
                    ),
                    trailing: Transform.translate(
                      offset: const Offset(24, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            // "Rp ${item['qty'] * item['price']}",
                            formatter.format(item['qty'] * item['price']),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(
                                Icons.local_offer,
                                size: 14,
                                color: Colors.redAccent,
                              ),
                              SizedBox(width: 3),
                              Text(
                                "10%",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                "Rp. 6000",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.italic,
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Colors.red,
                                  decorationThickness: 2,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Kolom tambahan di samping ListTile
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.grey),
                      iconSize: 16,
                      onPressed: () {
                        _showNoteDialog(context, index);
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.10),
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
            final double total = cartItems.fold<double>(0.0, (sum, item) {
              final qty = (item['qty'] as num).toDouble();
              final price = (item['price'] as num).toDouble();
              return sum + qty * price;
            });
            Navigator.pushNamed(context, '/bakery/checkout', arguments: total);
          },
          child: const Text(
            "Checkout",
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
          ),
        ),
      ),
    );
  }

  void _showNoteDialog(BuildContext context, int index) {
    final TextEditingController noteController = TextEditingController(
      text: cartItems[index]['note'],
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Note"),
          content: TextField(
            controller: noteController,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: "Enter your note here",
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.bold),
              ),
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(foregroundColor: AppColors.danger),
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: const Text("Save"),
              onPressed: () {
                setState(() {
                  cartItems[index]['note'] = noteController.text;
                });
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }
}
