import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class BakeryDashboard extends StatefulWidget {
  const BakeryDashboard({super.key});

  @override
  State<BakeryDashboard> createState() => BakeryButtonState();
}

class BakeryButtonState extends State<BakeryDashboard> {
  final List<String> bannerImages = const [
    'assets/images/banner-bakery.webp',
    'assets/images/banner-bakery2.webp',
    'assets/images/banner-bakery3.webp',
  ];

  String selectedCategory = "All";

  final List<String> categories = ["All", "Breads", "Pastries"];

  final List<Map<String, String>> products = [
    {
      "name": "Apple Pie",
      "category": "Pastries",
      "image": "assets/images/pastries/Apple-Pie.webp",
      "price": "5000",
    },
    {
      "name": "Bagel",
      "category": "Breads",
      "image": "assets/images/breads/bagel.webp",
      "price": "7000",
    },
    {
      "name": "Rye Bread",
      "category": "Breads",
      "image": "assets/images/breads/rye.webp",
      "price": "20000",
    },
    {
      "name": "Pecan Danish",
      "category": "Pastries",
      "image": "assets/images/pastries/Peican.webp",
      "price": "12000",
    },
    {
      "name": "Wholemeal-loaf",
      "category": "Breads",
      "image": "assets/images/breads/wholemeal-loaf.webp",
      "price": "12000",
    },
    // tambahkan produk lain sesuai kebutuhan
  ];

  @override
  Widget build(BuildContext context) {
    // Filter produk berdasarkan kategori yang dipilih
    List<Map<String, String>> filteredProducts = selectedCategory == "All"
        ? products
        : products
              .where((product) => product["category"] == selectedCategory)
              .toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Bakery Dashboard",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              color: const Color(0xFF9DC183),
              onPressed: () {
                Navigator.pushNamed(context, '/bakery/cart');
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            CarouselSlider(
              options: CarouselOptions(
                height: 180.0,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.9,
                aspectRatio: 16 / 9,
                autoPlayInterval: const Duration(seconds: 3),
              ),
              items: bannerImages.map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        item,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                "Menu Categories",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 10),
            // Tombol Kategori
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                spacing: 10,
                children: categories.map((cat) {
                  final bool isSelected = cat == selectedCategory;
                  return ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedCategory = cat;
                      });
                      print("$cat dipencet");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isSelected
                          ? const Color(0xFF9DC183)
                          : Colors.grey[300],
                      foregroundColor: isSelected ? Colors.white : Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(cat),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(), //supaya scrollnya ikut Column
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3 / 4, // lebar dan tinggi
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10),
                            ),
                            child: Image.asset(
                              product["image"]!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product["name"]!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Rp ${product["price"]}",
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
