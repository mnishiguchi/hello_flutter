import 'package:flutter/material.dart';

// Map
class ProductList extends StatelessWidget {
  // immutable properties
  final List<String> products;

  // constructor that accepts params that are bound to properties
  ProductList(this.products);

  Widget build(BuildContext context) {
    return Column(
      children: products
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
    );
  }
}
