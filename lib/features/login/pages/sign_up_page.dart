import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/core/utils/colors.dart';
import 'package:flutter_app/core/utils/strings.dart';
import 'package:flutter_app/routes/router.gr.dart';

String email;
String password;

class SignUpPage extends StatelessWidget {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyText1;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        body: Stack(
          children: <Widget>[
            Image.network(
              loginPageImgUrl,
              fit: BoxFit.cover,
            ),
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(top: 250),
              padding: EdgeInsets.all(50),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26, blurRadius: 20, spreadRadius: 5)
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'New',
                    style: style.copyWith(
                        fontSize: 30, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    'Account',
                    style: style.copyWith(
                        fontSize: 30, fontWeight: FontWeight.w600),
                  ),
                  _form(context),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: 60,
                    width: double.maxFinite,
                    child: RaisedButton(
                      child: Text(
                        'Sign up',
                        style: style.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      onPressed: () async {
                        try {
                          final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: email, password: password);
                          if (newUser != null) {
                            Navigator.pushReplacementNamed(
                                context, Router.indexPage);
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                      color: kDarkBlue,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  InputDecoration _textFieldDecoration({String label}) => InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: kDarkBlue,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
        labelText: label,
        labelStyle: TextStyle(color: Colors.black, fontSize: 14),
      );

  Widget _form(context) {
    EdgeInsetsGeometry padding =
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom * 0.6);
    return Expanded(
      child: ListView(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom, top: 50),
        children: <Widget>[
          Container(
            height: 50.0,
            margin: EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.mail_outline,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.black),
                    scrollPadding: padding,
                    decoration: _textFieldDecoration(label: 'Email'),
                    autocorrect: false,
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 50.0,
            margin: EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: TextFormField(
                    scrollPadding: padding,
                    decoration: _textFieldDecoration(label: 'Username'),
                    autocorrect: false,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 50.0,
            margin: EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.vpn_key,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: TextFormField(
                    scrollPadding: padding,
                    style: TextStyle(color: Colors.black),
                    obscureText: true,
                    decoration: _textFieldDecoration(label: 'Password'),
                    autocorrect: false,
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
