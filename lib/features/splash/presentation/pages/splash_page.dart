import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/colors.dart';
import 'package:flutter_app/routes/router.gr.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  final _auth = FirebaseAuth.instance;
  AnimationController _animationController;
  String email;
  String password;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyText1;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: _bottomText(context, style),
        body: GestureDetector(
          onTap: () =>
              Navigator.pushReplacementNamed(context, Router.signUpPage),
          child: Container(
            decoration: _decoration(),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _title(style),
                Text(
                  'Read books like never before',
                  style: style.copyWith(color: Colors.white),
                ),
                FadeTransition(
                  opacity: _animationController
                      .drive(CurveTween(curve: Curves.slowMiddle)),
                  child: SlideTransition(
                    child: _form(context),
                    position: Tween<Offset>(
                      begin: Offset(0, -0.5),
                      end: Offset(0, 0),
                    ).animate(CurvedAnimation(
                        parent: _animationController, curve: Curves.easeOut)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomText(BuildContext context, TextStyle style) {
    return Container(
      decoration: BoxDecoration(
          color: kDarkBlue, border: Border.all(color: kDarkBlue, width: 0)),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(right: 50, left: 80),
                height: 40,
                width: double.maxFinite,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 0.5,
                      offset: Offset(2, 2))
                ]),
                child: RaisedButton(
                  child: Text(
                    'Sign In',
                    style: style.copyWith(
                        color: kDarkBlue,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  onPressed: () async {
                    if (_animationController.status ==
                        AnimationStatus.completed) {
                      await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      Navigator.pushReplacementNamed(
                          context, Router.discoverPage);
                    } else {
                      _animationController.forward();
                    }
                  },
                  color: Colors.white,
                )),
            SizedBox(
              height: 20,
            ),
            Container(
                margin: EdgeInsets.only(right: 50, left: 80),
                height: 40,
                width: double.maxFinite,
                child: OutlineButton(
                  borderSide: BorderSide(color: Colors.white),
                  child: Text(
                    'Sign Up',
                    style: style.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  onPressed: () => Navigator.pushReplacementNamed(
                      context, Router.signUpPage),
                )),
            SizedBox(
              height: 50,
            ),
            Text(
              'Powered by None.',
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Decoration _decoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [kLightBlue, kDarkBlue],
        begin: Alignment(0.0, -1.0),
        end: Alignment(0.0, 1.0),
      ),
    );
  }

  Widget _title(TextStyle style) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: <Widget>[
          Text(
            'Book',
            style: style.copyWith(fontWeight: FontWeight.w900, fontSize: 30),
          ),
          Text('shelf',
              style: style.copyWith(fontWeight: FontWeight.w100, fontSize: 25))
        ],
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
            color: Colors.white,
            width: 1,
          ),
        ),
        labelText: label,
        labelStyle: TextStyle(color: Colors.white, fontSize: 14),
      );

  Widget _form(context) {
    EdgeInsetsGeometry padding =
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom * 0);
    return Container(
      height: 170,
      margin: EdgeInsets.symmetric(horizontal: 50),
      child: ListView(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom, top: 50),
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: 50.0,
            margin: EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.mail_outline,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.white),
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
                  Icons.vpn_key,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: TextFormField(
                    scrollPadding: padding,
                    style: TextStyle(color: Colors.white),
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

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
