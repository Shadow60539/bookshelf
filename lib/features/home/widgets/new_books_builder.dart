import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/enums/document_present_absent.dart';
import 'package:flutter_app/core/model/book.dart';
import 'package:flutter_app/core/utils/colors.dart';
import 'package:flutter_app/core/utils/dimens.dart';
import 'package:flutter_app/core/utils/strings.dart';
import 'package:flutter_app/features/home/pages/see_all_books_page.dart';
import 'package:flutter_app/routes/router.gr.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewBooksBuilder extends StatelessWidget {
  final List<Book> books;
  final GlobalKey<ScaffoldState> scaffoldKey;

  NewBooksBuilder({this.books, this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<Document> _wishlistNotifier =
        ValueNotifier<Document>(Document.absent);
    ValueNotifier<Document> _readingNotifier =
        ValueNotifier<Document>(Document.absent);
    Firestore _firestore = Firestore.instance;
    final style = Theme.of(context).textTheme.bodyText1;
    return AnimatedBuilder(
      builder: (BuildContext context, Widget child) {
        return Container(
          margin: EdgeInsets.only(top: 230, left: 30),
          height: booksCardHolderHeight,
          width: double.maxFinite,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, spreadRadius: 10, blurRadius: 20)
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
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SeeAllBooksPage())),
                      child: Text(
                        'see all',
                        style: style.copyWith(color: kDarkBlue),
                      ),
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
                  maxHeight: booksCardHolderLimitedHeight,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: books.length ?? 0,
                    itemBuilder: (BuildContext context, int index) =>
                        FocusedMenuHolder(
                      menuWidth: 170,
                      menuItems: <FocusedMenuItem>[
                        FocusedMenuItem(
                            title: Text('Add to wish list',
                                style: style.copyWith(color: Colors.black)),
                            onPressed: () {
                              _addToWishList(
                                  index: index,
                                  style: style,
                                  wishlistNotifier: _wishlistNotifier,
                                  firestore: _firestore);
                            },
                            trailingIcon: Icon(
                              FontAwesomeIcons.bookmark,
                              size: 16,
                            )),
                        FocusedMenuItem(
                            title: Text(
                              'Add to read next',
                              style: style.copyWith(color: Colors.black),
                            ),
                            onPressed: () {
                              books.removeAt(index);
                              _addToReadingList(
                                  index: index,
                                  style: style,
                                  readingNotifier: _readingNotifier,
                                  firestore: _firestore);
                            },
                            trailingIcon: Icon(
                              FontAwesomeIcons.book,
                              size: 16,
                            )),
                      ],
                      onPressed: () => Navigator.pushNamed(
                          context, Router.bookPage,
                          arguments: BookPageArguments(
                              book: books[index], fromLibrary: false)),
                      child: Hero(
                        tag: books[index].imgUrl,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  height: 150,
                                  width: 100,
                                  child: Image.network(
                                    books[index].imgUrl,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  books[index].author.length > 20
                                      ? '${books[index].author.substring(0, 20)}...'
                                      : books[index].author,
                                  style: style.copyWith(
                                      color: Colors.grey, fontSize: 12),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  books[index].title.length > 15
                                      ? '${books[index].title.substring(0, 15)}...'
                                      : books[index].title,
                                  style: style.copyWith(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      animation: Listenable.merge([_wishlistNotifier, _readingNotifier]),
    );
  }

  Future<Null> _addToWishList(
      {Firestore firestore,
      TextStyle style,
      int index,
      ValueNotifier wishlistNotifier}) async {
    return await firestore
        .collection(WishListCollection)
        .getDocuments()
        .then((snapshot) {
      for (var ds in snapshot.documents) {
        if (ds.data['imgUrl'] == books[index].imgUrl) {
          wishlistNotifier.value = Document.present;
          break;
        } else {
          wishlistNotifier.value = Document.absent;
        }
      }
      if (wishlistNotifier.value == Document.present) {
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(
            'Book already exist',
            style: style.copyWith(color: Colors.white),
          ),
          backgroundColor: kDarkBlue,
          duration: Duration(seconds: 1),
        ));
      } else {
        firestore.collection(WishListCollection).add({
          'title': books[index].title,
          'author': books[index].author,
          'imgUrl': books[index].imgUrl,
          'language': books[index].language,
          'pages': books[index].pages,
          'desc': books[index].desc,
          'category': books[index].category
        });
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(
            'Added to wishlist',
            style: style.copyWith(color: Colors.white),
          ),
          backgroundColor: kDarkBlue,
          duration: Duration(seconds: 1),
        ));
      }
    });
  }

  Future<Null> _addToReadingList(
      {Firestore firestore,
      TextStyle style,
      int index,
      ValueNotifier readingNotifier}) async {
    return await firestore
        .collection(ReadingCollection)
        .getDocuments()
        .then((snapshot) {
      for (var ds in snapshot.documents) {
        if (ds.data['imgUrl'] == books[index].imgUrl) {
          readingNotifier.value = Document.present;
          break;
        } else {
          readingNotifier.value = Document.absent;
        }
      }
      if (readingNotifier.value == Document.present) {
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(
            'Book already exist',
            style: style.copyWith(color: Colors.white),
          ),
          backgroundColor: kDarkBlue,
          duration: Duration(seconds: 1),
        ));
      } else {
        firestore.collection(ReadingCollection).add({
          'title': books[index].title,
          'author': books[index].author,
          'imgUrl': books[index].imgUrl,
          'language': books[index].language,
          'pages': books[index].pages,
          'desc': books[index].desc,
          'category': books[index].category
        });
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(
            'Added to reading list',
            style: style.copyWith(color: Colors.white),
          ),
          backgroundColor: kDarkBlue,
          duration: Duration(seconds: 1),
        ));
      }
    });
  }
}
