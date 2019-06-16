import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import "package:provider/provider.dart";

import './stores/app_store.dart';
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
  @override
  Widget build(BuildContext context) {
    // Provide a singleton instance for the entire tree.
    return ChangeNotifierProvider<AppStore>(
      builder: (_) => AppStore(),
      child: MaterialApp(
        // debugShowMaterialGrid: true,
        theme: ThemeData(
          primarySwatch: Colors.orange,
          accentColor: Colors.green,
          brightness: Brightness.light,
        ),
        // static routes
        routes: {
          '/': (_) => ProductsPage(),
          ProductsAdminPage.routeName: (_) => ProductsAdminPage(),
          ProductsPage.routeName: (_) => ProductsPage(),
        },
        // dynamic routes
        onGenerateRoute: (RouteSettings settings) {
          print('onGenerateRoute: $settings.name');

          if (settings.name == ProductPage.routeName) {
            ProductPageArgs args = settings.arguments;

            return MaterialPageRoute<Product>(
              builder: (_) => ProductPage(args.productIndex),
            );
          }

          return null;
        },
        // fallback route
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (_) => ProductsPage(),
          );
        },
      ),
    );
  }
}
