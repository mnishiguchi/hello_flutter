import 'package:flutter/material.dart';

import 'package:hello_flutter/product_list.dart';

class ProductsPage extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final Function addProduct;
  final Function removeProductByIndex;

  ProductsPage({this.products, this.addProduct, this.removeProductByIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
              title: Text('Choose'),
            ),
            ListTile(
              title: Text('Manage Products'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/admin');
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Hello Flutter'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10.0),
              child: RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  addProduct({
                    'title': 'Software Engineer',
                    'image': 'assets/masa_chinatown.png',
                  });
                },
                child: Text("Add Product"),
              ),
            ),
            Expanded(
              child: ProductList(
                products: products,
                removeProductByIndex: removeProductByIndex,
              ),
            )
          ],
        ),
      ),
    );
  }
}
