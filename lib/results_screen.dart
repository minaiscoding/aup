import 'dart:io';
import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  final String imagePath;

  ResultsScreen({super.key, required this.imagePath});

  final List<Map<String, String>> dummyResults = [
    {"Produit": "PET D'ors Pêche 30CL", "Quantité": "5"},
    {"Produit": "PET D'ors Ananas 30CL", "Quantité": "3"},
    {"Produit": "PET D'ors Fraise 30CL", "Quantité": "4"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Results")),
      body: Column(
        children: [
          Image.file(File(imagePath), height: 150),
          Expanded(
            child: ListView.builder(
              itemCount: dummyResults.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(dummyResults[index]["Produit"]!),
                  trailing: Text(dummyResults[index]["Quantité"]!),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
