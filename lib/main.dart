import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';

import "./pages/home_page.dart";

void main() {
  // debugPaintSizeEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowMaterialGrid: true,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        accentColor: Colors.green,
        brightness: Brightness.light,
      ),
      home: HomePage(),
    );
  }
}
