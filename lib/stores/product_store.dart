import 'package:flutter/material.dart';

import '../models/product.dart';

mixin ProductStore on ChangeNotifier {
  List<Product> _products = [];
  int _selectedProductIndex;
  bool _isDisplayModeFavorite = false;

  List<Product> get products {
    return List.from(_products);
  }

  List<Product> get allProducts {
    return List.from(_products);
  }

  List<Product> get favoriteProducts {
    return _products.where((Product product) => product.isFavorite).toList();
  }

  List<Product> get displayedProducts {
    return _isDisplayModeFavorite ? favoriteProducts : allProducts;
  }

  bool get isDisplayModeFavorite {
    return _isDisplayModeFavorite;
  }

  int get selectedProductIndex {
    return _selectedProductIndex;
  }

  Product get selectedProduct {
    if (_selectedProductIndex == null) return null;

    return _products[_selectedProductIndex];
  }

  void selectProduct(int index) {
    print('[ProductStore] selectProduct $index');

    _selectedProductIndex = index;
    notifyListeners();
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
    assert(_selectedProductIndex != null);

    selectProduct(null);
    notifyListeners();
  }

  void toggleProductFavoriteStatus() {
    print('[ProductStore] toggleProductFavoriteStatus');
    assert(_selectedProductIndex != null);

    updateProduct(isFavorite: !selectedProduct.isFavorite);
    notifyListeners();
    selectProduct(null);
  }

  void toggleDisplayMode() {
    print('[ProductStore] toggleDisplayMode');

    _isDisplayModeFavorite = !_isDisplayModeFavorite;
    notifyListeners();
  }
}
