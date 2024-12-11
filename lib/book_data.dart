import 'package:flutter/material.dart';

class book_data extends StatelessWidget {
  const book_data({Key? key, this.title, this.author}) : super(key: key); 

  final String? title; 
  final String? author;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Details'), 
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              title ?? 'No Title',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), 
            ),
          ),
          SizedBox(height: 16), 
          Center(
            child: Text(
              author ?? 'No Author',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
