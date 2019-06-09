import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';
import '../stores/app_store.dart';
import '../widgets/product_detail/product_detail.dart';

class ProductPageArgs {
  final int productIndex;

  ProductPageArgs({@required this.productIndex});
}

class ProductPage extends StatelessWidget {
  static const routeName = '/product';

  final int productIndex;

  ProductPage(this.productIndex);

  @override
  Widget build(BuildContext context) {
    print('[ProductPage] build');

    return ScopedModelDescendant<AppStore>(
      builder: (BuildContext context, Widget child, AppStore store) {
        Product product = store.products[productIndex];

        return Scaffold(
          appBar: AppBar(
            title: Text(product.title),
          ),
          body: ProductDetail(product),
        );
      },
    );
  }
}
