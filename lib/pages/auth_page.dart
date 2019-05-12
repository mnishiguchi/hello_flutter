import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // Form values
  String _email = '';
  String _password = '';
  bool _isTermsAccepted = false;

  Widget _buildEmailTextField() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(labelText: 'Email'),
      onChanged: (String value) {
        setState(() {
          _email = value;
        });
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(labelText: 'Password'),
      obscureText: true,
      onChanged: (String value) {
        setState(() {
          _password = value;
        });
      },
    );
  }

  Widget _buildAcceptTermSwitch() {
    return SwitchListTile(
      title: Text('Accept Terms'),
      value: _isTermsAccepted,
      onChanged: (bool value) {
        setState(() {
          _isTermsAccepted = value;
        });
      },
    );
  }

  void _submitForm() {
    print(_email);
    print(_password);
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log in'),
      ),
      body: Container(
        // TODO
        // decoration: BoxDecoration(
        //   image: DecorationImage('assets/masa_chinatown.png'),
        // ),
        margin: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            _buildEmailTextField(),
            _buildPasswordTextField(),
            _buildAcceptTermSwitch(),
            SizedBox(height: 10.0),
            RaisedButton(
              child: Text('LOGIN'),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: _submitForm,
            ),
          ],
        ),
      ),
    );
  }
}
