import 'package:flutter/material.dart';

import './pages/product_page.dart';

// Map
class ProductList extends StatelessWidget {
  // immutable properties
  final List<Map<String, dynamic>> products;
  final Function removeProductByIndex;

  // constructor that accepts params that are bound to properties
  ProductList({this.products = const [], this.removeProductByIndex}) {
    print('[ProductList] constructor');
  }

  Widget _buildProductItem(BuildContext context, int index) {
    print('[ProductList] _buildProductItem');

    Map<String, dynamic> product = products[index];
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(product['image']),
          Text(product['title']),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text(product['title']),
                onPressed: () {
                  Future<Map<String, dynamic>> result = Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ProductPage(product: product)),
                  );
                  result.then((result) {
                    // Do nothing for null result.
                    if (result == null) return;

                    if (result['deleted']) {
                      removeProductByIndex(index);
                    }
                  });
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
