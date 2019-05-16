import 'dart:convert';

import 'package:flutter_web/material.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';

enum PageTitle { Top, New, Best, Ask, Show, Job }

class Screen extends StatefulWidget {
  // Screen widget is a StatefulWidget which is responsible for creating and disposing the bloc
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  String _appTitle;
  int _selectedIndex;
  List _stories;

  @override
  void initState() {
    // init blocs
    super.initState();
    _appTitle = "Hacker News";
    _selectedIndex = 0;
    _stories = [];

    _fetchPage("Top");
  }

  void _onItemTapped(int index) {
    String _pageName = PageTitle.values[index].toString().split(".").last;

    // fetch page
    _fetchPage(_pageName);

    setState(() {
      _appTitle = _pageName;
      _selectedIndex = index;
    });
  }

  void _getStories(String url) async {
    List _s = [];

    var _res = await http.get(url);
    final jsonResponse = json.decode(_res.body);

    if (jsonResponse is List) {
      if (jsonResponse.length < 10) {
        for (var storyId in jsonResponse) {
          var item = await _getStoryItem(storyId);
          _s.add(item);
        }
      } else {
        for (var i = 0; i < 10; i++) {
          var item = await _getStoryItem(jsonResponse[i]);
          _s.add(item);
        }
      }

      setState(() {
        _stories = _s;
      });
    }
  }

  Future<dynamic> _getStoryItem(story) async {
    var _storyItem = await http.get("$Item_URL$story.json");
    return json.decode(_storyItem.body);
  }

  void _fetchPage(String page) async {
    switch (page) {
      case "Top":
        _getStories(Top_URL);
        break;
      case "New":
        _getStories(New_URL);
        break;
      case "Best":
        _getStories(Best_URL);
        break;
      case "Ask":
        _getStories(Ask_URL);
        break;
      case "Show":
        _getStories(Show_URL);
        break;
      case "Job":
        _getStories(Job_URL);
        break;
    }
  }

  List<Widget> _storyCells(List stories, BuildContext context) {
    List<Widget> s = [];

    if (stories.isNotEmpty) {
      for (var i = 0; i < stories.length; i++) {
        var story = stories[i];

        s.add(Center(
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Text(
                    (i + 1).toString(),
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                  ),
                  title: Text("${story['title']}"),
                  subtitle: Text("${story['type']} by ${story['by']}."),
                ),
                ButtonTheme.bar(
                  // make buttons use the appropriate styles for cards
                  child: ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: Text('Read'),
                        onPressed: () {
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text("URL: ${story['url']}")));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
      }
    }

    return s;
  }

  @override
  Widget build(BuildContext context) {
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _appTitle,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Builder(
        builder: (bodyContext) => ListView(
              padding: const EdgeInsets.all(10.0),
              children: _storyCells(_stories, bodyContext),
            ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.orange,
          primaryColor: Colors.white,
          textTheme: Theme.of(context).textTheme.copyWith(
                caption: TextStyle(color: Colors.orange[100]),
              ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Top'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.fast_rewind),
              title: Text('New'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              title: Text('Best'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.reply),
              title: Text('Ask'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.remove_red_eye),
              title: Text('Show'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.card_travel),
              title: Text('Job'),
            ),
          ],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
