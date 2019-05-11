import 'package:flutter/material.dart';

import "./product_list.dart";
import "./product_control.dart";

// A CRUD list of products.
class ProductManager extends StatefulWidget {
  final String startingProduct;

  ProductManager({this.startingProduct = 'Some Product'}) {
    print('[ProductManager] constructor');
  }

  @override
  State<StatefulWidget> createState() {
    print('[ProductManager] createState');
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

    print('[ProductManagerState] initState');

    // widget is a reference to StatefulWidget.
    _products.add(widget.startingProduct);
  }

  // Called when external props trigger the re-rendering.
  @override
  void didUpdateWidget(ProductManager oldWidget) {
    super.didUpdateWidget(oldWidget);

    print('[ProductManagerState] didUpdateWidget');
  }

  void _addProduct(String product) {
    setState(() {
      _products.add(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    print('[ProductManagerState] build');

    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(10.0),
          child: ProductControl(addProduct: _addProduct),
        ),
        Expanded(
          child: ProductList(_products),
        )
      ],
    );
  }
}
