import 'package:flutter/material.dart';
import 'camera_screen.dart';
import 'checker_screen.dart';
import 'results_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => CameraScreen(),
        '/checker': (context) {
          final imagePath =
              ModalRoute.of(context)!.settings.arguments as String;
          return CheckerScreen(imagePath: imagePath);
        },
        '/results': (context) {
          final imagePath =
              ModalRoute.of(context)!.settings.arguments as String;
          return ResultsScreen(imagePath: imagePath, results: {});
        },
      },
    );
  }
}
