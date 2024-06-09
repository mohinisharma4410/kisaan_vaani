import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:kisaan_vaani/Prediction_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kisaan_vaani/language_change.dart';
import 'package:provider/provider.dart';

class PredictionNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == '/predictions') {
          return MaterialPageRoute(
            builder: (BuildContext context) => PredictionsScreen(),
          );
        }
        return MaterialPageRoute(
          builder: (BuildContext context) => PredictionPage(),
        );
      },
    );
  }
}

class PredictionPage extends StatefulWidget {
  @override
  _PredictionPageState createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'lVh9GUt69Ms', // Youtube video ID
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.predpage),
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
                  AppLocalizations.of(context)!.instruction,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                Text(AppLocalizations.of(context)!.one,
                    style: TextStyle(fontSize: 16.0)),
                Text(AppLocalizations.of(context)!.two,
                    style: TextStyle(fontSize: 16.0)),
                Text(AppLocalizations.of(context)!.three,
                    style: TextStyle(fontSize: 16.0)),
                Text(AppLocalizations.of(context)!.four,
                    style: TextStyle(fontSize: 16.0)),
                Text(AppLocalizations.of(context)!.five,
                    style: TextStyle(fontSize: 16.0)),
                SizedBox(height: 20.0),
                YoutubePlayer(
                  controller: _controller,
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
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  },
                  child: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/predictions');
                  },
                  child: Text(AppLocalizations.of(context)!.examine),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
