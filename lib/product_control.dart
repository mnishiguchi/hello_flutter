import 'package:flutter/material.dart';

class ProductControl extends StatelessWidget {
  // immutable properties
  final Function addProduct;

  // constructor that accepts params that are bound to properties
  ProductControl({this.addProduct});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      onPressed: () {
        addProduct("new product");
      },
      child: Text("Add Product"),
    );
  }
}
