import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../models/product.dart';
import '../../stores/app_store.dart';
import './products_admin_form.dart';

class ProductsAdminIndex extends StatelessWidget {
  ProductsAdminIndex();

  Widget _buildEditButton({
    @required BuildContext context,
    @required AppStore store,
    @required int selectedProductIndex,
  }) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        store.selectProduct(selectedProductIndex);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return ProductsAdminForm();
            },
          ),
        ).then((_) {
          store.selectProduct(null);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print('[ProductsAdminIndex] build');

    return ScopedModelDescendant<AppStore>(
      builder: (BuildContext context, Widget _, AppStore store) {
        final List<Product> products = store.products;

        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(products[index].title),
              background: Container(color: Colors.red),
              onDismissed: (DismissDirection direction) {
                if (direction == DismissDirection.endToStart) {
                  print('Swiped endToStart');
                  store.selectProduct(index);
                  store.deleteProduct();
                } else if (direction == DismissDirection.startToEnd) {
                  print('Swiped startToEnd');
                } else {
                  print('Other swiping');
                }
              },
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(products[index].image),
                    ),
                    title: Text(products[index].title),
                    subtitle: Text('\$${products[index].price}'),
                    trailing: _buildEditButton(
                      context: context,
                      store: store,
                      selectedProductIndex: index,
                    ),
                  ),
                  Divider(),
                ],
              ),
            );
          },
          itemCount: products.length,
        );
      },
    );
  }
}
