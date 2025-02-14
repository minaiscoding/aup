import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  CameraScreenState createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  void _initializeCamera() async {
    final cameras = await availableCameras();
    _controller = CameraController(cameras[0], ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 60), // Padding from top
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 500, // Adjusted height for the camera preview
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: Colors.black26, blurRadius: 8),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Transform.scale(
                      scale: 1.1, // Fix aspect ratio issue
                      child: CameraPreview(_controller),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(color: Colors.orange),
                    );
                  }
                },
              ),
            ),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.photo_library, size: 32, color: Colors.orange),
                  onPressed: () {
                    // Handle gallery upload
                  },
                ),
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.orange, width: 4),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.camera_alt, size: 40, color: Colors.orange),
                    onPressed: () async {
                      final image = await _controller.takePicture();
                      Navigator.pushNamed(context, '/checker', arguments: image.path);
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.check_circle, size: 32, color: Colors.green),
                  onPressed: () {
                    // Handle validation
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
