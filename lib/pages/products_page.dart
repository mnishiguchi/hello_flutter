import 'package:flutter/material.dart';

import '../product_manager.dart';

class ProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello Flutter"),
      ),
      body: Center(
        child: ProductManager(),
      ),
    );
  }
}
