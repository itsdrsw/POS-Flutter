import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mobile1/pages/apps/bakery/ProductDetailPage.dart';
import 'package:mobile1/theme/app_colors.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';
import 'package:mobile1/widget/animated_snackbar.dart';

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

  final formater = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  bool isLoading = true;
  bool isSearching = false;
  final TextEditingController searchController = TextEditingController();

  String selectedCategory = "All";
  int? selectedTable; // simpan nomor meja yang dipilih
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
    // Simulasi loading data
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  // int? selectedTable;
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

  Widget shimmerCard() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        width: double.infinity,
        height: 200.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
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
            // Tombol Pilih Meja + Tampilkan Meja Terpilih
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.success,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 40,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () async {
                      final result = await _showTableBottomSheet(context);
                      if (result != null) {
                        setState(() {
                          selectedTable = result; // simpan pilihan
                        });
                        debugPrint("Meja dipilih: $result");
                      }
                      debugPrint("Pilih Meja Ditekan");
                    },
                    icon: const Icon(Icons.table_restaurant),
                    label: const Text(
                      "Pilih Meja",
                      style: TextStyle(
                        fontSize: 16, //ukuran font
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  if (selectedTable != null)
                    Container(
                      constraints: const BoxConstraints(
                        minWidth: 100,
                      ), // biar ada jarak
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Meja Nomor $selectedTable",
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 20), // jarak teks ↔ ikon
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedTable = null; // reset pilihan
                              });
                            },
                            child: const Icon(
                              Icons.close,
                              size: 18,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 24.0),
              child: Text(
                "Menu Categories",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 10),
            // Tombol Kategori
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Wrap(
                spacing: 24,
                children: categories.map((cat) {
                  final bool isSelected = cat == selectedCategory;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = cat;
                      });
                      filterProducts();
                      debugPrint("$cat dipencet");
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          cat,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: isSelected ? AppColors.primary : Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          height: 2,
                          width: isSelected ? 30 : 0,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.all(10),
              child: isLoading
                  ? GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 3 / 4,
                          ),
                      itemCount: 6, // jumlah shimmer placeholder
                      itemBuilder: (context, index) => shimmerCard(),
                    )
                  : filteredProducts.isEmpty
                  ? const Center(child: Text("Produk tidak tersedia"))
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 3 / 4,
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
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(10),
                                      ),
                                      child: Image.asset(
                                        product["image"]!,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                                    ),
                                    Positioned(
                                      top: 2,
                                      right: 2,
                                      child: Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          color: Colors
                                              .black12, // background semi transparan
                                          shape: BoxShape.circle, // bikin bulat
                                        ),
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.info_outline,
                                            color: Colors.white,
                                            size: 24,
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    ProductDetailPage(
                                                      product: product,
                                                    ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // Nama + harga
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product["name"]!,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          formater.format(
                                            int.parse(product["price"]!),
                                          ),
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Icon keranjang
                                    Container(
                                      // decoration: BoxDecoration(
                                      //   color: AppColors.success.withOpacity(
                                      //     0.2,
                                      //   ), // background hijau muda
                                      //   borderRadius: BorderRadius.circular(8),
                                      // ),
                                      /// CART SECTION
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.shopping_cart_outlined,
                                          color: AppColors.success,
                                        ),
                                        onPressed: () {
                                          if (selectedTable == null) {
                                            AnimatedSnackbar.show(
                                              context,
                                              "Harap pilih meja terlebih dahulu!",
                                              type: SnackbarType.warning,
                                            );
                                          } else {
                                            Navigator.pushNamed(
                                              context,
                                              '/bakery/cart',
                                            );
                                            AnimatedSnackbar.show(
                                              context,
                                              "Produk ${product["name"]} berhasil ditambahkan ke keranjang!",
                                              type: SnackbarType.success,
                                            );
                                          }
                                          // Bisa panggil fungsi addToCart(product);
                                        },
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

Future<int?> _showTableBottomSheet(BuildContext context) {
  int? selectedTable;

  return showModalBottomSheet<int>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (ctx) {
      return StatefulBuilder(
        builder: (context, setModalState) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.7, // tinggi 70%
            child: Column(
              children: [
                // ===== TITLE =====
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "PILIH MEJA",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),

                // ===== GRID MEJA =====
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4, // 4 meja per baris
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1,
                        ),
                    itemCount: 25, // jumlah meja
                    itemBuilder: (context, index) {
                      final mejaNo = index + 1;
                      final isSelected = selectedTable == mejaNo;

                      return GestureDetector(
                        onTap: () {
                          setModalState(() {
                            selectedTable = mejaNo;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.success
                                : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.success,
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Meja $mejaNo",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // ===== TOMBOL KONFIRMASI =====
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: selectedTable == null
                        ? null
                        : () {
                            Navigator.pop(context, selectedTable);
                          },
                    child: const Text(
                      "Konfirmasi",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
