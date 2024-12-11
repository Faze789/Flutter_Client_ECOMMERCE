import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pak_wheels_application/buyer_collection/cart_collection.dart';
import 'package:pak_wheels_application/buyer_collection/selected_item.dart';
import 'package:pak_wheels_application/screens/home.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/buyer_provider.dart';

class data extends StatefulWidget {
  data({super.key, required this.user_unique_id});

  String user_unique_id;

  @override
  State<data> createState() => _dataState();
}

class _dataState extends State<data> {
  final List<Color> colorsList = [
    const Color(0xFFF4B3C2),
    const Color(0xFFFAD1A1),
    const Color(0xFFBBDED6),
    const Color(0xFFFFE4C3),
    const Color(0xFFE6E2F8),
    const Color(0xFFFFC1CC),
    const Color(0xFFF9E8A3),
    const Color(0xFFFAD3E7),
    const Color(0xFFF3E6F1),
    const Color(0xFFFFF2CD),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          widget.user_unique_id,
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final buyerProvider = Provider.of<buyer_provider>(context, listen: false);
              bool check_if_user_has_bought_something_before = await buyerProvider.find_data_in_add_to_cart_collection(widget.user_unique_id);

              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (ctx) => cart_collection(
                    buyer_unique_id: widget.user_unique_id,
                    cart_has_data_or_not: check_if_user_has_bought_something_before,
                  ),
                ),
                (route) => false,
              );
            },
            icon: const Icon(Icons.shopping_cart, color: Colors.yellow),
          ),
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(Icons.refresh, color: Colors.blue),
          ),
          IconButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.clear();

              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (ctx) => const home()),
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout, color: Colors.red),
          ),
        ],
        centerTitle: true,
      ),
      body: Consumer<buyer_provider>(
        builder: (context, buyer_, child) {
          final productNames = buyer_.product_name_sell_to_buyer;

          if (productNames.isEmpty) {
            // print(8338);
            buyer_.get_all_sellers_data();
            return const Center(child: CircularProgressIndicator());
          }

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: screenWidth * 0.02,
              crossAxisSpacing: screenWidth * 0.02,
              childAspectRatio: screenWidth > 600 ? 1 : 0.8,
            ),
            padding: EdgeInsets.all(screenWidth * 0.02),
            itemCount: productNames.length,
            itemBuilder: (ctx, index) {
              print(1234);
              final randomColor = colorsList[Random().nextInt(colorsList.length)];

              return InkWell(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (ctx) => selected_item(
                        seller_unique_id: buyer_.seller_id123[index],
                        product_unique_id: buyer_.product_unique_id[index],
                        user_unique_id: widget.user_unique_id,
                        product_name: productNames[index],
                        product_price: buyer_.product_price_sell_to_buyer[index],
                        seller_name: buyer_.seller_name_sell_to_buyer[index],
                        warranty: buyer_.product_warranty_sell_to_buyer[index],
                        product_image: buyer_.product_iamge_link_sell_to_buyer[index],
                      ),
                    ),
                    (route) => false,
                  );
                },
                child: Card(
                  color: randomColor,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            buyer_.product_iamge_link_sell_to_buyer[index],
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.2,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[300],
                                height: MediaQuery.of(context).size.height * 0.2,
                                child: const Center(
                                  child: Icon(Icons.broken_image, color: Colors.grey),
                                ),
                              );
                            },
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                productNames[index].toUpperCase(),
                                style: GoogleFonts.abhayaLibre(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                buyer_.seller_name_sell_to_buyer[index].toUpperCase(),
                                style: GoogleFonts.abhayaLibre(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.price_change_sharp),
                            const SizedBox(width: 10),
                            Text(
                              '\$${buyer_.product_price_sell_to_buyer[index].toString()}',
                              style: GoogleFonts.abhayaLibre(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(FontAwesomeIcons.shield),
                            const SizedBox(width: 4),
                            Text(
                              '${buyer_.product_warranty_sell_to_buyer[index]}',
                              style: GoogleFonts.abhayaLibre(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              onPressed: () {
                                buyer_.change_favorite(index);
                              },
                              icon: buyer_.favorites[index]
                                  ? const Icon(Icons.favorite, color: Colors.red)
                                  : const Icon(Icons.favorite_border, color: Colors.black),
                            ),
                            IconButton(
                              onPressed: () {
                                buyer_.display(buyer_.product_price_sell_to_buyer[index], index);
                              },
                              icon: const Icon(Icons.discount),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
