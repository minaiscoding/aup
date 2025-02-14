import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final VoidCallback onRetake;
  final VoidCallback onCancel;

  ErrorScreen({required this.onRetake, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Carrefour Bab Ezzouar",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Icon(Icons.warning, color: Colors.orange, size: 80),
          SizedBox(height: 10),
          Text(
            "L’image capturée n’est pas exploitable.",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Text("Veuillez prendre une nouvelle photo", textAlign: TextAlign.center),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: onRetake,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: Text("Reprendre la photo"),
          ),
          TextButton(
            onPressed: onCancel,
            child: Text("Annuler", style: TextStyle(color: Colors.orange)),
          ),
        ],
      ),
    );
  }
}
