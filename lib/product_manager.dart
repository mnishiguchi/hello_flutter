import 'package:flutter/material.dart';

import "./product_list.dart";
import "./product_control.dart";

// A CRUD list of products.
class ProductManager extends StatefulWidget {
  ProductManager() {
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
  List<Map<String, dynamic>> _products = [];

  @override
  void initState() {
    super.initState();

    print('[ProductManagerState] initState');
  }

  // Called when external props trigger the re-rendering.
  @override
  void didUpdateWidget(ProductManager oldWidget) {
    super.didUpdateWidget(oldWidget);

    print('[ProductManagerState] didUpdateWidget');
  }

  void _addProduct(Map<String, dynamic> product) {
    setState(() {
      _products.add(product);
    });
  }

  void _removeProductByIndex(int index) {
    setState(() {
      _products.removeAt(index);
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
          child: ProductList(
            products: _products,
            removeProductByIndex: _removeProductByIndex,
          ),
        )
      ],
    );
  }
}
