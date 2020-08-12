import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/core/colors.dart';
import 'package:flutter_app/core/model/book.dart';
import 'package:flutter_app/core/network/http_get_books.dart';
import 'package:flutter_app/core/strings.dart';
import 'package:flutter_app/features/home/presentation/widgets/new_books_builder.dart';
import 'package:flutter_app/features/home/presentation/widgets/read_books_builder.dart';
import 'package:flutter_app/features/home/presentation/widgets/reading_books_builder.dart';
import 'package:flutter_app/features/home/presentation/widgets/wishlisted_books_builder.dart';
import 'package:flutter_app/routes/router.gr.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Widget _title(TextStyle style) {
    return Container(
      margin: EdgeInsets.only(top: 100, left: 30),
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: <Widget>[
          Text(
            'Book',
            style: style.copyWith(
                fontWeight: FontWeight.w900, fontSize: 30, color: kDarkBlue),
          ),
          Text('shelf',
              style: style.copyWith(
                  fontWeight: FontWeight.w100,
                  fontSize: 25,
                  color: CupertinoColors.white))
        ],
      ),
    );
  }

  Widget userDp() {
    return Positioned(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 21,
            backgroundColor: kDarkBlue,
          ),
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
              dpUrl,
            ),
          ),
        ],
      ),
      top: 20,
      right: 20,
    );
  }

  Container searchBar(TextStyle style) {
    return Container(
      width: double.maxFinite,
      height: 40,
      decoration: BoxDecoration(
          border: Border.all(color: kDarkBlue),
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 170),
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
    );
  }

  Container buildCategories(TextStyle style) {
    return Container(
      margin: EdgeInsets.only(top: 600),
      height: 300,
      width: double.maxFinite,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Text(
            'Categories',
            style: style.copyWith(fontSize: 30, color: CupertinoColors.black),
          ),
          SizedBox(
            height: 10,
          ),
          LimitedBox(
            maxHeight: 130,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                categoryChild(style: style, title: 'Fiction', category: 0),
                categoryChild(style: style, title: 'Poetry', category: 1),
                categoryChild(style: style, title: 'Design', category: 2),
                categoryChild(style: style, title: 'Cooking', category: 3),
                categoryChild(style: style, title: 'Nature', category: 4),
                categoryChild(style: style, title: 'Philosophy', category: 5),
                categoryChild(style: style, title: 'Education', category: 6),
                categoryChild(style: style, title: 'Comics', category: 7),
                categoryChild(style: style, title: 'Health', category: 8),
                categoryChild(style: style, title: 'Business', category: 9),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget categoryChild({TextStyle style, String title, int category}) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Router.seeAllBooksPage,
          arguments: category),
      child: Container(
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
            SvgPicture.asset(
              'assets/books/categories/${title.toLowerCase()}.svg',
              height: 30,
              width: 30,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: style.copyWith(color: Colors.black, fontSize: 20),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyText1;
    return SafeArea(
      child: FutureBuilder<List<Book>>(
        future: NetworkCall().fetchBooks(),
        builder: (BuildContext context, AsyncSnapshot<List<Book>> books) {
          if (books.connectionState == ConnectionState.done) {
            if (books.hasError) {
              return Center(
                child: Text(
                  '${books.error}',
                  style: style.copyWith(color: kDarkBlue, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return Scaffold(
                key: _scaffoldKey,
                body: SingleChildScrollView(
                  key: PageStorageKey(1),
                  padding: EdgeInsets.only(bottom: 20),
                  child: Stack(
                    children: <Widget>[
                      Image.network(loginPageImgUrl),
                      _title(style),
                      userDp(),
                      searchBar(style),
                      NewBooksBuilder(
                        books: books.data,
                        scaffoldKey: _scaffoldKey,
                      ),
                      buildCategories(style),
                      ReadingBooksBuilder(),
                      WishListedBooksBuilder(),
                      ReadBooksBuilder(),
                    ],
                  ),
                ),
              );
            }
          } else
            return Center(
              child: Text(
                'loading..',
                style: style.copyWith(
                    color: kDarkBlue,
                    fontWeight: FontWeight.w100,
                    fontSize: 20),
              ),
            );
        },
      ),
    );
  }
}
