import 'package:flutter_web/material.dart';

import './screens/screen.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter HN',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Screen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
