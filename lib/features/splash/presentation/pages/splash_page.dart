import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/global/colors.dart';
import 'package:flutter_app/routes/router.gr.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyText1;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: _bottomText(context),
        body: GestureDetector(
          onTap: () =>
              Navigator.pushReplacementNamed(context, Router.loginPage),
          child: Container(
            decoration: _decoration(),
            child: Center(child: _title(style)),
          ),
        ),
      ),
    );
  }

  Widget _bottomText(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: kDarkBlue, border: Border.all(color: kDarkBlue, width: 0)),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Text(
          'Powered by None.',
          style: Theme.of(context).textTheme.bodyText1,
          textAlign: TextAlign.center,
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
    return Row(
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
    );
  }
}
