import 'package:flutter/material.dart';

class ProductCreateForm extends StatefulWidget {
  final Function addProduct;
  final Function removeProductByIndex;

  ProductCreateForm({this.addProduct, this.removeProductByIndex});

  @override
  _ProductCreateFormState createState() => _ProductCreateFormState();
}

class _ProductCreateFormState extends State<ProductCreateForm> {
  // Form values
  String _title = '';
  String _description = '';
  String _price = '';
  bool _isTermsAccepted = false;
  String _image = 'assets/masa_chinatown.png';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: ListView(
        children: <Widget>[
          TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(labelText: 'Product Title'),
            onChanged: (String value) {
              setState(() {
                _title = value;
              });
            },
          ),
          TextField(
            keyboardType: TextInputType.multiline,
            maxLines: 4,
            decoration: InputDecoration(labelText: 'Product Description'),
            onChanged: (String value) {
              setState(() {
                _description = value;
              });
            },
          ),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Product Price'),
            onChanged: (String value) {
              setState(() {
                _price = value;
              });
            },
          ),
          SwitchListTile(
            title: Text('Accept Terms'),
            value: _isTermsAccepted,
            onChanged: (bool value) {
              setState(() {
                _isTermsAccepted = value;
              });
            },
          ),
          SizedBox(
            height: 10.0,
          ),
          RaisedButton(
            child: Text('Save'),
            color: Theme.of(context).accentColor,
            textColor: Colors.white,
            onPressed: () {
              final Map<String, dynamic> product = {
                'title': _title,
                'description': _description,
                'price': _price,
                'image': _image,
              };
              widget.addProduct(product);
              Navigator.pushReplacementNamed(context, '/');
            },
          )
        ],
      ),
    );
  }
}
