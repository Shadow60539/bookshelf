import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/utils/colors.dart';
import 'package:flutter_app/core/utils/strings.dart';

class SettingsPage extends StatelessWidget {
  getUserName() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    var sh = await Firestore.instance
        .collection('userName')
        .document(user.uid)
        .get();
    return sh;
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyText1;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 10,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Text(
            'Settings',
            style: style.copyWith(
                color: kDarkBlue, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: kDarkBlue, width: 1))),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FutureBuilder(
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          'Hello ${snapshot.data['userName']}',
                          style:
                              style.copyWith(color: Colors.black, fontSize: 20),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          'Hello Bibliophile',
                          style:
                              style.copyWith(color: Colors.black, fontSize: 20),
                        ),
                      );
                    }
                  },
                  future: getUserName(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 54,
                        backgroundColor: kDividerColor,
                      ),
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          dpUrl,
                        ),
                      ),
                      SizedBox(
                        child: Transform.rotate(
                          angle: pi * 1.4,
                          child: CircularProgressIndicator(
                            value: 0.7,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(kDividerColor),
                          ),
                        ),
                        height: 135,
                        width: 135,
                      ),
                      SizedBox(
                        child: Transform.rotate(
                          angle: pi * 1.2,
                          child: CircularProgressIndicator(
                            value: 0.1,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(kDarkBlue),
                          ),
                        ),
                        height: 135,
                        width: 135,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Beginner',
                  style: style.copyWith(color: Colors.black45),
                ),
                SizedBox(
                  height: 20,
                ),
                buildSettingsField(
                    style: style,
                    title: 'Notifications',
                    iconData: Icons.notifications),
                buildSettingsField(
                    style: style,
                    title: 'Change Password',
                    iconData: Icons.vpn_key),
                buildSettingsField(
                  style: style,
                  title: 'About App',
                  iconData: Icons.info_outline,
                ),
                buildSettingsField(
                    style: style,
                    title: 'Logout',
                    iconData: Icons.exit_to_app,
                    onTap: () async {
                      showCupertinoDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CupertinoAlertDialog(
                            content: Text(
                              'Are you sure you want to logout',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            title: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Warning',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                              ),
                            ),
                            actions: <Widget>[
                              CupertinoButton(
                                  child: Text('No'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }),
                              CupertinoButton(
                                  child: Text('Yes'),
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    await FirebaseAuth.instance.signOut();
                                  }),
                            ],
                          );
                        },
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSettingsField(
      {String title, TextStyle style, IconData iconData, Function onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        padding: EdgeInsets.only(left: 20),
        width: double.maxFinite,
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: kDividerColor))),
        child: Row(
          children: <Widget>[
            Icon(iconData),
            SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: style.copyWith(color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
