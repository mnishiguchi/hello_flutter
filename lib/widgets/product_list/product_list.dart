import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './product_list_item.dart';
import '../../models/product.dart';
import '../../stores/app_store.dart';

class ProductList extends StatelessWidget {
  Widget build(BuildContext context) {
    print('[ProductList] build');

    return ScopedModelDescendant<AppStore>(
      builder: (BuildContext context, Widget child, AppStore store) {
        final List<Product> products = store.products;

        // The build method must return a widget even it if nothing is displayed.
        if (products.length <= 0)
          return Center(child: Text("No product found"));

        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (BuildContext context, int index) {
            return ProductListItem(products[index], index);
          },
        );
      },
    );
  }
}
