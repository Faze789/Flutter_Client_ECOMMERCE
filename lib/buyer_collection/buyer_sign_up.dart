import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pak_wheels_application/appcolors.dart';
import 'package:pak_wheels_application/buyer_collection/buyer_sign_in.dart';
import 'package:pak_wheels_application/screens/home.dart';

import '../providers/buyer_provider.dart';

class buyer_sign_up extends StatefulWidget {
  const buyer_sign_up({super.key});

  @override
  State<buyer_sign_up> createState() => _screen2State();
}

class _screen2State extends State<buyer_sign_up> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var email_save;
  var password_save;

  Future<void> check_if_exists_buyer() async {
    email_save = emailController.text.trim();
    password_save = passwordController.text.trim();

    buyer_provider buyer = buyer_provider();

    try {
      bool login_exists = await buyer.sign_up(email_save, password_save);

      if (login_exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Center(child: Text('Person just added')),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) => buyer_sign_in(),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('This person already exists'),
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
          'Buyer Panel Sign Up',
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
            icon: Icon(Icons.home)),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      backgroundColor: AppColors.myCustomColor2,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                child: TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    hintText: 'password should be 6 characters long',
                    border: OutlineInputBorder(),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                onPressed: () {
                  check_if_exists_buyer();
                },
                child: const Center(child: Text('SiGn uP')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
