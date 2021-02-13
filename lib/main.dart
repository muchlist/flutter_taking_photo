import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_taking_photo/take_picture.dart';

void main() async {
  // pemanggilan ini untuk meyakinkan plugin kamera sudah di inisiasi dan siap untuk dipakai
  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(DemoApp(firstCamera));
}

class DemoApp extends StatelessWidget {
  final CameraDescription camera;
  const DemoApp(this.camera);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Using camera"),
        ),
        body: TakePicture(
          camera: camera,
        ),
      ),
    );
  }
}
