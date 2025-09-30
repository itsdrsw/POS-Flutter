import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mobile1/theme/app_colors.dart';

class BakeryDashboard extends StatefulWidget {
  const BakeryDashboard({super.key}); // wajib ada super.key

  @override
  State<BakeryDashboard> createState() => BakeryButtonState();
}

class BakeryButtonState extends State<BakeryDashboard> {
  final List<String> bannerImages = const [
    'assets/images/banner-bakery.webp',
    'assets/images/banner-bakery2.webp',
    'assets/images/banner-bakery3.webp',
  ];

  bool isSearching = false;
  final TextEditingController searchController = TextEditingController();

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

  late List<Map<String, String>> filteredProducts;

  @override
  void initState() {
    super.initState();
    filteredProducts = List.from(products); // default semua produk
  }

  void filterProducts() {
    String query = searchController.text.toLowerCase();

    setState(() {
      filteredProducts = products.where((product) {
        final matchesCategory =
            selectedCategory == "All" ||
            product["category"] == selectedCategory;
        final matchesSearch = product["name"]!.toLowerCase().contains(query);
        return matchesCategory && matchesSearch;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? TextField(
                controller: searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: "Search bakery...",
                  border: InputBorder.none,
                ),
                style: const TextStyle(color: Colors.black, fontSize: 16),
                onChanged: (value) => filterProducts(),
              )
            : const Text(
                "Bakery Shop",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
        centerTitle: true,
        actions: [
          isSearching
              ? IconButton(
                  icon: const Icon(Icons.close),
                  color: AppColors.secondary,
                  onPressed: () {
                    setState(() {
                      isSearching = false;
                      searchController.clear();
                      filteredProducts = List.from(products);
                      selectedCategory = "All";
                    });
                  },
                )
              : IconButton(
                  icon: const Icon(Icons.search),
                  color: AppColors.primary,
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              color: AppColors.primary,
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
                      filterProducts();
                      debugPrint("$cat dipencet");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isSelected
                          ? AppColors.primary
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
              child: filteredProducts.isEmpty
                  ? const Center(child: Text("Produk tidak tersedia"))
                  : GridView.builder(
                      shrinkWrap: true,
                      physics:
                          const NeverScrollableScrollPhysics(), //supaya scrollnya ikut Column
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
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
