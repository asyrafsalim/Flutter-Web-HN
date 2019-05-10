import 'package:flutter_web/material.dart';

import './screens/home.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
