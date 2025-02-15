import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'results_screen.dart';

class CheckerScreen extends StatefulWidget {
  final String imagePath;

  const CheckerScreen({super.key, required this.imagePath});

  @override
  _CheckerScreenState createState() => _CheckerScreenState();
}

class _CheckerScreenState extends State<CheckerScreen> {
  bool _isLoading = false;

  Future<void> _analyzeImage() async {
    setState(() => _isLoading = true);

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://59vl04wl-5000.uks1.devtunnels.ms/count_products'),
    );
    request.files.add(
      await http.MultipartFile.fromPath('image', widget.imagePath),
    );

    try {
      var response = await request.send();
      var responseData = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        Map<String, dynamic> results = json.decode(responseData);
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder:
                  (context) => ResultsScreen(
                    imagePath: widget.imagePath,
                    results: results,
                  ),
            ),
          );
        }
      } else {
        _showErrorDialog("L'analyse a échoué. Veuillez réessayer.");
      }
    } catch (e) {
      _showErrorDialog("Une erreur s'est produite : $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Erreur"),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK", style: TextStyle(color: Colors.orange)),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 40),
          Expanded(
            flex: 8,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(color: Colors.black26, blurRadius: 8),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.file(File(widget.imagePath), fit: BoxFit.cover),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                _isLoading
                    ? const CircularProgressIndicator(color: Colors.orange)
                    : ElevatedButton.icon(
                      onPressed: _analyzeImage,
                      icon: const Icon(Icons.search, color: Colors.white),
                      label: const Text(
                        "Analyser",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 24,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "Annuler",
                    style: TextStyle(fontSize: 16, color: Colors.red),
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
