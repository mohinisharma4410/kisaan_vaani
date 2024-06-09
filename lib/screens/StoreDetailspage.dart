import 'package:flutter/material.dart';

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
        title: Text('Store Detail'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () {
              // Define the action when the button is pressed
              print('Location icon pressed');
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
