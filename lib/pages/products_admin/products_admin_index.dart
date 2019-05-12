import 'package:flutter/material.dart';
import 'package:hello_flutter/pages/products_admin/products_admin_form.dart';

class ProductsAdminIndex extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final Function updateProduct;
  final Function deleteProduct;

  ProductsAdminIndex({
    this.products,
    this.updateProduct,
    this.deleteProduct,
  });

  _showConfirmationDialog(BuildContext context, Function callback) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure?'),
          content: Text('This action cannot be undone.'),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                // Close the dialog.
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text('Continue'),
              onPressed: () {
                // Close the dialog.
                Navigator.pop(context);
                callback();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _editButton(BuildContext context, int index) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return ProductsAdminForm(
                product: products[index],
                updateProduct: updateProduct,
                productIndex: index,
              );
            },
          ),
        );
      },
    );
  }

  Widget _deleteButton(BuildContext context, int index) {
    return IconButton(
      icon: Icon(Icons.delete),
      onPressed: () {
        _showConfirmationDialog(context, () {
          deleteProduct(index);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print('[ProductsAdminIndex] build - $products');

    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        Map<String, dynamic> product = products[index];
        return Dismissible(
          key: Key(product['title']),
          background: Container(color: Colors.red),
          onDismissed: (DismissDirection direction) {
            if (direction == DismissDirection.endToStart) {
              print('Swiped endToStart');
              deleteProduct(index);
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
                  backgroundImage: AssetImage(product['image']),
                ),
                title: Text(product['title']),
                subtitle: Text('\$${product['price']}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _deleteButton(context, index),
                    _editButton(context, index),
                  ],
                ),
              ),
              Divider(),
            ],
          ),
        );
      },
      itemCount: products.length,
    );
  }
}
