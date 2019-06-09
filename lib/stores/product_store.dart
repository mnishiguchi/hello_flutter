import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';

mixin ProductStore on Model {
  List<Product> _products = [];
  int _selectedProductIndex;

  List<Product> get products {
    // return a copy of the product list
    return List.from(_products);
  }

  int get selectedProductIndex {
    return _selectedProductIndex;
  }

  Product get selectedProduct {
    if (_selectedProductIndex == null) return null;
    return _products[_selectedProductIndex];
  }

  void selectProduct(int index) {
    _selectedProductIndex = index;
    print('[ProductStore] selectProduct $_selectedProductIndex');
  }

  void addProduct({
    @required String title,
    @required String description,
    @required String image,
    @required String price,
  }) {
    print('[ProductStore] addProduct');

    _products.add(Product(
      title: title,
      description: description,
      image: image,
      price: price,
    ));
    notifyListeners();
  }

  void updateProduct({
    String title,
    String description,
    String image,
    String price,
  }) {
    print('[ProductStore] updateProduct');
    assert(_selectedProductIndex != null);
    _products[_selectedProductIndex] = Product(
      title: title ?? selectedProduct.title,
      description: description ?? selectedProduct.description,
      image: image ?? selectedProduct.image,
      price: price ?? selectedProduct.price,
    );
    notifyListeners();
  }

  void deleteProduct() {
    _products.removeAt(_selectedProductIndex);
    selectProduct(null);
    notifyListeners();
  }
}
