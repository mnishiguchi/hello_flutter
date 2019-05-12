import 'package:flutter/material.dart';

// Map
class ProductList extends StatelessWidget {
  // immutable properties
  final List<Map<String, dynamic>> products;

  // constructor that accepts params that are bound to properties
  ProductList({this.products = const []}) {
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
                child: Text('Details'),
                onPressed: () {
                  Future<Map<String, dynamic>> result = Navigator.pushNamed(
                    context,
                    '/product/$index',
                  );
                  result.then((result) {
                    // Do nothing for null result.
                    if (result == null) return;

                    if (result['deleted']) {
                      // TODO: delete item
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
