import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/features/home/pages/index_page.dart';
import 'package:flutter_app/features/splash/pages/splash_page.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (!snapshot.hasData)
            return SplashPage();
          else
            return IndexPage();
        } else
          return Scaffold();
      },
      stream: FirebaseAuth.instance.authStateChanges(),
    );
  }
}
