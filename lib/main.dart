import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';

import "./pages/auth_page.dart";
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
  List<Map<String, dynamic>> _products = [];

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

  void _addProduct(Map<String, dynamic> product) {
    setState(() {
      _products.add(product);
    });
  }

  void _removeProductByIndex(int index) {
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
      // home: AuthPage(),
      // static routes
      routes: {
        '/': (BuildContext context) => ProductsPage(
              products: _products,
            ),
        '/admin': (BuildContext context) => ProductsAdminPage(
              addProduct: _addProduct,
              removeProductByIndex: _removeProductByIndex,
            ),
      },
      // dynamic routes
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');

        print('onGenerateRoute: $pathElements');

        if (pathElements[0] != '') return null;

        if (pathElements[1] == 'product') {
          final int index = int.parse(pathElements[2]);
          return MaterialPageRoute<Map<String, dynamic>>(
              builder: (BuildContext context) =>
                  ProductPage(product: _products[index]));
        }

        return null;
      },
      // fallback route
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (BuildContext context) => ProductsPage(products: _products),
        );
      },
    );
  }
}
