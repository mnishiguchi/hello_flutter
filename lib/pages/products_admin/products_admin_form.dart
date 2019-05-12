import 'package:flutter/material.dart';

class ProductsAdminForm extends StatefulWidget {
  final Function addProduct;
  final Function updateProduct;
  final Map<String, dynamic> product;
  final int productIndex;

  ProductsAdminForm({
    this.addProduct,
    this.updateProduct,
    this.product,
    this.productIndex,
  });

  @override
  _ProductsAdminFormState createState() => _ProductsAdminFormState();
}

class _ProductsAdminFormState extends State<ProductsAdminForm> {
  final Map<String, dynamic> _formData = {
    'title': '',
    'description': '',
    'price': '',
    'image': 'assets/mn_logo.png',
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildTitleTextFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(labelText: 'Product Title'),
      initialValue: widget.product == null ? '' : widget.product['title'],
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

  Widget _buildDescriptionTextFormField() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: 4,
      decoration: InputDecoration(labelText: 'Product Description'),
      initialValue: widget.product == null ? '' : widget.product['description'],
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

  Widget _buildPriceTextFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Product Price'),
      initialValue: widget.product == null ? '' : widget.product['price'],
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

  void _submitForm() {
    if (!_formKey.currentState.validate()) return;

    _formKey.currentState.save();

    if (widget.product == null) {
      widget.addProduct(_formData);
    } else {
      widget.updateProduct(widget.productIndex, _formData);
    }

    Navigator.pushReplacementNamed(context, '/products');
  }

  double computeTargetPadding(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth;
    return deviceWidth - targetWidth;
  }

  Widget _buildPageContent(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // This allows a user to close a soft keyboard by tapping somewhere.
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        padding:
            EdgeInsets.symmetric(horizontal: computeTargetPadding(context)),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              _buildTitleTextFormField(),
              _buildDescriptionTextFormField(),
              _buildPriceTextFormField(),
              SizedBox(height: 10.0),
              RaisedButton(
                child: Text('Save'),
                color: Theme.of(context).accentColor,
                textColor: Colors.white,
                onPressed: _submitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget pageContent = _buildPageContent(context);

    // Use scaffold when this widget is a standalone page.
    return widget.product == null
        ? pageContent
        : Scaffold(
            appBar: AppBar(
              title: Text('Edit Product'),
            ),
            body: pageContent,
          );
  }
}
