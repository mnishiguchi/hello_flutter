import 'package:flutter/material.dart';

// Map
class ProductList extends StatelessWidget {
  // immutable properties
  final List<String> products;

  // constructor that accepts params that are bound to properties
  ProductList([this.products = const []]) {
    print('[ProductList] constructor');
  }

  Widget _buildProductItem(BuildContext context, int index) {
    print('[ProductList] _buildProductItem');

    String text = products[index];
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset('assets/masa_chinatown.png'),
          Text(text),
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
