// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';

// class BakeryDashboard extends StatelessWidget {
//   const BakeryDashboard({super.key});

//   final List<String> bannerImages = const [
//     'assets/images/banner-bakery.jpg',
//     'assets/images/banner-bakery2.jpg',
//     'assets/images/banner-bakery3.jpg',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Bakery Dashboard",
//           style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
//         ),
//         centerTitle: true,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 10.0),
//             child: IconButton(
//               icon: const Icon(Icons.shopping_cart),
//               color: const Color(0xFF9DC183),
//               onPressed: () {
//                 Navigator.pushNamed(context, '/bakery/cart');
//               },
//             ),
//           ),
//         ],
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 10),
//           CarouselSlider(
//             options: CarouselOptions(
//               height: 180.0,
//               autoPlay: true,
//               enlargeCenterPage: true,
//               viewportFraction: 0.9,
//               aspectRatio: 16 / 9,
//               autoPlayInterval: const Duration(seconds: 3),
//             ),
//             items: bannerImages.map((item) {
//               return Builder(
//                 builder: (BuildContext context) {
//                   return ClipRRect(
//                     borderRadius: BorderRadius.circular(15),
//                     child: Image.asset(
//                       item,
//                       fit: BoxFit.cover,
//                       width: MediaQuery.of(context).size.width,
//                     ),
//                   );
//                 },
//               );
//             }).toList(),
//           ),
//           const SizedBox(height: 20),
//           const Padding(
//             padding: EdgeInsets.only(left: 16.0), // jarak dari kiri
//             child: Text(
//               "Menu Kategori",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//               textAlign: TextAlign.left,
//             ),
//           ),
//           const SizedBox(height: 10),

//           // Tombol Kategori
//           // 🔥 Tombol kategori
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Wrap(
//               spacing: 10, // jarak horizontal antar tombol
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     print("All tapped");
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(
//                       0xFF9DC183,
//                     ), // warna hijau pastel
//                     foregroundColor: Colors.white, // warna teks
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                   ),
//                   child: const Text("All"),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     print("Bread tapped");
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.grey[200],
//                     foregroundColor: Colors.black,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                   ),
//                   child: const Text("Bread"),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     print("Pastries tapped");
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.grey[200],
//                     foregroundColor: Colors.black,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                   ),
//                   child: const Text("Pastries"),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
