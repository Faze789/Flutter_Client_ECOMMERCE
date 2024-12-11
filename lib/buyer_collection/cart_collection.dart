import 'package:flutter/material.dart';
import 'package:pak_wheels_application/buyer_collection/data.dart';
import 'package:pak_wheels_application/providers/buyer_provider.dart';
import 'package:provider/provider.dart';

class cart_collection extends StatefulWidget {
  cart_collection({super.key, required this.buyer_unique_id, required this.cart_has_data_or_not});
  String buyer_unique_id;
  bool cart_has_data_or_not;

  @override
  State<cart_collection> createState() => _cart_collectionState();
}

class _cart_collectionState extends State<cart_collection> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<buyer_provider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Cart Collection',
          style: TextStyle(color: Colors.yellow.shade400),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) => data(user_unique_id: widget.buyer_unique_id)), (route) => false);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.yellow,
            )),
      ),
      body: FutureBuilder(
        future: provider.find_data_in_add_to_cart_collection(widget.buyer_unique_id),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData && widget.cart_has_data_or_not == true) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.grey.shade800],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: ListView.builder(
                itemCount: provider.productNames.length,
                itemBuilder: (ctx, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Image
                        Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: NetworkImage(provider.productImages[index] ?? 'https://via.placeholder.com/150'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Product Name
                        Text(
                          provider.productNames[index] ?? 'No Product Name',
                          style: TextStyle(
                            color: Colors.yellow.shade400,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Seller Name
                        Row(
                          children: [
                            const Icon(Icons.person, color: Colors.white),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Seller: ${provider.sellerNames[index] ?? 'Unknown'}',
                                style: const TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Product Price
                        Row(
                          children: [
                            const Icon(Icons.monetization_on, color: Colors.green),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Price: ${provider.productPrices[index] ?? 'Not Available'}',
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Warranty
                        Row(
                          children: [
                            const Icon(Icons.shield, color: Colors.white),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Warranty: ${provider.warranties[index] ?? 'No Warranty'}',
                                style: const TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(
              child: Stack(children: [
                Text('No DATA'),
              ]),
            );
          }
        },
      ),
    );
  }
}
