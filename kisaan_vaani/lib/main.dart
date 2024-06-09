import 'package:flutter/material.dart';
import 'package:kisaan_vaani/Homepage.dart';
import 'package:kisaan_vaani/theme_provider.dart';
import 'package:kisaan_vaani/language_change.dart';
import 'package:provider/provider.dart';
import 'package:kisaan_vaani/OnboardingScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kisaan_vaani/PredictionPage.dart';
import 'package:kisaan_vaani/DiseaseDetectionpage.dart';
import 'package:kisaan_vaani/NewsPage.dart';
import 'package:kisaan_vaani/StoreDetailspage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kisaan_vaani/language_change.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sp = await SharedPreferences.getInstance();
  final String languageCode = sp.getString('language_code') ?? 'en';
  runApp(MyApp(initialLocale: Locale(languageCode)));
}

class MyApp extends StatelessWidget {
  final Locale initialLocale;
  const MyApp({super.key, required this.initialLocale});
  Future<bool> _checkIfOnboardingSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onboardingSeen') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => LanguageChange())
        ],
        child: MyChild(
          initialLocale: initialLocale,
        )
        // [
        //   Consumer<ThemeProvider>(
        //     builder: (context, themeProvider, child) {
        //       return FutureBuilder<bool>(
        //         future: _checkIfOnboardingSeen(),
        //         builder: (context, snapshot) {
        //           if (snapshot.connectionState == ConnectionState.waiting) {
        //             return MaterialApp(
        //               home: Scaffold(
        //                 body: Center(
        //                   child: CircularProgressIndicator(),
        //                 ),
        //               ),
        //             );
        //           } else {
        //             bool onboardingSeen = snapshot.data ?? false;
        //             return MaterialApp(
        //               debugShowCheckedModeBanner: false,
        //               title: 'Bottom Navigation Bar Example',
        //               theme: themeProvider.themeData,
        //               home: onboardingSeen ? MyHomePage() : OnboardingScreen(),
        //             );
        //           }
        //         },
        //       );
        //     },
        //   )
        // ]
        );
  }
}

class MyChild extends StatefulWidget {
  final Locale initialLocale;
  const MyChild({super.key, required this.initialLocale});

  @override
  State<MyChild> createState() => _MyChildState();
}

class _MyChildState extends State<MyChild> {
  @override
  Future<bool> _checkIfOnboardingSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onboardingSeen') ?? false;
  }

  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageChange>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
        title: "flutter_multilingual",
        locale: languageProvider.appLocale ?? widget.initialLocale,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        theme: themeProvider.themeData,
        supportedLocales: const [
          Locale('en'),
          Locale('hi'),
        ],
        home: FutureBuilder<bool>(
          future: _checkIfOnboardingSeen(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              bool onboardingSeen = snapshot.data ?? false;
              return onboardingSeen ? MyHomePage() : OnboardingScreen();
            }
          },
        ) // Set HomeScreen as the initial screen
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
