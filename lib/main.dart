import 'package:flutter/material.dart';
import 'package:flutter_app/core/colors.dart';
import 'package:flutter_app/routes/router.gr.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Router.rootPage,
      onGenerateRoute: Router.onGenerateRoute,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.light().copyWith(
        primaryColor: kLightBlue,
        textTheme: TextTheme(
          bodyText1: TextStyle(fontFamily: 'Lato', color: Colors.white),
          bodyText2: TextStyle(fontFamily: 'Lato', color: Colors.black),
        ),
      ),
    );
  }
}
