import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/utils/colors.dart';

class LoadingStateBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyText1;
    return Scaffold(
      backgroundColor: kDarkBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/loading_state/loading.gif',
              height: 100,
              fit: BoxFit.fitHeight,
            ),
            Text(
              'loading books',
              style: style.copyWith(color: CupertinoColors.white),
            )
          ],
        ),
      ),
    );
  }
}
