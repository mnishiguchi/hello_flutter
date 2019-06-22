import 'package:flutter/material.dart';

import '../models/product.dart';
import '../models/user.dart';

class AppStore extends ChangeNotifier
    with SharedBaseStore, UserStore, ProductStore {}

// The intersection of all the stores.
mixin SharedBaseStore on ChangeNotifier {
  // state
  User _authenticatedUser;
  List<Product> _products = [];
  int _selectedProductIndex;

  List<Product> get products => List.from(_products);

  int get selectedProductIndex => _selectedProductIndex;

  Product get selectedProduct {
    if (_selectedProductIndex == null) {
      return null;
    }
    return _products[_selectedProductIndex];
  }

  void selectProduct(int index) {
    print('[ProductStore] selectProduct $index');

    _selectedProductIndex = index;

    // Dont notify when clearing the index.
    if (index != null) {
      notifyListeners();
    }
  }

  void addProduct({
    @required String title,
    @required String description,
    @required String image,
    @required String price,
  }) {
    print('[ProductStore] addProduct');

    _products.add(
      Product(
        title: title,
        description: description,
        image: image,
        price: price,
        userId: _authenticatedUser.id,
        userEmail: _authenticatedUser.email,
      ),
    );

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
      userId: _authenticatedUser.id,
      userEmail: _authenticatedUser.email,
    );

    notifyListeners();
  }

  void deleteProduct() {
    _products.removeAt(_selectedProductIndex);
    assert(_selectedProductIndex != null);

    notifyListeners();
  }
}

mixin UserStore on SharedBaseStore {
  void loginUser({
    @required String email,
    @required String password,
  }) {
    _authenticatedUser =
        User(id: 'mnishiguchi', email: email, password: password);
  }
}

mixin ProductStore on SharedBaseStore {
  // state
  bool _isDisplayModeFavorite = false;

  bool get isDisplayModeFavorite => _isDisplayModeFavorite;

  List<Product> get allProducts => List.from(_products);

  List<Product> get filteredProducts =>
      _isDisplayModeFavorite ? favoriteProducts : allProducts;

  List<Product> get favoriteProducts =>
      _products.where((product) => product.isFavorite).toList();

  void toggleProductFavoriteStatus() {
    print('[ProductStore] toggleProductFavoriteStatus');
    assert(_selectedProductIndex != null);

    updateProduct(isFavorite: !selectedProduct.isFavorite);
    notifyListeners();
  }

  void toggleDisplayMode() {
    print('[ProductStore] toggleDisplayMode');

    _isDisplayModeFavorite = !_isDisplayModeFavorite;
    notifyListeners();
  }
}
