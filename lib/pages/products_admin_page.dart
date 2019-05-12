import 'package:flutter/material.dart';

import './product_create_from.dart';
import './products_admin_index_pane.dart';

class ProductsAdminPage extends StatelessWidget {
  final Function addProduct;
  final Function removeProductByIndex;

  ProductsAdminPage({this.addProduct, this.removeProductByIndex});

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
                  title: Text('All Products'),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/');
                  },
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
              ProductCreateForm(
                addProduct: addProduct,
                removeProductByIndex: removeProductByIndex,
              ),
              ProductsAdminIndexPane(),
            ],
          )

          //   child: ProductManager(),
          ),
    );
  }
}
