import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../../stores/app_store.dart';
import '../../pages/product_page.dart';
import '../ui_elements/title_default.dart';
import './price_tag.dart';
import './address_tag.dart';

class ProductListItem extends StatelessWidget {
  final Product product;
  final int productIndex;

  ProductListItem(this.product, this.productIndex);

  Widget _buildTitlePriceRow() {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TitleDefault(product.title),
          SizedBox(
            width: 8.0,
          ),
          PriceTag(product.price)
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.info),
          color: Theme.of(context).accentColor,
          onPressed: () {
            Navigator.pushNamed(
              context,
              ProductPage.routeName,
              arguments: ProductPageArgs(productIndex: productIndex),
            );
          },
        ),
        Consumer<AppStore>(
          builder: (_, store, __) {
            return IconButton(
              icon: Icon(store.allProducts[productIndex].isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border),
              color: Colors.red,
              onPressed: () {
                store.selectProduct(productIndex);
                store.toggleProductFavoriteStatus();
              },
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(product.image),
          _buildTitlePriceRow(),
          AddressTag('1600 Pennsylvania Ave NW, Washington, DC'),
          _buildActionButtons(context)
        ],
      ),
    );
    ;
  }
}
