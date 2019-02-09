// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';

class PrimaryColorOverride extends StatelessWidget {
  const PrimaryColorOverride({Key key, this.color, this.child})
      : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: child,
      data: Theme.of(context).copyWith(
          hintColor: Colors.white
      ),
    );
  }
}


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //  _formKey and _autoValidate
  static final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool _autoValidate = false;
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {

    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 60.0,
        child: Image.asset('assets/logo.png'),
      ),
    );


    void _validateInputs() {
      if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
        _formKey.currentState.save();
        _autoValidate = false;
        print(_email);
        print(_password);
        Navigator.pop(context);
      } else {
//      If all data are not valid then start auto validation.
        _autoValidate = true;
      }
    }

    String validateEmail(String value) {
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = new RegExp(pattern);
      if (!regex.hasMatch(value))
        return 'Enter Valid Email';
      else
        return null;
    }

    final email = PrimaryColorOverride(
      color: Colors.white,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        validator: validateEmail,
        initialValue: 'saikat@itobuz.com',
        onSaved: (String val) {
          _email = val;
        },
        decoration: InputDecoration(
          hintText: 'Email',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
      ),
    );

    final password = PrimaryColorOverride(
      color: Colors.white,
      child: TextFormField(
        autofocus: false,
        obscureText: true,
        initialValue: '123',
        onSaved: (String val) {
          _password = val;
        },
        decoration: InputDecoration(
          hintText: 'Password',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: _validateInputs,
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {},
    );

    return Scaffold(
      body: Center(
        child: new Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              logo,
              SizedBox(height: 48.0),
              email,
              SizedBox(height: 8.0),
              password,
              SizedBox(height: 24.0),
              loginButton,
              forgotLabel
            ],
          ),
        ),
      ),
    );
  }
}

