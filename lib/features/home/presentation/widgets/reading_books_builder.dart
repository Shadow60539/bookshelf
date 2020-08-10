import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/colors.dart';
import 'package:flutter_app/core/dimens.dart';
import 'package:flutter_app/core/model/book.dart';
import 'package:flutter_app/routes/router.gr.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReadingBooksBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyText1;
    return Container(
      margin: EdgeInsets.only(top: 820, right: 30),
      height: booksCardHolderHeight,
      width: double.maxFinite,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
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
                  'Continue Reading',
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
              maxHeight: booksCardHolderLimitedHeight,
              child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('reading').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData)
                    return ListView.builder(
                      reverse: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map<String, dynamic> readingBookData =
                            snapshot.data.documents[index].data;
                        Book book = Book(
                            title: readingBookData['title'],
                            author: readingBookData['author'],
                            imgUrl: readingBookData['imgUrl'],
                            desc: readingBookData['desc'],
                            language: readingBookData['language'],
                            category: readingBookData['category'],
                            pages: readingBookData['pages']);
                        return FocusedMenuHolder(
                          menuWidth: 170,
                          menuItems: <FocusedMenuItem>[
                            FocusedMenuItem(
                                title: Text(
                                  'Remove',
                                  style: style.copyWith(
                                      color: CupertinoColors.white),
                                ),
                                onPressed: () async {
                                  await Firestore.instance
                                      .collection('reading')
                                      .document(snapshot
                                          .data.documents[index].documentID)
                                      .delete();
                                },
                                trailingIcon: Icon(
                                  Icons.delete,
                                  size: 18,
                                ),
                                backgroundColor: Colors.red),
                            FocusedMenuItem(
                                title: Text('Add to wishlist'),
                                onPressed: () async {
                                  await Firestore.instance
                                      .collection('reading')
                                      .document(snapshot
                                          .data.documents[index].documentID)
                                      .delete();
                                  Firestore.instance
                                      .collection('wishlist')
                                      .add({
                                    'title': book.title,
                                    'author': book.author,
                                    'imgUrl': book.imgUrl,
                                    'language': book.language,
                                    'pages': book.pages,
                                    'desc': book.desc,
                                    'category': book.category
                                  });
                                },
                                trailingIcon: Icon(
                                  FontAwesomeIcons.book,
                                  size: 16,
                                )),
                            FocusedMenuItem(
                                title: Text('Mark as read'),
                                onPressed: () async {
                                  await Firestore.instance
                                      .collection('reading')
                                      .document(snapshot
                                          .data.documents[index].documentID)
                                      .delete();
                                  Firestore.instance.collection('read').add({
                                    'title': book.title,
                                    'author': book.author,
                                    'imgUrl': book.imgUrl,
                                    'language': book.language,
                                    'pages': book.pages,
                                    'desc': book.desc,
                                    'category': book.category
                                  });
                                },
                                trailingIcon: Icon(
                                  FontAwesomeIcons.check,
                                  size: 14,
                                  color: kDarkBlue,
                                )),
                          ],
                          onPressed: () => Navigator.pushNamed(
                              context, Router.bookPage,
                              arguments: book),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  height: 150,
                                  width: 100,
                                  child: Image.network(
                                    readingBookData['imgUrl'],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  readingBookData['author'].length > 20
                                      ? '${readingBookData['author'].substring(0, 20)}...'
                                      : readingBookData['author'],
                                  style: style.copyWith(
                                      color: Colors.grey, fontSize: 12),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  readingBookData['title'].length > 15
                                      ? '${readingBookData['title'].substring(0, 15)}...'
                                      : readingBookData['title'],
                                  style: style.copyWith(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
