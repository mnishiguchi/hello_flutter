import 'package:flutter/material.dart';

import '../models/product.dart';

mixin ProductStore on ChangeNotifier {
  List<Product> _products = [];
  int _selectedProductIndex;

  List<Product> get products {
    return List.from(_products);
  }

  List<Product> get allProducts {
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
    bool isFavorite,
  }) {
    print('[ProductStore] updateProduct');
    assert(_selectedProductIndex != null);
    _products[_selectedProductIndex] = Product(
      title: title ?? selectedProduct.title,
      description: description ?? selectedProduct.description,
      image: image ?? selectedProduct.image,
      price: price ?? selectedProduct.price,
      isFavorite: isFavorite ?? selectedProduct.isFavorite,
    );
    notifyListeners();
  }

  void deleteProduct() {
    _products.removeAt(_selectedProductIndex);
    selectProduct(null);
    notifyListeners();
  }

  void toggleProductFavoriteStatus() {
    updateProduct(isFavorite: !selectedProduct.isFavorite);
    selectProduct(null);
    notifyListeners();
  }
}
