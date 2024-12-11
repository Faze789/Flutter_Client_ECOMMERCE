import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pak_wheels_application/appcolors.dart';
import 'package:pak_wheels_application/buyer_collection/data.dart';
import 'package:pak_wheels_application/providers/buyer_provider.dart';
import 'package:pak_wheels_application/screens/home.dart';

class buyer_sign_in extends StatefulWidget {
  const buyer_sign_in({super.key});

  @override
  State<buyer_sign_in> createState() => _screen2State();
}

class _screen2State extends State<buyer_sign_in> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var email_save;
  var password_save;

  Future<void> check_if_exists_buyer() async {
    email_save = emailController.text.trim();
    password_save = passwordController.text.trim();

    buyer_provider buyer = buyer_provider();

    try {
      bool login_exists = await buyer.buyer_sign_in(email_save, password_save);

      if (login_exists) {
        final get_unique_id = await buyer.getPostsByUniqueId(email_save, password_save);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Person is present'),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (ctx) => data(
              user_unique_id: get_unique_id,
            ),
          ),
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('This person is not present'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Buyer Panel Sign IN',
          style: GoogleFonts.poppins(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => home()));
          },
          icon: const Icon(Icons.home),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      backgroundColor: AppColors.myCustomColor7,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Write your Email',
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                ),
                obscureText: true, //
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: check_if_exists_buyer,
                child: const Center(child: Text('Sign IN')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
