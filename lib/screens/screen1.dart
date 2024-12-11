import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pak_wheels_application/providers/json_tokens_provider.dart';
import 'package:pak_wheels_application/providers/seller_provider.dart';
import 'package:pak_wheels_application/seller_screens/sign_in.dart';
import 'package:pak_wheels_application/seller_screens/sign_up.dart';
import 'package:pak_wheels_application/seller_screens/specific_user.dart';

class screen1 extends StatefulWidget {
  const screen1({super.key});

  @override
  State<screen1> createState() => _screen1State();
}

class _screen1State extends State<screen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text(
          'Seller Panel Home Screen',
          style: GoogleFonts.poppins(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/maseratii.jpg',
              fit: BoxFit.cover,
            ),
          ),

          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20), // Add some padding
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      MaterialPageRoute(builder: (ctx) => login());

                      JsonTokensProvider jsonTokenProvider = JsonTokensProvider();

                      seller_provider seller = seller_provider();

                      bool isLoggedIn = await jsonTokenProvider.checkUserLoggedIn();

                      if (isLoggedIn) {
                        Map<String, dynamic> userDetails = await jsonTokenProvider.getEmailAndPasswordFromJWT();

                        String email123 = userDetails['email'];
                        String password123 = userDetails['password'];

                        final seller_id123 = await seller.getPostsByUniqueId(email123, password123);

                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (ctx) => specific_seller_ads(
                              email: email123,
                              password: password123,
                              seller_id: seller_id123,
                            ),
                          ),
                          (route) => false,
                        );
                      } else {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => login()),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.yellow),
                    ),
                  ),
                  SizedBox(width: 40),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => sign_up()),
                      );
                    },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(color: Colors.yellow),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
