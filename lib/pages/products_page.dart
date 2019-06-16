import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../stores/app_store.dart';
import '../widgets/product_list/product_list.dart';
import './products_admin_page.dart';

// A list of products
class ProductsPage extends StatelessWidget {
  static const routeName = '/products';

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    print('[ProductsPage] build');

    return Scaffold(
      drawer: _buildDrawer(context),
      appBar: AppBar(
        title: Text('Hello Flutter'),
        actions: <Widget>[
          Consumer<AppStore>(builder: (_, store, __) {
            return IconButton(
              icon: Icon(store.isDisplayModeFavorite
                  ? Icons.favorite
                  : Icons.favorite_border),
              onPressed: () {
                store.toggleDisplayMode();
              },
            );
          })
        ],
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
