import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../../stores/app_store.dart';
import '../../pages/products_page.dart';

// https://github.com/flutter/flutter/issues/1632#issuecomment-180478202
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class ProductsAdminForm extends StatelessWidget {
  final Map<String, dynamic> _formData = {
    'title': '',
    'description': '',
    'price': '',
    'image': 'assets/food.jpg',
  };

  Widget _buildTitleTextFormField(Product product) {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(labelText: 'Product Title'),
      initialValue: product == null ? '' : product.title,
      validator: (String value) {
        if (value.isEmpty || value.length < 5) {
          return 'required and at least 5 characters long';
        }
      },
      onSaved: (String value) {
        _formData['title'] = value;
      },
    );
  }

  Widget _buildDescriptionTextFormField(Product product) {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: 4,
      decoration: InputDecoration(labelText: 'Product Description'),
      initialValue: product == null ? '' : product.description,
      validator: (String value) {
        if (value.isEmpty || value.length < 5) {
          return 'required and at least 5 characters long';
        }
      },
      onSaved: (String value) {
        _formData['description'] = value;
      },
    );
  }

  Widget _buildPriceTextFormField(Product product) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Product Price'),
      initialValue: product == null ? '' : product.price,
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
          return 'should be a number';
        }
      },
      onSaved: (String value) {
        _formData['price'] = value;
      },
    );
  }

  void _submitForm({BuildContext context, AppStore appStore}) {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    if (appStore.selectedProduct == null) {
      appStore.addProduct(
        title: _formData['title'],
        description: _formData['description'],
        price: _formData['price'],
        image: _formData['image'],
      );
    } else {
      appStore.updateProduct(
        title: _formData['title'],
        description: _formData['description'],
        price: _formData['price'],
        image: _formData['image'],
      );
    }

    // Unselect the product after navigating away because this page's rendering
    // is determined by the presence of a selected product.
    Navigator.pushReplacementNamed(context, ProductsPage.routeName).then((_) {
      appStore.selectProduct(null);
    });
  }

  double computeTargetPadding(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth;
    return deviceWidth - targetWidth;
  }

  Widget _buildPageContent({BuildContext context, AppStore appStore}) {
    print('[ProductsAdminForm] _buildPageContent');

    final Product product = appStore.selectedProduct;

    return Container(
      margin: EdgeInsets.all(10.0),
      child: Form(
        key: _formKey,
        child: ListView(
          padding:
              EdgeInsets.symmetric(horizontal: computeTargetPadding(context)),
          children: <Widget>[
            _buildTitleTextFormField(product),
            _buildDescriptionTextFormField(product),
            _buildPriceTextFormField(product),
            SizedBox(height: 10.0),
            RaisedButton(
              child: Text('Save'),
              color: Theme.of(context).accentColor,
              textColor: Colors.white,
              onPressed: () {
                _submitForm(context: context, appStore: appStore);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppStore appStore = Provider.of<AppStore>(context);

    // Use scaffold when this widget is a standalone page.
    return appStore.selectedProduct == null
        ? _buildPageContent(context: context, appStore: appStore)
        : Scaffold(
            appBar: AppBar(
              title: Text('Edit Product'),
            ),
            body: _buildPageContent(context: context, appStore: appStore),
          );
  }
}
