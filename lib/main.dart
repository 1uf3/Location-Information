import 'package:flutter/material.dart';

import 'api/location.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Circle App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LocationSample(),
    );
  }
}
