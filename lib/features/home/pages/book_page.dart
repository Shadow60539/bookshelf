import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/model/book.dart';
import 'package:flutter_app/core/utils/colors.dart';
import 'package:flutter_app/features/home/widgets/book_page_bottom_buttons.dart';
import 'package:flutter_app/features/home/widgets/book_page_tabbar_view.dart';

class BookPage extends StatefulWidget {
  final Book book;
  final List<Book> bookList;
  final int index;
  final bool fromLibrary;
  BookPage(
      {@required this.book,
      this.fromLibrary = false,
      this.bookList,
      this.index});

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TabController _tabController;
  AnimationController _animationController;
  PageController _pageController;
  @override
  void initState() {
    _pageController = PageController(initialPage: widget.index);
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
    _pageController.dispose();
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
        body: PageView.builder(
          controller: _pageController,
          itemCount: widget.bookList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                buildBookHolder(style, index),
                buildBookCover(index)
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildBookHolder(TextStyle style, int index) {
    return Container(
      height: double.maxFinite,
      margin: EdgeInsets.only(top: 70, left: 20, right: 20),
      width: double.maxFinite,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black12, spreadRadius: 10, blurRadius: 20)
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
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              child: Text(
                widget.book.category,
                style: style.copyWith(color: Colors.white),
              ),
            ),
            Text(
              widget.bookList[index].author,
              style: style.copyWith(color: Colors.grey),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                widget.bookList[index].title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: style.copyWith(color: Colors.black, fontSize: 20),
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
            buildTabBar(style),
            BookPageTabBarView(
              index: index,
              bookList: widget.bookList,
              tabController: _tabController,
            ),
            BookPageBottomButtons(
              fromLibrary: widget.fromLibrary,
              bookList: widget.bookList,
              scaffoldKey: _scaffoldKey,
              index: index,
            )
          ],
        ),
      ),
    );
  }

  Positioned buildBookCover(int index) {
    return Positioned(
      top: -2,
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
                      offset: Offset(0, 200 * _animationController.value))
                ]),
                child: Image.network(
                  widget.bookList[index].imgUrl,
                  height: 200,
                  width: 150,
                ),
              ),
            );
          },
          animation: CurvedAnimation(
              parent: _animationController, curve: Curves.easeOut)),
    );
  }

  TabBar buildTabBar(TextStyle style) {
    return TabBar(
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
    );
  }
}
