import 'package:flutter/material.dart';
import 'package:hello_flutter/pages/products_admin_page.dart';

import '../widgets/product_list/product_list.dart';

// A list of products
class ProductsPage extends StatelessWidget {
  static const routeName = '/products';

  @override
  Widget build(BuildContext context) {
    print('[ProductsPage] build');

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
                Navigator.pushReplacementNamed(
                  context,
                  ProductsAdminPage.routeName,
                );
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
            Expanded(
              child: ProductList(),
            )
          ],
        ),
      ),
    );
  }
}
