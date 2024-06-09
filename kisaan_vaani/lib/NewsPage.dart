import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (BuildContext context) => NewsPage(),
        );
      },
    );
  }
}

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<dynamic> news = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  fetchNews() async {
    final response = await http.get(
      Uri.parse('https://newsapi.org/v2/top-headlines?country=us&apiKey=8367a2f2979844718a3179ad15b4a400'),
    );

    if (response.statusCode == 200) {
      setState(() {
        news = json.decode(response.body)['articles'];
      });
    } else {
      throw Exception('Failed to load news');
    }
  }

  void openLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Language'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ListTile(
                  title: Text('English'),
                  onTap: () {
                    // Code to handle English language selection
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Hindi'),
                  onTap: () {
                    // Code to handle Hindi language selection
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Urdu'),
                  onTap: () {
                    // Code to handle Marathi language selection
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Gujrati'),
                  onTap: () {
                    // Code to handle Marathi language selection
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Marathi'),
                  onTap: () {
                    // Code to handle Marathi language selection
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Malayalam'),
                  onTap: () {
                    // Code to handle Marathi language selection
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Tamil'),
                  onTap: () {
                    // Code to handle Marathi language selection
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Telegu'),
                  onTap: () {
                    // Code to handle Marathi language selection
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Kannada'),
                  onTap: () {
                    // Code to handle Marathi language selection
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Bengali'),
                  onTap: () {
                    // Code to handle Marathi language selection
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Assamese'),
                  onTap: () {
                    // Code to handle Marathi language selection
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Oriya'),
                  onTap: () {
                    // Code to handle Marathi language selection
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Bhojpuri'),
                  onTap: () {
                    // Code to handle Marathi language selection
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Punjabi'),
                  onTap: () {
                    // Code to handle Marathi language selection
                    Navigator.pop(context);
                  },
                ),
                // Add more languages as needed
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Page'),
      ),
      body: news.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          children: news.map((article) => NewsCard(article, openLanguageDialog)).toList(),
        ),
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final dynamic article;
  final Function(BuildContext) openLanguageDialog;

  NewsCard(this.article, this.openLanguageDialog);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Stack(
        children: [
          Transform(
            transform: Matrix4.identity()..setEntry(3, 2, 0.001)..rotateX(0.1),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article['title'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(article['description'] ?? 'No description available'),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: 10,
            child: IconButton(
              icon: Icon(Icons.volume_up),
              onPressed: () {
                openLanguageDialog(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
