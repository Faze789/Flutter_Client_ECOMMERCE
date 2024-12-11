import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pak_wheels_application/buyer_collection/data.dart';
import 'package:pak_wheels_application/providers/buyer_provider.dart';

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
                  height: 470,
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
                                const Icon(FontAwesomeIcons.dollarSign),
                                const SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  widget.product_price,
                                  style: const TextStyle(color: Colors.white, fontSize: 16),
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
