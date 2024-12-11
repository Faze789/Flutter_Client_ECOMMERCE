import 'package:flutter/material.dart';
import 'package:pak_wheels_application/buyer_collection/main_buyer.dart';
import 'package:pak_wheels_application/screens/screen1.dart';
class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  // static final FlutterLocalNotificationsPlugin
  //     _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // @override
  // void initState() {
  //   super.initState();
  //   _requestPermission();
  //   _getToken();
  //   _initializeNotifications();
  //   _configureMessaging();
  // }

  // void _requestPermission() async {
  //   NotificationSettings settings = await _firebaseMessaging.requestPermission(
  //     alert: true,
  //     badge: true,
  //     provisional: false,
  //     sound: true,
  //   );

  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     print('User granted permission');
  //   } else {
  //     print('User denied permission');
  //   }
  // }

  // void _getToken() async {
  //   String? token = await _firebaseMessaging.getToken();
  //   print("FCM Token: $token"); // Store this token for sending notifications
  // }

  // void _initializeNotifications() async {
  //   const AndroidInitializationSettings initializationSettingsAndroid =
  //       AndroidInitializationSettings('@mipmap/ic_launcher');

  //   const InitializationSettings initializationSettings =
  //       InitializationSettings(
  //     android: initializationSettingsAndroid,
  //   );

  //   await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  // }

  // void _configureMessaging() {
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     // Handle foreground message
  //     _showNotification(message);
  //   });

  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //     print('Message opened: ${message.notification?.title}');
  //     // Handle message when app is opened from a notification
  //   });
  // }

  // Future<void> _showNotification(RemoteMessage message) async {
  //   // Define a vibration pattern (optional)
  //   Int64List vibrationPattern = Int64List.fromList(<int>[
  //     0,
  //     1000,
  //     500,
  //     1000
  //   ]); // Vibration for 1 second, pause for 0.5 seconds, then vibrate again

  //   AndroidNotificationDetails androidPlatformChannelSpecifics =
  //       AndroidNotificationDetails(
  //     'default_channel_id',
  //     'Default notifications',
  //     channelDescription: 'This channel is used for default notifications.',
  //     importance: Importance.high,
  //     priority: Priority.high,
  //     showWhen: false,
  //     vibrationPattern: vibrationPattern,
  //     playSound: true, // Ensure sound is played
  //     enableVibration: true, // Enable vibration
  //   );

  //   NotificationDetails platformChannelSpecifics =
  //       NotificationDetails(android: androidPlatformChannelSpecifics);

  //   await _flutterLocalNotificationsPlugin.show(
  //     0,
  //     message.notification?.title,
  //     message.notification?.body,
  //     platformChannelSpecifics,
  //     payload: 'Custom_Sound',
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).dividerColor,
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/buaggati.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    height: 65,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => const screen1()),
                        );
                      },
                      child: const Text(
                        'Seller',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                    ),
                  ),
                ),
                // Expanded(
                //   child: Container(
                //     margin: const EdgeInsets.only(right: 10),
                //     height: 65,
                //     child: ElevatedButton(
                //       onPressed: () async {
                //         final request_to_api = "https://ecommerce123-alpha.vercel.app/damn";
                //         final request_to_server = await http.get(Uri.parse(request_to_api));

                //         if(request_to_server.statusCode == 200)
                //         {
                //           print('------\n');
                //           print(request_to_server.body);
                //         }
                //         else {
                //           print('Faileddd');
                //         }
                //       },
                //       child: const Text(
                //         'Checking internet connection',
                //         style: TextStyle(color: Colors.white),
                //       ),
                //       style: ElevatedButton.styleFrom(
                //         backgroundColor: Colors.grey,
                //       ),
                //     ),
                //   ),
                // ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    height: 65,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (ctx) => const main_buyer()),
                        );
                      },
                      child: const Text(
                        'Buyer',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
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
