// TODO: return list widget on response
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
    _stories = [1];
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

  void getStories(String url) async {
    var _res = await http.get(url);
    final jsonResponse = json.decode(_res.body);
    setState(() {
      _stories = jsonResponse;
    });
  }

  void _fetchPage(String page) async {
    switch (page) {
      case "Top":
        getStories(Top_URL);
        break;
      case "New":
        getStories(New_URL);
        break;
      case "Best":
        getStories(Best_URL);
        break;
      case "Ask":
        getStories(Ask_URL);
        break;
      case "Show":
        getStories(Show_URL);
        break;
      case "Job":
        getStories(Job_URL);
        break;
    }
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
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (choose the "Toggle Debug Paint" action
          // from the Flutter Inspector in Android Studio, or the "Toggle Debug
          // Paint" command in Visual Studio Code) to see the wireframe for each
          // widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _stories.first.toString(),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.orange,
          primaryColor: Colors.white,
          textTheme: Theme.of(context).textTheme.copyWith(
                caption: TextStyle(color: Colors.orangeAccent),
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
