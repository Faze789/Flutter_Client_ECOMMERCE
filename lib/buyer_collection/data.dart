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
    print('Triggered or not Triggered');

    double percentage = 0.0;

    bool percent_check = false;

    final screenWidth = MediaQuery.of(context).size.width;

    int i = 0;

    initState() {
      super.initState();
      Provider.of<buyer_provider>(context, listen: false).get_all_sellers_data();
    }

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
          )),
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
      body: FutureBuilder(
        future: Provider.of<buyer_provider>(context, listen: false).get_all_sellers_data(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            print('checking on uuu 1');
            return Consumer<buyer_provider>(
              builder: (context, buyerProvider, child) {
                if (buyerProvider.product_name_sell_to_buyer.isEmpty) {
                  return const Center(child: Text('No products available'));
                }
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: screenWidth * 0.01,
                    crossAxisSpacing: screenWidth * 0.01,
                    childAspectRatio: screenWidth > 600 ? 1.5 : 0.6,
                  ),
                  padding: EdgeInsets.all(screenWidth * 0.02),
                  itemCount: buyerProvider.product_name_sell_to_buyer.length,
                  itemBuilder: (ctx, index) {
                    Color randomColor;

                    if (index >= colorsList.length) {
                      randomColor = colorsList[i];
                      i++;
                      if (i >= colorsList.length) {
                        i = 0;
                      }
                    } else {
                      randomColor = colorsList[index];
                    }

                    print('checking on uuu 2');

                    return InkWell(
                      onTap: () {
                        print('-------------------');
                        print(buyerProvider.product_price_sell_to_buyer[index]);
                        buyerProvider.changed_price(buyerProvider.product_price_sell_to_buyer[index]);
                        print('-------------------');

                        print(buyerProvider.product_price_sell_to_buyer[index]);
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (ctx) => selected_item(
                              seller_unique_id: buyerProvider.seller_id123[index],
                              product_unique_id: buyerProvider.product_unique_id[index],
                              user_unique_id: widget.user_unique_id,
                              product_name: buyerProvider.product_name_sell_to_buyer[index],
                              product_price: buyerProvider.product_price_sell_to_buyer[index],
                              seller_name: buyerProvider.seller_name_sell_to_buyer[index],
                              warranty: buyerProvider.product_warranty_sell_to_buyer[index],
                              product_image: buyerProvider.product_iamge_link_sell_to_buyer[index],
                            ),
                          ),
                          (route) => false,
                        );
                      },
                      child: Container(
                        color: randomColor,
                        width: 800,
                        height: 1600,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  buyerProvider.product_iamge_link_sell_to_buyer[index],
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
                                      buyerProvider.product_name_sell_to_buyer[index].toUpperCase(),
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
                                      buyerProvider.seller_name_sell_to_buyer[index].toUpperCase(),
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
                              const SizedBox(height: 2),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.price_change_sharp),
                                  const SizedBox(width: 10),
                                  Text(
                                    '\$${buyerProvider.product_price_sell_to_buyer[index].toString()}',
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
                              const SizedBox(height: 2),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(FontAwesomeIcons.shield),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${buyerProvider.product_warranty_sell_to_buyer[index]}',
                                    style: GoogleFonts.abhayaLibre(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      buyerProvider.change_favorite(index);
                                    },
                                    icon: Icon(
                                      buyerProvider.favorites[index] ? Icons.favorite : Icons.favorite_border,
                                      color: buyerProvider.favorites[index] ? Colors.red : Colors.black,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      if (percent_check == false) {
                                        percent_check = true;
                                        percentage = double.parse(buyerProvider.product_price_sell_to_buyer[index].toString());
                                        percentage = percentage * 0.75;
                                      }

                                      print(percentage);

                                      buyerProvider.change_price(index, percentage);
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
            );
          }
        },
      ),
    );
  }
}
