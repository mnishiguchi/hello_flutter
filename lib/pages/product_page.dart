import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  final Map<String, dynamic> product;

  ProductPage({this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['title']),
      ),
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(product['image']),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text(product['title']),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: RaisedButton(
              color: Theme.of(context).accentColor,
              child: Text('Back'),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      )),
    );
  }
}
