import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pak_wheels_application/appcolors.dart';
import 'package:pak_wheels_application/providers/seller_provider.dart';
import 'package:pak_wheels_application/screens/screen1.dart';
import 'package:pak_wheels_application/seller_screens/specific_user.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _screen2State();
}

class _screen2State extends State<login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var email_save;
  var password_save;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void check_if_exists() async {
      email_save = emailController.text.trim();
      password_save = passwordController.text.trim();

      seller_provider seller = seller_provider();

      bool user_exists_or_not = await seller.specific_user(email_save, password_save);
      if (user_exists_or_not == true) {
        final seller_id123 = await seller.getPostsByUniqueId(email_save, password_save);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Center(child: Text('Person exists')),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (ctx) => specific_seller_ads(
                    email: email_save,
                    password: password_save,
                    seller_id: seller_id123,
                  )),
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Center(child: Text('Person does not exist\nTry Again!')),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Seller Panel Sign IN',
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
      backgroundColor: AppColors.myCustomColor7,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
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
                  obscureText: true,
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      check_if_exists();
                    },
                    child: const Center(child: Text('Login IN')),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
