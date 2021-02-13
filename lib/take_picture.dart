import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

// untuk membuat koneksi dengan kamera perangkat memerlukan CameraController dan seperti
// pengontrol lainnya, ia harus di inisiasi dan di dispose. maka diperlukan statefull widget
class TakePicture extends StatefulWidget {
  final CameraDescription camera;

  TakePicture({required this.camera});

  @override
  _TakePictureState createState() => _TakePictureState();
}

// untuk membuat koneksi dengan kamera perangkat memerlukan CameraController dan seperti
// pengontrol lainnya, ia harus di inisiasi dan di dispose. maka diperlukan statefull widget
class _TakePictureState extends State<TakePicture> {
  late final CameraController _controller;

  // _initController memakai FutureBuilder untuk menunggu loading camera preview
  late final Future<void> _initController;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.camera, ResolutionPreset.high);

    _initController = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        FutureBuilder<void>(
          future: _initController,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // Expanded or Container or SizedBox
              return Expanded(
                  child: Center(
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: CameraPreview(_controller),
                ),
              ));
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.photo_camera),
          onPressed: () => _takePhoto(context),
        )
      ],
    );
  }

  void _takePhoto(BuildContext context) async {
    // memastikan controller ready
    await _initController;

    // nama file dan path
    final dir = await getTemporaryDirectory();
    final name = "mypic_${DateTime.now()}.png";

    // masukkan gambar ke lokasi yang disiapkan
    final fullPath = p.join(dir.path, name);
    // await _controller.takePicture(fullPath);
    await _controller.takePicture();

    Scaffold.of(context).showSnackBar(SnackBar(
      content: const Text("Picature Taken"),
      duration: const Duration(milliseconds: 600),
    ));
  }
}
