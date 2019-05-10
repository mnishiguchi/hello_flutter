import 'package:flutter/material.dart';

import "./product_list.dart";

// A CRUD list of products.
class ProductManager extends StatefulWidget {
  final String startingProduct;

  ProductManager({this.startingProduct});

  @override
  State<StatefulWidget> createState() {
    return _ProductManagerState();
  }
}

// A state that belongs to ProductManager Widget.
class _ProductManagerState extends State<ProductManager> {
  // properties
  List<String> _products = [];

  @override
  void initState() {
    super.initState();

    // widget is a reference to StatefulWidget.
    _products.add(widget.startingProduct);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
        ProductList(_products),
      ],
    );
  }
}
