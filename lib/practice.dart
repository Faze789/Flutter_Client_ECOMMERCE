// import 'package:flutter/material.dart';
// import 'package:pak_wheels_application/providers/buyer_provider.dart';
// import 'package:provider/provider.dart';

// class Practice extends StatefulWidget {
//   const Practice({super.key});

//   @override
//   State<Practice> createState() => _PracticeState();
// }

// class _PracticeState extends State<Practice> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Consumer<buyer_provider>(
//           builder: (context, provider1, child) {
//             return Text('${provider1.c}');
//           },
//         ),
//         Consumer<buyer_provider>(
//           builder: (context, provider, child) {
//             return IconButton(
//               onPressed: () {
//                 provider.add_data();
//               },
//               icon: Icon(Icons.add),
//             );
//           },
//         ),
//       ],
//     );
//   }
// }
