import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:kisaan_vaani/SplashScreen_DiseasePart.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' show join;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kisaan_vaani/Camerapage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kisaan_vaani/language_change.dart';
import 'package:provider/provider.dart';

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

enum Language { english, hindi }

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
        title: Text(AppLocalizations.of(context)!.disease),
        actions: [
          Consumer<LanguageChange>(builder: (context, provider, child) {
            return PopupMenuButton(
                onSelected: (Language item) {
                  if (Language.english.name == item) {
                    provider.changeLang(Locale('en'));
                  } else {
                    provider.changeLang(Locale('hi'));
                  }
                },
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<Language>>[
                      PopupMenuItem(
                          value: Language.english, child: Text('english')),
                      PopupMenuItem(value: Language.hindi, child: Text('hindi'))
                    ]);
          })
        ],
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
                  AppLocalizations.of(context)!.first,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(AppLocalizations.of(context)!.first,
                    style: TextStyle(fontSize: 16.0)),
                Text(AppLocalizations.of(context)!.second,
                    style: TextStyle(fontSize: 16.0)),
                Text(AppLocalizations.of(context)!.third,
                    style: TextStyle(fontSize: 16.0)),
                Text(AppLocalizations.of(context)!.fourth,
                    style: TextStyle(fontSize: 16.0)),
                Text(AppLocalizations.of(context)!.fifth,
                    style: TextStyle(fontSize: 16.0)),
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
                    _videoController.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
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
                          builder: (context) => CameraPage(camera: firstCamera),
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
