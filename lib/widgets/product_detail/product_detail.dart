import 'package:flutter/material.dart';

import '../../models/product.dart';
import '../ui_elements/title_default.dart';
import './address_price_row.dart';

class ProductDetail extends StatelessWidget {
  final Product product;

  ProductDetail(this.product);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset(product.image),
        Container(
          padding: EdgeInsets.all(10.0),
          child: TitleDefault(product.title),
        ),
        AddressPriceRow(
            '1600 Pennsylvania Ave NW, Washington, DC', product.price),
        Container(
          padding: EdgeInsets.all(10.0),
          child: Text(
            product.description,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
