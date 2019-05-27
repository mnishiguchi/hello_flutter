import 'package:flutter/material.dart';

import '../../models/product.dart';

// Map
class ProductList extends StatelessWidget {
  // immutable properties
  final List<Product> products;

  // constructor that accepts params that are bound to properties
  ProductList({this.products = const []}) {
    print('[ProductList] constructor');
  }

  Widget _buildProductItem(BuildContext context, int index) {
    print('[ProductList] _buildProductItem');

    Product product = products[index];
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(product.image),
          Text(product.title),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text('Details'),
                onPressed: () {
                  Navigator.pushNamed(context, '/product/$index');
                },
              )
            ],
          )
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    print('[ProductList] build');

    if (products.length > 0) {
      return ListView.builder(
        itemBuilder: _buildProductItem,
        itemCount: products.length,
      );
    } else {
      // The build method must return a widget even it if nothing is displayed.
      return Center(child: Text("No product found"));
    }
  }
}
