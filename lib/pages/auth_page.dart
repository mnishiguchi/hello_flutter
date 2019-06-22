import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../stores/app_store.dart';
import '../pages/products_page.dart';

// https://github.com/flutter/flutter/issues/1632#issuecomment-180478202
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class AuthPage extends StatefulWidget {
  static const routeName = '/auth';

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final Map<String, dynamic> _formData = {
    'email': '',
    'password': '',
    'isTermsAccepted': false,
  };

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
      image: AssetImage('assets/background.jpg'),
    );
  }

  Widget _buildEmailTextFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          labelText: 'E-Mail', filled: true, fillColor: Colors.white),
      validator: (String value) {
        if (value.isEmpty || value.length < 5) {
          return 'required and at least 5 characters long';
        }
      },
      onSaved: (String value) {
        _formData['email'] = value;
      },
    );
  }

  Widget _buildPasswordTextFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          labelText: 'Password', filled: true, fillColor: Colors.white),
      obscureText: true,
      validator: (String value) {
        if (value.isEmpty || value.length < 5) {
          return 'required and at least 5 characters long';
        }
      },
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }

  // This field needs a local state because it isnt a form field.
  Widget _buildTermsAcceptedSwitch() {
    return SwitchListTile(
      title: Text('Accept Terms'),
      value: _formData['isTermsAccepted'],
      onChanged: (bool value) {
        setState(() {
          _formData['isTermsAccepted'] = value;
        });
      },
    );
  }

  void _submitForm({BuildContext context, Function loginUser}) {
    if (!_formKey.currentState.validate() || !_formData['isTermsAccepted']) {
      return;
    }

    _formKey.currentState.save();
    loginUser(email: _formData['email'], password: _formData['password']);
    Navigator.pushReplacementNamed(context, ProductsPage.routeName);
  }

  double computeTargetPadding(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth;
    return deviceWidth - targetWidth;
  }

  @override
  Widget build(BuildContext context) {
    print('[ProductPage] build');

    AppStore appStore = Provider.of<AppStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Log in'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: _buildBackgroundImage(),
        ),
        padding: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding:
                EdgeInsets.symmetric(horizontal: computeTargetPadding(context)),
            children: <Widget>[
              _buildEmailTextFormField(),
              SizedBox(height: 10.0),
              _buildPasswordTextFormField(),
              _buildTermsAcceptedSwitch(),
              SizedBox(height: 10.0),
              RaisedButton(
                  child: Text('LOGIN'),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  onPressed: () {
                    _submitForm(
                        context: context, loginUser: appStore.loginUser);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
