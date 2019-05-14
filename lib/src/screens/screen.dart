import 'package:flutter_web/material.dart';

enum PageTitle { News, Past, Comments, Ask, Show, Jobs }

class Screen extends StatefulWidget {
  // Screen widget is a StatefulWidget which is responsible for creating and disposing the bloc
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  String _appTitle;
  int _selectedIndex;

  @override
  void initState() {
    // init blocs
    super.initState();
    _appTitle = "Hacker News";
    _selectedIndex = 0;
  }

  void _onItemTapped(int index) {
    String _pageName = PageTitle.values[index].toString().split(".").last;
    setState(() {
      _appTitle = _pageName;
      _selectedIndex = index;
    });
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
              'Hacker News App!!',
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
              title: Text('News'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.fast_rewind),
              title: Text('Past'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              title: Text('Comments'),
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
              title: Text('Jobs'),
            ),
          ],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
