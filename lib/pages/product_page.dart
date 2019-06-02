import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';
import '../stores/product_store.dart';

class ProductPageArgs {
  final int productIndex;

  ProductPageArgs({this.productIndex});
}

class ProductPage extends StatelessWidget {
  static const routeName = '/product';

  final int productIndex;

  ProductPage(this.productIndex);

  @override
  Widget build(BuildContext context) {
    print('[ProductPage] build');

    return ScopedModelDescendant<ProductStore>(
      builder: (BuildContext context, Widget child, ProductStore store) {
        Product product = store.products[productIndex];

        return Scaffold(
          appBar: AppBar(
            title: Text(product.title),
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(product.image),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        product.title,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Oswald',
                        ),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.0,
                          vertical: 2.5,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Text(
                          '\$${product.price}',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(6.0)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.0,
                      vertical: 2.5,
                    ),
                    child: Text(product.description),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
