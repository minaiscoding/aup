import 'dart:io';
import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  final String imagePath;
  final Map<String, dynamic> results;

  const ResultsScreen({super.key, required this.imagePath, required this.results});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 40), // Padding from top
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: 250, // Image preview height
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8)],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.file(File(imagePath), fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "📊 Résultats de l'analyse",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.orange),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: results.isEmpty
                ? const Center(child: Text("Aucun produit détecté", style: TextStyle(fontSize: 18, color: Colors.black54)))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      String product = results.keys.elementAt(index);
                      String quantity = results[product].toString();
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.shopping_cart, color: Colors.orange, size: 28),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(product, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                            ),
                            Text(
                              "x$quantity",
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8)],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  label: const Text("Retour", style: TextStyle(fontSize: 16, color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
