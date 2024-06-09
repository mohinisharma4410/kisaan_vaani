import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:kisaan_vaani/screens/SplashScreen_DiseasePart.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' show join;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DiseaseDetectionNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (BuildContext context) => DiseaseDetectionPage(),
        );
      },
    );
  }
}

class DiseaseDetectionPage extends StatefulWidget {
  @override
  _DiseaseDetectionPageState createState() => _DiseaseDetectionPageState();
}

class _DiseaseDetectionPageState extends State<DiseaseDetectionPage> {
  late YoutubePlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = YoutubePlayerController(
      initialVideoId: 'lVh9GUt69Ms', // YouTube video ID
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Disease Detection'),
      ),
      body: Center(
        child: Card(
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'How to Use Disease Detection Feature',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text('1. Ensure good lighting.'),
                Text('2. Hold the camera steady.'),
                Text('3. Focus on the affected area.'),
                Text('4. Capture a clear image.'),
                Text('5. Wait for the analysis to complete.'),
                SizedBox(height: 20.0),
                YoutubePlayer(
                  controller: _videoController,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.amber,
                  progressColors: ProgressBarColors(
                    playedColor: Colors.amber,
                    handleColor: Colors.amberAccent,
                  ),
                ),
                SizedBox(height: 10.0),
                FloatingActionButton(
                  onPressed: () {
                    _videoController.value.isPlaying
                        ? _videoController.pause()
                        : _videoController.play();
                  },
                  child: Icon(
                    _videoController.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      final cameras = await availableCameras();
                      final firstCamera = cameras.first;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CameraPage(camera: firstCamera),
                        ),
                      );
                    } catch (e) {
                      print('Error: $e');
                    }
                  },
                  child: Text('Open Camera'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class CameraPage extends StatefulWidget {
  final CameraDescription camera;

  const CameraPage({Key? key, required this.camera}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}


class _CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

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
                CameraPreview(_controller),
                Positioned(
                  bottom: 30.0,
                  left: MediaQuery.of(context).size.width / 2 - 30.0,
                  child: FloatingActionButton(
                    onPressed: _takePicture,
                    child: Icon(Icons.camera_alt),
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

