import 'dart:io';
import 'package:flutter/material.dart';

class CheckerScreen extends StatelessWidget {
  final String imagePath;

  const CheckerScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Checker")),
      body: Column(
        children: [
          Image.file(File(imagePath)),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Send image for analysis
              Navigator.pushNamed(context, '/results', arguments: imagePath);
            },
            child: Text("Analyze"),
          ),
        ],
      ),
    );
  }
}
