import 'package:flutter/material.dart';

import "./product_manager.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.orange,
        accentColor: Colors.green,
        brightness: Brightness.light,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Hello Flutter"),
        ),
        body: Center(
          child: ProductManager(
            startingProduct: "Software Engineer",
          ),
        ),
      ),
    );
  }
}
