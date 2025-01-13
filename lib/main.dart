import 'package:flutter/material.dart';
import 'package:pak_wheels_application/providers/buyer_provider.dart';
import 'package:pak_wheels_application/providers/seller_provider.dart';
import 'package:pak_wheels_application/screens/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => seller_provider()),
        ChangeNotifierProvider(
          create: (_) => buyer_provider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const home(),
        //  home: const HOME(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
