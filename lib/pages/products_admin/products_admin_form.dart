import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../models/product.dart';
import '../../stores/product_store.dart';

// https://github.com/flutter/flutter/issues/1632#issuecomment-180478202
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class ProductsAdminForm extends StatelessWidget {
  final Map<String, dynamic> _formData = {
    'title': '',
    'description': '',
    'price': '',
    'image': 'assets/mn_logo.png',
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

  void _submitForm({
    BuildContext context,
    Product product,
    Function addProduct,
    Function updateProduct,
  }) {
    if (!_formKey.currentState.validate()) return;

    _formKey.currentState.save();

    if (product == null) {
      addProduct(
        title: _formData['title'],
        description: _formData['description'],
        price: _formData['price'],
        image: _formData['image'],
      );
    } else {
      updateProduct(
        title: _formData['title'],
        description: _formData['description'],
        price: _formData['price'],
        image: _formData['image'],
      );
    }

    Navigator.pushReplacementNamed(context, '/products');
  }

  double computeTargetPadding(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth;
    return deviceWidth - targetWidth;
  }

  Widget _buildPageContent({
    BuildContext context,
    Product product,
    Function addProduct,
    Function updateProduct,
  }) {
    print('[ProductsAdminForm] _buildPageContent');

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
                _submitForm(
                  context: context,
                  addProduct: addProduct,
                  updateProduct: updateProduct,
                  product: product,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget _, ProductStore store) {
        final Widget pageContent = _buildPageContent(
          context: context,
          product: store.selectedProduct,
          addProduct: store.addProduct,
          updateProduct: store.updateProduct,
        );

        // Use scaffold when this widget is a standalone page.
        return store.selectedProduct == null
            ? pageContent
            : Scaffold(
                appBar: AppBar(
                  title: Text('Edit Product'),
                ),
                body: pageContent,
              );
      },
    );
  }
}
