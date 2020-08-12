import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorStateBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyText1;
    return Scaffold(
      backgroundColor: CupertinoColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/error_state/error.png',
              height: 150,
              fit: BoxFit.fitHeight,
            ),
            Text(
              'Oops something went wrong',
              style: style.copyWith(color: Colors.black26, fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
