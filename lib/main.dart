import 'package:flutter/material.dart';
import 'package:flutter_app/core/utils/colors.dart';
import 'package:flutter_app/routes/router.gr.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Router.rootPage,
      onGenerateRoute: Router.onGenerateRoute,
      debugShowCheckedModeBanner: false,
      title: 'Bookshelf',
      theme: ThemeData.light().copyWith(
        primaryColor: kLightBlue,
        textTheme: TextTheme(
          bodyText1: TextStyle(fontFamily: 'Lato', color: Colors.black),
        ),
      ),
    );
  }
}
