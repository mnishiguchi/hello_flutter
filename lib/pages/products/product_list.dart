import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../models/product.dart';
import '../../stores/product_store.dart';
import '../../pages/product_page.dart';

class ProductList extends StatelessWidget {
  Widget build(BuildContext context) {
    print('[ProductList] build');

    return ScopedModelDescendant<ProductStore>(
      builder: (BuildContext context, Widget child, ProductStore store) {
        final List<Product> products = store.products;

        // The build method must return a widget even it if nothing is displayed.
        if (products.length <= 0)
          return Center(child: Text("No product found"));

        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (BuildContext context, int index) {
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
                          Navigator.pushNamed(
                            context,
                            ProductPage.routeName,
                            arguments: ProductPageArgs(productIndex: index),
                          );
                        },
                      )
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
