import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kisaan_vaani/SplashScreen_DiseasePart.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' show join;

class CameraPage extends StatefulWidget {
  final CameraDescription camera;

  const CameraPage({Key? key, required this.camera}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}


class _CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  final ImagePicker _picker = ImagePicker();
  late XFile? _imageFile;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture;

      final Directory appDirectory = await getApplicationDocumentsDirectory();
      final String picturePath = join(
        appDirectory.path,
        '${DateTime.now()}.png',
      );

      final XFile picture = await _controller.takePicture();

      final File imageFile = File(picture.path);

      // Commenting the part where the image is sent to the API
      /*
      final url = Uri.parse('https://your-api-url.com/XIX');
      final request = http.MultipartRequest('POST', url)
        ..files.add(await http.MultipartFile.fromPath('image', imageFile.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        print('Image uploaded successfully.');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DiseaseReportPage()),
        );
      } else {
        print('Image upload failed with status code: ${response.statusCode}');
      }
      */
      // For now, navigate to DiseaseReportPage directly
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FirstScreen()),
      );

    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  Future<void> _getImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera'),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                _imageFile != null
                    ? Image.file(File(_imageFile!.path))
                    : CameraPreview(_controller),
                Positioned(
                  bottom: 30.0,
                  left: 30.0,
                  child: Row(
                    children: [
                      FloatingActionButton(
                        onPressed: _getImageFromGallery,
                        child: Icon(Icons.photo_library),
                      ),
                      SizedBox(width: 20.0),
                      FloatingActionButton(
                        onPressed: _takePicture,
                        child: Icon(Icons.camera_alt),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
