import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Hello Flutter"),
        ),
        body: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10.0),
              child: RaisedButton(
                onPressed: () {},
                child: Text("Add Product"),
              ),
            ),
            Card(
              child: Column(
                children: <Widget>[
                  Image.asset('assets/masa_chinatown.png'),
                  Text("Food Paradise"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
