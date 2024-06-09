import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kisaan_vaani/language_change.dart';
import 'package:provider/provider.dart';

class StoreDetailNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (BuildContext context) => StoreDetailPage(),
        );
      },
    );
  }
}

class StoreDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.storetitle),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () async {
              // Define the action when the button is pressed
              Position position = await Geolocator.getCurrentPosition(
                  desiredAccuracy: LocationAccuracy.high);
              print(
                  'Location icon pressed. Latitude: ${position.latitude}, Longitude: ${position.longitude}');
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Store Detail Page'),
      ),
    );
  }
}
