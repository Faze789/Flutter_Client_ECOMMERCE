import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pak_wheels_application/buyer_collection/buyer_sign_in.dart';
import 'package:pak_wheels_application/buyer_collection/buyer_sign_up.dart';
import 'package:pak_wheels_application/buyer_collection/data.dart';
import 'package:pak_wheels_application/providers/buyer_provider.dart';
import 'package:pak_wheels_application/providers/json_tokens_provider.dart';

class main_buyer extends StatelessWidget {
  const main_buyer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Buyer Panel Home Screen',
          style: GoogleFonts.poppins(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/aston.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            right: 50,
            top: MediaQuery.of(context).size.height * 0.1,
            child: Row(
              children: [
                Container(
                  width: 120,
                  height: 65,
                  child: ElevatedButton(
                    onPressed: () async {
                      buyer_provider buyer = buyer_provider();

                      JsonTokensProvider jsonTokenProvider = JsonTokensProvider();

                      bool isLoggedIn = await jsonTokenProvider.checkUserLoggedIn();

                      if (isLoggedIn) {
                        Map<String, dynamic> userDetails = await jsonTokenProvider.getEmailAndPasswordFromJWT();

                        String email123 = userDetails['email'];
                        String password123 = userDetails['password'];

                        print('--------------------');
                        print(email123);
                        print(password123);
                        print('--------------------');

                        final get_unique_id = await buyer.getPostsByUniqueId(email123, password123);

                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => data(user_unique_id: get_unique_id)),
                          (route) => false, // This ensures all previus routes are removed
                        );
                      } else {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => buyer_sign_in()),
                          (route) => false, // This ensures all previous routes are removed
                        );
                      }
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.yellow),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey, // Button background color
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  width: 120,
                  height: 65,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => buyer_sign_up()));
                    },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(color: Colors.yellow),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey, // Button background color
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
