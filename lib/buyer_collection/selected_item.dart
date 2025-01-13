import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pak_wheels_application/buyer_collection/data.dart';
import 'package:pak_wheels_application/providers/buyer_provider.dart';
import 'package:provider/provider.dart';

class selected_item extends StatefulWidget {
  const selected_item({
    super.key,
    this.seller_unique_id,
    this.product_unique_id,
    this.user_unique_id,
    this.product_name,
    this.seller_name,
    this.product_price,
    this.warranty,
    this.product_image,
  });
  final seller_unique_id;
  final product_unique_id;
  final user_unique_id;
  final product_name;
  final seller_name;
  final product_price;
  final warranty;
  final product_image;

  @override
  State<selected_item> createState() => _selected_itemState();
}

class _selected_itemState extends State<selected_item> {
  @override
  @override
  Widget build(BuildContext context) {
    final buyer_ = buyer_provider();

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  (MaterialPageRoute(builder: (ctx) => data(user_unique_id: widget.user_unique_id))),
                  (route) => false,
                );
              },
              icon: const Icon(Icons.arrow_back)),
          backgroundColor: Colors.blueGrey,
          title: const Text('Buyer Selected Item'),
          centerTitle: true,
        ),
        // backgroundColor: Colors.grey,
        body: Card(
          color: Colors.grey,
          child: Stack(
            children: [
              Center(
                child: Container(
                  height: 800,
                  width: 300,
                  color: Colors.blueGrey,
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Container(
                          height: 350,
                          width: 250,
                          child: Image.network(widget.product_image),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Consumer<buyer_provider>(
                                  builder: (context, provider, child) => Row(
                                    children: [
                                      const Icon(FontAwesomeIcons.dollarSign),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        provider.product_price_changed.toString(),
                                        style: const TextStyle(color: Colors.white, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Icon(FontAwesomeIcons.productHunt),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  widget.product_name,
                                  style: const TextStyle(color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Icon(FontAwesomeIcons.shield),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  widget.warranty,
                                  style: const TextStyle(color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Consumer<buyer_provider>(builder: (ctx, provider1, child) {
                              return Text(
                                provider1.count.toString(),
                                style: const TextStyle(color: Colors.white, fontSize: 16),
                              );
                            }),
                            Consumer<buyer_provider>(builder: (ctx, provider1, child) {
                              return IconButton(
                                  onPressed: () {
                                    provider1.increase_count();
                                    provider1.change_like();
                                  },
                                  icon: const Icon(FontAwesomeIcons.plus, color: Colors.white, size: 20));
                            }),
                            Consumer<buyer_provider>(builder: (ctx, provider1, child) {
                              return IconButton(
                                  onPressed: () {
                                    provider1.decrease_count();
                                    provider1.change_like();
                                  },
                                  icon: const Icon(FontAwesomeIcons.minus, color: Colors.red, size: 20));
                            }),
                            Consumer<buyer_provider>(builder: (ctx, provider1, child) {
                              return IconButton(
                                  onPressed: () {
                                    provider1.reset_count();
                                    provider1.change_like();
                                  },
                                  icon: const Icon(Icons.restore, color: Colors.red, size: 20));
                            }),
                            SizedBox(
                              width: 10,
                            ),
                            Consumer<buyer_provider>(
                              builder: (context, provider, child) => IconButton(onPressed: () {
                                provider.change_like();
                              }, icon: Builder(builder: (context) {
                                if (provider.like == true) {
                                  return const Icon(Icons.favorite, color: Colors.red);
                                } else {
                                  return const Icon(Icons.favorite_border_outlined, color: Colors.grey);
                                }
                              })),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [],
                        ),
                        const SizedBox(height: 3),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                                onPressed: () async {
                                  print(widget.user_unique_id);

                                  bool isAdded = await buyer_.add_to_cart_in_buyer(
                                    widget.product_unique_id,
                                    widget.user_unique_id,
                                    widget.product_name,
                                    widget.seller_name,
                                    widget.product_price,
                                    widget.warranty,
                                    widget.product_image,
                                  );
                                  if (isAdded) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Center(child: Text('Item added successfully!\nRemoved from Database')),
                                        duration: Duration(seconds: 2),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                    Navigator.of(context).pop();
                                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => data(user_unique_id: widget.user_unique_id)));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Center(child: Text('Item couldnot be successfully!')),
                                        duration: Duration(seconds: 2),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                },
                                child: const Center(
                                    child: Text(
                                  'Buy',
                                  style: TextStyle(color: Colors.yellow, fontSize: 25),
                                ))),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => data(
                                              user_unique_id: widget.user_unique_id,
                                            )),
                                    (route) => false,
                                  );
                                },
                                child: const Center(
                                    child: Text(
                                  'Cancel',
                                  style: TextStyle(color: Colors.red, fontSize: 25),
                                ))),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
