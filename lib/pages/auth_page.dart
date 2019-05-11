import 'package:flutter/material.dart';

import './products_page.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log in'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Log in'),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => ProductsPage(),
              ),
            );
          },
        ),
      ),
    );
  }
}
