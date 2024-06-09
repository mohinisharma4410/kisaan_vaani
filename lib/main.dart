import 'package:flutter/material.dart';
import 'package:kisaan_vaani/screens/PredictionPage.dart';
import 'package:kisaan_vaani/screens/DiseaseDetectionpage.dart';
import 'package:kisaan_vaani/screens/NewsPage.dart';
import 'package:kisaan_vaani/screens/StoreDetailspage.dart';
import 'package:kisaan_vaani/screens/Homepage.dart';
import 'package:kisaan_vaani/provider/theme_provider.dart';
import 'package:provider/provider.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Bottom Navigation Bar Example',
            theme: themeProvider.themeData,
            home: MyHomePage(),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 2;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  final List<Widget> _pages = [
    PredictionNavigator(),
    DiseaseDetectionNavigator(),
    HomeNavigator(),
    NewsNavigator(),
    StoreDetailNavigator(),
  ];

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: _pages.asMap().entries.map((entry) {
          int index = entry.key;
          Widget page = entry.value;
          return Offstage(
            offstage: _selectedIndex != index,
            child: Navigator(
              key: _navigatorKeys[index],
              onGenerateRoute: (RouteSettings settings) {
                return MaterialPageRoute(
                  builder: (context) => page,
                );
              },
            ),
          );
        }).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'Prediction',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.healing),
            label: 'Disease Detection',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront),
            label: 'Store Detail',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.blue,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
        },
        child: Icon(Icons.brightness_6),
      ),
    );
  }
}