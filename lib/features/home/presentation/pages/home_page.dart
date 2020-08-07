import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/global/colors.dart';
import 'package:flutter_app/global/strings.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyText1;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Image.network(loginPageImgUrl),
              Container(
                width: double.maxFinite,
                height: 40,
                decoration: BoxDecoration(
                    border: Border.all(color: kDarkBlue),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(
                        Icons.search,
                        color: kDarkBlue,
                      ),
                    ),
                    Text(
                      'Search books by name',
                      style: style.copyWith(color: kDarkBlue),
                    )
                  ],
                ),
              ),
              buildNewBooksListView(style),
              Container(
                margin: EdgeInsets.only(top: 550),
                height: 300,
                width: double.maxFinite,
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Categories',
                          style: style.copyWith(
                              fontSize: 30, color: CupertinoColors.black),
                        ),
                        Text(
                          'see all',
                          style: style.copyWith(color: kDarkBlue),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    LimitedBox(
                      maxHeight: 130,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int index) =>
                            Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          width: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    spreadRadius: 1,
                                    blurRadius: 10,
                                    offset: Offset(0, 4))
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.person),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Poetry',
                                style: style.copyWith(
                                    color: Colors.black, fontSize: 20),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '45 books',
                                style: style.copyWith(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNewBooksListView(TextStyle style) {
    return Container(
      margin: EdgeInsets.only(top: 130, left: 50),
      height: 400,
      width: double.maxFinite,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black12, spreadRadius: 10, blurRadius: 20)
          ]),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Discover new',
                  style: style.copyWith(
                      fontSize: 30, color: CupertinoColors.black),
                ),
                Text(
                  'see all',
                  style: style.copyWith(color: kDarkBlue),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Hunt new books before other bookworms do it',
              style: style.copyWith(color: Colors.black54),
            ),
            SizedBox(
              height: 20,
            ),
            LimitedBox(
              maxHeight: 270,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Placeholder(
                        fallbackWidth: 150,
                        fallbackHeight: 200,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Author name',
                        style: style.copyWith(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Book name',
                        style:
                            style.copyWith(color: Colors.black, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
