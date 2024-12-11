// import 'package:flutter/material.dart';
// import 'package:pak_wheels_application/buyer_collection/filter_result.dart';
// import 'package:pak_wheels_application/providers/seller_provider.dart';
// import 'package:provider/provider.dart';

// import '../providers/buyer_provider.dart';

// class FilterScreen extends StatefulWidget {
//   const FilterScreen({super.key});

//   @override
//   State<FilterScreen> createState() => _FilterScreenState();
// }

// class _FilterScreenState extends State<FilterScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<buyer_provider>(context, listen: false);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Filter Options'),
        
//       ),
//       body: Center(
//         child: Consumer<buyer_provider>(
//           builder: (context, provider, child) {
//             // Check if there are filter options available
//             if (provider.filterOptions.isEmpty) {
//               return const Text(
//                 'No filter options available',
//                 style: TextStyle(fontSize: 18, color: Colors.grey),
//               );
//             }
//             return ListView.builder(
//               itemCount: provider.filterOptions.length,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 8.0),
//                   child: CheckboxListTile(
//                     title: Text(
//                       provider.filterOptions[index],
//                       style: const TextStyle(fontSize: 16), // Customize text size
//                     ),
//                     value: provider.isChecked[index],
//                     onChanged: (value) {
//                       provider.onCheckboxChanged(index, value);
//                     },
//                     controlAffinity: ListTileControlAffinity.leading, // Move checkbox to the leading side
//                     activeColor: Theme.of(context).primaryColor, // Change active color
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//            bool check = await provider.get_filtered_data();
//             if (check == true) {
//               Navigator.of(context).pop();
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (ctx) => filter_result()));
//             } else {
//               print('no');
//             }
//           // Implement apply filters action
//           print('Filters applied'); // Replace with actual functionality
//         },
//         child: const Icon(Icons.check),
//         backgroundColor: Theme.of(context).primaryColor,
//         tooltip: 'Apply Filters',
//       ),
//     );
//   }
// }
