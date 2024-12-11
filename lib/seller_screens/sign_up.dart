import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pak_wheels_application/appcolors.dart';
import 'package:pak_wheels_application/providers/seller_provider.dart';
import 'package:pak_wheels_application/screens/screen1.dart';
import 'package:pak_wheels_application/seller_screens/sign_in.dart';

class sign_up extends StatefulWidget {
  const sign_up({super.key});

  @override
  State<sign_up> createState() => _screen2State();
}

class _screen2State extends State<sign_up> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController name_Controller = TextEditingController();

  var email_save;
  var password_save;
  var name_save;

  Future<void> sign_up_check() async {
    email_save = emailController.text.trim();
    password_save = passwordController.text.trim();
    name_save = name_Controller.text.trim();

    final seller = seller_provider();

    try {
      bool signup_check = await seller.sign_up(email_save, password_save, name_save);

      if (signup_check) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Center(child: Text('Person just added')),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => login()),
          (route) => false,
        );
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
          'Seller Panel Sign Up',
          style: GoogleFonts.poppins(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => screen1()));
          },
          icon: Icon(Icons.home),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      backgroundColor: AppColors.myCustomColor2,
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: 300,
                child: TextFormField(
                  controller: name_Controller,
                  decoration: const InputDecoration(
                    labelText: 'Seller Name',
                    border: OutlineInputBorder(),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Container(
                width: 300,
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
            ),
            const SizedBox(height: 16),
            Center(
              child: Container(
                width: 300,
                child: TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    hintText: 'Password should be 6 characters long',
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  obscureText: true,
                  keyboardType: TextInputType.text,
                ),
              ),
            ),
            const SizedBox(height: 25),
            Container(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  sign_up_check();
                },
                child: const Center(child: Text('SiGn uP')),
              ),
            )
          ],
        ),
      ),
    );
  }
}
