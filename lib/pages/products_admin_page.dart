import 'package:flutter/material.dart';

import './products_admin_new_pane.dart';
import './products_admin_index_pane.dart';

class ProductsAdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          drawer: Drawer(
            child: Column(
              children: <Widget>[
                AppBar(
                  automaticallyImplyLeading: false,
                  title: Text('Choose'),
                ),
                ListTile(
                  title: Text('Manage Products'),
                  onTap: () {},
                ),
              ],
            ),
          ),
          appBar: AppBar(
            title: Text('Hello Flutter'),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.create),
                  text: 'Create Product',
                ),
                Tab(
                  icon: Icon(Icons.list),
                  text: 'My Products',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              ProductsAdminNewPane(),
              ProductsAdminIndexPane(),
            ],
          )

          //   child: ProductManager(),
          ),
    );
  }
}
