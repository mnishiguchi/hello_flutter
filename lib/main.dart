import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

// A state that belongs to MyApp Widget.
class _MyAppState extends State<MyApp> {
  // properties
  List<String> _products = ['Software Engineer'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Hello Flutter"),
          ),
          body: Center(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: RaisedButton(
                    onPressed: () {
                      setState(() {
                        _products.add('Guitarist');
                        });
                    },
                    child: Text("Add Product"),
                  ),
                ),
                Column(
                  children: _products
                      .map(
                        (text) => Card(
                              child: Column(
                                children: <Widget>[
                                  Image.asset('assets/masa_chinatown.png'),
                                  Text(text),
                                ],
                              ),
                            ),
                      )
                      .toList(),
                )
              ],
            ),
          )),
    );
  }
}
