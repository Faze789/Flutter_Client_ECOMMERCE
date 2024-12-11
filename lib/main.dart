import 'package:flutter/material.dart';
import 'package:pak_wheels_application/providers/buyer_provider.dart';
import 'package:pak_wheels_application/providers/seller_provider.dart';
import 'package:pak_wheels_application/screens/home.dart';
import 'package:provider/provider.dart';

void main() {
  //Remove this method to stop OneSignal Debugging
// OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

// OneSignal.initialize("c24bfe22-a1ab-4a0d-971e-358318fccca2");

// // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
// OneSignal.Notifications.requestPermission(true);

// WidgetsFlutterBinding.ensureInitialized(); // Ensure widget binding is initialized
//   await Firebase.initializeApp(); // Initialize Firebase
  // runApp(MyApp());

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
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
