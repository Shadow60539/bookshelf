import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/model/book.dart';
import 'package:flutter_app/core/utils/colors.dart';

class BookPage extends StatefulWidget {
  final Book book;
  final bool fromLibrary;
  BookPage({@required this.book, this.fromLibrary = false});

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TabController _tabController;
  AnimationController _animationController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _animationController = AnimationController(
        vsync: this,
        lowerBound: 0.09,
        upperBound: 0.1,
        duration: Duration(milliseconds: 600))
      ..forward();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyText1;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              icon: Icon(
                Icons.close,
                size: 20,
                color: Colors.black,
              ),
              onPressed: () => Navigator.pop(context)),
        ),
        body: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
              height: double.maxFinite,
              margin: EdgeInsets.only(top: 70, left: 20, right: 20),
              width: double.maxFinite,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12, spreadRadius: 10, blurRadius: 20)
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(top: 150),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 15),
                      color: kDarkBlue,
                      height: 24,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      child: Text(
                        widget.book.category,
                        style: style.copyWith(color: Colors.white),
                      ),
                    ),
                    Text(
                      widget.book.author,
                      style: style.copyWith(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        widget.book.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style:
                            style.copyWith(color: Colors.black, fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Divider(
                      color: Colors.black12,
                      indent: 50,
                      endIndent: 50,
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TabBar(
                      controller: _tabController,
                      labelColor: kDarkBlue,
                      indicatorColor: kDarkBlue,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorWeight: 4,
                      labelPadding: EdgeInsets.only(bottom: 5),
                      indicatorPadding: EdgeInsets.symmetric(horizontal: 15),
                      tabs: [
                        Text(
                          'About Book',
                          style: style.copyWith(color: Colors.black),
                        ),
                        Text(
                          'Owner\'s Info',
                          style: style.copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                    Expanded(
                        child:
                            TabBarView(controller: _tabController, children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(10)),
                            margin: EdgeInsets.only(
                                top: 30, left: 20, right: 20, bottom: 30),
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Condition',
                                        style: style.copyWith(
                                            color: Colors.black45),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        '4.0',
                                        style:
                                            style.copyWith(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Pages',
                                        style: style.copyWith(
                                            color: Colors.black45),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        widget.book.pages.toString() != 'null'
                                            ? widget.book.pages.toString()
                                            : '396',
                                        style:
                                            style.copyWith(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Cover',
                                        style: style.copyWith(
                                            color: Colors.black45),
                                      ),
                                      Text(
                                        'Hard',
                                        style:
                                            style.copyWith(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Language',
                                        style: style.copyWith(
                                            color: Colors.black45),
                                      ),
                                      Text(
                                        widget.book.language,
                                        style:
                                            style.copyWith(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              'Description',
                              style: style.copyWith(color: Colors.grey),
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              widget.book.desc ??
                                  'This book has no description',
                              style: style.copyWith(color: Colors.black),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(10)),
                            margin: EdgeInsets.only(
                                top: 30, left: 20, right: 20, bottom: 30),
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Condition',
                                        style: style.copyWith(
                                            color: Colors.black45),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        '4.0',
                                        style:
                                            style.copyWith(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Pages',
                                        style: style.copyWith(
                                            color: Colors.black45),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        widget.book.pages.toString() != 'null'
                                            ? widget.book.pages.toString()
                                            : '396',
                                        style:
                                            style.copyWith(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Cover',
                                        style: style.copyWith(
                                            color: Colors.black45),
                                      ),
                                      Text(
                                        'Hard',
                                        style:
                                            style.copyWith(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Language',
                                        style: style.copyWith(
                                            color: Colors.black45),
                                      ),
                                      Text(
                                        widget.book.language,
                                        style:
                                            style.copyWith(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              'Description',
                              style: style.copyWith(color: Colors.grey),
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              widget.book.desc ??
                                  'This book has no description',
                              style: style.copyWith(color: Colors.black),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ])),
                    widget.fromLibrary
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: Container(
                                        margin:
                                            EdgeInsets.only(right: 0, left: 20),
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
                                            'Add to read next',
                                            style: style.copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 0.5),
                                          ),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          onPressed: () async {
                                            await Firestore.instance
                                                .collection('reading')
                                                .add({
                                              'title': widget.book.title,
                                              'author': widget.book.author,
                                              'imgUrl': widget.book.imgUrl,
                                              'language': widget.book.language,
                                              'pages': widget.book.pages,
                                              'desc': widget.book.desc,
                                              'category': widget.book.category
                                            });

                                            _scaffoldKey.currentState
                                                .showSnackBar(SnackBar(
                                              backgroundColor: kLightBlue,
                                              content: Text(
                                                'Book added successfully',
                                                style: style.copyWith(
                                                    color:
                                                        CupertinoColors.white),
                                              ),
                                              duration:
                                                  Duration(milliseconds: 800),
                                            ));

                                            Future.delayed(Duration(seconds: 1),
                                                () {
                                              Navigator.pop(context);
                                            });
                                          },
                                          color: kDarkBlue,
                                        ))),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Container(
                                        margin:
                                            EdgeInsets.only(right: 20, left: 0),
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
                                            'Add to wishlist',
                                            style: style.copyWith(
                                                color: kDarkBlue,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 0.5),
                                          ),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          onPressed: () async {
                                            await Firestore.instance
                                                .collection('wishlist')
                                                .add({
                                              'title': widget.book.title,
                                              'author': widget.book.author,
                                              'imgUrl': widget.book.imgUrl,
                                              'language': widget.book.language,
                                              'pages': widget.book.pages,
                                              'desc': widget.book.desc,
                                              'category': widget.book.category
                                            });

                                            _scaffoldKey.currentState
                                                .showSnackBar(SnackBar(
                                              backgroundColor: kLightBlue,
                                              content: Text(
                                                'Book added successfully',
                                                style: style.copyWith(
                                                    color:
                                                        CupertinoColors.white),
                                              ),
                                              duration:
                                                  Duration(milliseconds: 800),
                                            ));

                                            Future.delayed(Duration(seconds: 1),
                                                () {
                                              Navigator.pop(context);
                                            });
                                          },
                                          color: Colors.white,
                                        ))),
                              ],
                            ),
                          )
                  ],
                ),
              ),
            ),
            Positioned(
              top: -2,
              child: Hero(
                tag: widget.book.imgUrl,
                child: AnimatedBuilder(
                    builder: (BuildContext context, Widget child) {
                      return Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.0006)
                          ..rotateY(pi / _animationController.value),
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 200,
                          width: 150,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 1,
                                blurRadius: 20,
                                offset:
                                    Offset(0, 200 * _animationController.value))
                          ]),
                          child: Image.network(
                            widget.book.imgUrl,
                            height: 200,
                            width: 150,
                          ),
                        ),
                      );
                    },
                    animation: CurvedAnimation(
                        parent: _animationController, curve: Curves.easeOut)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
