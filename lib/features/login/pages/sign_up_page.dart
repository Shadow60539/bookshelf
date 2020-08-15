import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/core/utils/colors.dart';
import 'package:flutter_app/core/utils/strings.dart';
import 'package:flutter_app/routes/router.gr.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String email;
  String userName;
  String password;
  String errorMsg;
  bool _loading = false;
  bool _showPassword = false;
  bool _autoValidate = false;

  String _showErrorMessage(String errorMessage) {
    switch (errorMessage) {
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        return 'Email is already in use';
        break;
      case 'ERROR_WEAK_PASSWORD':
        return 'Password must atleast be 6 characters long';
        break;
      case 'ERROR_INVALID_EMAIL':
        return 'Improper Email';
        break;
      case 'Sign Up':
        return 'Sign Up Again';
        break;
      default:
        return 'Sign Up';
    }
  }

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
                    height: 50,
                    width: double.maxFinite,
                    child: RaisedButton(
                      child: _loading
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text(
                              _showErrorMessage(errorMsg),
                              style: style.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5),
                            ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          try {
                            setState(() {
                              _loading = true;
                            });
                            final newUser =
                                await _auth.createUserWithEmailAndPassword(
                                    email: email, password: password);
                            if (newUser != null) {
                              setState(() {
                                _loading = false;
                              });
                              final user =
                                  await FirebaseAuth.instance.currentUser();
                              Firestore.instance
                                  .collection('userName')
                                  .document(user.uid)
                                  .setData({'userName': userName});
                              Navigator.pushReplacementNamed(
                                  context, Router.indexPage);
                            }
                          } catch (e) {
                            PlatformException error = e as PlatformException;
                            setState(() {
                              errorMsg = error.code;
                              _loading = false;
                            });
                            Future.delayed(Duration(seconds: 3), () {
                              setState(() {
                                errorMsg = 'Sign Up';
                              });
                            });
                          }
                        } else {
                          setState(() {
                            _autoValidate = true;
                          });
                        }
                      },
                      color: kDarkBlue,
                    ),
                  )
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
    return Form(
      autovalidate: _autoValidate,
      key: _formKey,
      child: Expanded(
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
                      validator: (String arg) {
                        if (arg.length < 1)
                          return 'Forgot to enter email ?';
                        else
                          return null;
                      },
                      onSaved: (value) {
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
                      style: TextStyle(color: Colors.black),
                      decoration: _textFieldDecoration(label: 'Username'),
                      autocorrect: false,
                      validator: (String arg) {
                        if (arg.length < 1)
                          return 'Forgot to enter username ?';
                        else
                          return null;
                      },
                      onSaved: (newValue) {
                        userName = newValue;
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
                    FontAwesomeIcons.lock,
                    size: 16,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Flexible(
                    child: TextFormField(
                      scrollPadding: padding,
                      style: TextStyle(color: Colors.black),
                      obscureText: !_showPassword,
                      decoration:
                          _textFieldDecoration(label: 'Password').copyWith(
                              suffixIcon: IconButton(
                                  iconSize: 14,
                                  color: Colors.white,
                                  icon: !_showPassword
                                      ? Icon(
                                          FontAwesomeIcons.eyeSlash,
                                          color: Colors.black,
                                        )
                                      : Icon(
                                          FontAwesomeIcons.eye,
                                          color: kDarkBlue,
                                        ),
                                  onPressed: () {
                                    setState(() {
                                      _showPassword = !_showPassword;
                                    });
                                  })),
                      autocorrect: false,
                      validator: (String arg) {
                        if (arg.length < 1)
                          return 'Forgot to enter password ?';
                        else
                          return null;
                      },
                      onSaved: (value) {
                        password = value;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
