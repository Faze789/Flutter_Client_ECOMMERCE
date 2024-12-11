// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:pak_wheels_application/buyer_collection/filter_data.dart';
// import 'package:pak_wheels_application/buyer_collection/selected_item.dart';
// import 'package:provider/provider.dart';

// import '../providers/buyer_provider.dart';

// class filter_result extends StatefulWidget {
//   const filter_result({super.key});

//   @override
//   State<filter_result> createState() => _filter_resultState();
// }

// class _filter_resultState extends State<filter_result> {
//   final List<Color> colorsList = [
//     Color(0xFFF4B3C2), // Soft Pink Blossom
//     Color(0xFFFAD1A1), // Light Peach Sorbet
//     Color(0xFFBBDED6), // Mint Aqua Mist
//     Color(0xFFFFE4C3), // Pale Sunset Gold
//     Color(0xFFE6E2F8), // Soft Lavender Glow
//     Color(0xFFFFC1CC), // Bright Blush Pink
//     Color(0xFFF9E8A3), // Pastel Lemon Zest
//     Color(0xFFFAD3E7), // Cotton Candy Pink
//     Color(0xFFF3E6F1), // Orchid Lilac
//     Color(0xFFFFF2CD), // Soft Buttercream Yellow
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<buyer_provider>(context, listen: false);
//     return Scaffold(
//       backgroundColor: Colors.grey,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: Text(
//           'Shopping Application',
//           style: GoogleFonts.lato(
//             textStyle: const TextStyle(
//               fontSize: 20.0,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//         ),
//         centerTitle: true,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//             Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => FilterScreen()));
//           },
//           icon: const Icon(
//             Icons.filter_alt_rounded,
//             color: Colors.green,
//           ),
//         ),
//       ),
//       body: FutureBuilder<void>(
//         future: provider.get_filtered_data(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           return ListView.builder(
//             padding: const EdgeInsets.all(8.0),
//             itemCount: provider.product_name_sell_to_buyer.length,
//             itemBuilder: (ctx, index) {
//               final randomColor = colorsList[Random().nextInt(colorsList.length)];

//               return InkWell(
//                 onTap: () {
//                   print(provider.seller_id123[index]);
//                   Navigator.of(context).pop();
//                   Navigator.of(context).pushAndRemoveUntil(
//                     MaterialPageRoute(
//                       builder: (ctx) => selected_item(
//                         seller_unique_id: provider.seller_id123[index],
//                         product_unique_id: provider.product_unique_id[index],
//                         user_unique_id: provider.buyer_unique_id,
//                         product_name: provider.product_name_sell_to_buyer[index],
//                         product_price: provider.product_price_sell_to_buyer[index],
//                         seller_name: provider.seller_name_sell_to_buyer[index],
//                         warranty: provider.product_warranty_sell_to_buyer[index],
//                         product_image: provider.product_iamge_link_sell_to_buyer[index],
//                       ),
//                     ),
//                     (route) => false,
//                   );
//                 },
//                 child: Card(
//                   color: randomColor,
//                   elevation: 2,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(6.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Display product image
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(8.0),
//                           child: Image.network(
//                             provider.product_iamge_link_sell_to_buyer[index],
//                             width: double.infinity,
//                             height: 180, // Adjusted height for the image
//                             errorBuilder: (context, error, stackTrace) {
//                               return Container(
//                                 color: Colors.grey[300],
//                                 height: 80, // Adjusted to match the image size
//                                 child: const Center(
//                                   child: Icon(Icons.broken_image, color: Colors.grey),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                         const SizedBox(height: 4), // Reduced spacing
//                         // Display product name
//                         Center(
//                           child: Text(
//                             provider.product_name_sell_to_buyer[index].toUpperCase(),
//                             style: GoogleFonts.abhayaLibre(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                             textAlign: TextAlign.center,
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                         const SizedBox(height: 2), // Reduced spacing
//                         // Display seller name
//                         Center(
//                           child: Text(
//                             provider.seller_name_sell_to_buyer[index].toUpperCase(),
//                             style: GoogleFonts.abhayaLibre(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                             textAlign: TextAlign.center,
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                         const SizedBox(height: 2),
//                         Center(
//                           child: Text(
//                             'Price: \$${provider.product_price_sell_to_buyer[index].toString()}',
//                             style: GoogleFonts.abhayaLibre(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                         const SizedBox(height: 2),
//                         Center(
//                           child: Text(
//                             'Warranty: ${provider.product_warranty_sell_to_buyer[index]}',
//                             style: GoogleFonts.abhayaLibre(
//                               fontSize: 16,
//                               color: Colors.black,
//                             ),
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                         const SizedBox(height: 2),
//                         Center(
//                           child: Text(
//                             'Quality: ${provider.product_quality_sell_to_buyer[index]}',
//                             style: GoogleFonts.abhayaLibre(
//                               fontSize: 16,
//                               color: Colors.black,
//                             ),
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
