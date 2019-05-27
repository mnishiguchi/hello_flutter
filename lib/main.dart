import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';

import './models/product.dart';
// import "./pages/auth_page.dart";
import './pages/product_page.dart';
import './pages/products_page.dart';
import './pages/products_admin_page.dart';

void main() {
  // debugPaintSizeEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  // properties
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();

    print('[MyAppState] initState');
  }

  // Called when external props trigger the re-rendering.
  @override
  void didUpdateWidget(MyApp oldWidget) {
    super.didUpdateWidget(oldWidget);

    print('[MyAppState] didUpdateWidget');
  }

  void _addProduct(Product product) {
    setState(() {
      _products.add(product);
    });
  }

  void _updateProduct(int index, Product product) {
    setState(() {
      _products[index] = product;
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowMaterialGrid: true,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        accentColor: Colors.green,
        brightness: Brightness.light,
      ),
      // static routes
      routes: {
        '/': (_) => ProductsPage(products: _products),
        '/products': (_) => ProductsPage(products: _products),
        '/admin': (_) => ProductsAdminPage(
              addProduct: _addProduct,
              updateProduct: _updateProduct,
              deleteProduct: _deleteProduct,
              products: _products,
            ),
      },
      // dynamic routes
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');

        print('onGenerateRoute: $pathElements');

        if (pathElements[0] != '') return null;

        if (pathElements[1] == 'product') {
          final int index = int.parse(pathElements[2]);
          return MaterialPageRoute<Product>(
            builder: (_) => ProductPage(product: _products[index]),
          );
        }

        return null;
      },
      // fallback route
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (_) => ProductsPage(products: _products),
        );
      },
    );
  }
}
