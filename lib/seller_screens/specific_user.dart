import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pak_wheels_application/appcolors.dart';
import 'package:pak_wheels_application/providers/seller_provider.dart';
import 'package:pak_wheels_application/screens/screen1.dart';
import 'package:pak_wheels_application/seller_screens/add_posts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class specific_seller_ads extends StatefulWidget {
  const specific_seller_ads({super.key, this.seller_id, this.email, this.password});
  final String? email;
  final String? password;
  final seller_id;

  @override
  State<specific_seller_ads> createState() => _specific_seller_adsState();
}

class _specific_seller_adsState extends State<specific_seller_ads> {
  @override
  Widget build(BuildContext context) {
    String email = widget.email ?? 'abc@example.com';
    String password = widget.password ?? 'kkk';

    if (widget.email == null || widget.password == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Email or Password is missing!'),
        ),
      );
    }
    ;

    final provider = context.read<seller_provider>();

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          // title: Text(widget.seller_id),
          backgroundColor: AppColors.myCustomColor2,
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  email,
                  style: const TextStyle(color: Colors.white),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.refresh,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            IconButton(
                icon: const Icon(Icons.exit_to_app, color: Colors.white),
                onPressed: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.remove('jwt_token');
                  await prefs.remove('email');
                  await prefs.remove('seller_id');
                  await prefs.remove('password');

                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (ctx) => const screen1()),
                    (route) => false,
                  );
                }),
            IconButton(
              icon: const Icon(Icons.add, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (ctx) => AddOrEditAds(
                      email: widget.email,
                      password: widget.password,
                      seller_id: widget.seller_id,
                      edit: false,
                    ),
                  ),
                  (route) => false,
                );
              },
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'Seller ADS Cart',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.myCustomColor12,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: FutureBuilder<bool>(
                    future: provider.check_all_posts_of_specific_user(widget.seller_id!),
                    builder: (ctx, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'Error: ${snapshot.error}',
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      } else if (snapshot.hasData) {
                        if (snapshot.data == true) {
                          return Consumer<seller_provider>(
                            builder: (context, provider1, child) {
                              return ListView.builder(
                                itemCount: provider1.product_name.length,
                                itemBuilder: (ctx, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.myCustomColor13,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      padding: const EdgeInsets.all(16),
                                      child: SizedBox(
                                        height: MediaQuery.of(context).size.height * 0.4,
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              top: 0,
                                              left: 0,
                                              right: 0,
                                              child: Image.network(
                                                provider1.getProductImage[index],
                                                width: double.infinity,
                                                height: MediaQuery.of(context).size.height * 0.2,
                                              ),
                                            ),
                                            Positioned(
                                              top: MediaQuery.of(context).size.height * 0.22,
                                              left: 16,
                                              right: 16,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Row(
                                                          children: [
                                                            const Icon(FontAwesomeIcons.box),
                                                            const SizedBox(
                                                              width: 8,
                                                            ),
                                                            Text(
                                                              '${provider1.getProductName[index]}'.toUpperCase(),
                                                              style: const TextStyle(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Expanded(
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            const Icon(FontAwesomeIcons.certificate),
                                                            const SizedBox(width: 8),
                                                            Text(
                                                              '${provider1.getProductQuality[index]}'.toUpperCase(),
                                                              style: const TextStyle(color: Colors.white),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Row(
                                                          children: [
                                                            const Icon(FontAwesomeIcons.shield),
                                                            const SizedBox(width: 8),
                                                            Text(
                                                              ' ${provider1.getProductWarranty[index]}'.toUpperCase(),
                                                              style: const TextStyle(color: Colors.white),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          const Icon(FontAwesomeIcons.dollarSign),
                                                          Text(
                                                            'Price: \$${provider1.getProductPrice[index]}'.toUpperCase(),
                                                            style: const TextStyle(color: Colors.white),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Row(
                                                    children: [
                                                      // TextButton(
                                                      //   onPressed: () {
                                                      //     Navigator.of(context).pushAndRemoveUntil(
                                                      //       MaterialPageRoute(
                                                      //         builder: (ctx) => AddOrEditAds(
                                                      //           email: widget.email,
                                                      //           password: widget.password,
                                                      //           // seller_name: provider.seller_name_123[index],
                                                      //           price: provider1.product_price[index],
                                                      //           name: provider1.product_name[index],
                                                      //           image: provider1.product_image[index],
                                                      //           warranty: provider1.product_warranty[index],
                                                      //           quality: provider1.product_quality[index],
                                                      //           edit: true,
                                                      //         ),
                                                      //       ),
                                                      //       (route) => false,
                                                      //     );
                                                      //   },
                                                      //   child: const Center(
                                                      //     child: Text(
                                                      //       'EDIT',
                                                      //       style: TextStyle(color: Colors.yellow, fontSize: 16),
                                                      //     ),
                                                      //   ),
                                                      // ),
                                                      const SizedBox(width: 8),
                                                      TextButton(
                                                        onPressed: () async {
                                                          if (index >= 0 && index < provider1.getProductName.length) {
                                                            bool del_check =
                                                                await provider1.delete_specific_item_via_unique_id(provider1.getUniqueId[index]);
                                                            print(provider1.getUniqueId[index]);
                                                            provider1.deleteIndexDataFromList(index);

                                                            if (del_check) {
                                                              print('deleted');
                                                            } else {
                                                              print('not deleted');
                                                            }
                                                          } else {
                                                            print("Invalid index: $index");
                                                          }
                                                        },
                                                        child: const Center(
                                                          child: Text(
                                                            'DELETE',
                                                            style: TextStyle(color: Colors.red, fontSize: 16),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
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
                        } else {
                          return const Center(
                            child: Text(
                              'Currently no posts available',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }
                      } else {
                        return const Center(
                          child: Text(
                            'No posts found',
                            style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
