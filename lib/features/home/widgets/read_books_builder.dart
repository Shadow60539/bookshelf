import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/model/book.dart';
import 'package:flutter_app/core/utils/dimens.dart';
import 'package:flutter_app/core/utils/strings.dart';
import 'package:flutter_app/routes/router.gr.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReadBooksBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyText1;

    return Container(
      margin: EdgeInsets.only(top: 1580, right: 30),
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
            Text(
              'Finished Reading',
              style: style.copyWith(fontSize: 30, color: CupertinoColors.black),
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
                stream:
                    Firestore.instance.collection(ReadCollection).snapshots(),
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
                        List<Book> books = [];
                        snapshot.data.documents.forEach((element) {
                          Book book = Book(
                              title: element.data['title'],
                              author: element.data['author'],
                              imgUrl: element.data['imgUrl'],
                              desc: element.data['desc'],
                              language: element.data['language'],
                              category: element.data['category'],
                              pages: element.data['pages']);
                          books.add(book);
                        });
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
                                      .collection(ReadCollection)
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
                                title: Text('Read again',
                                    style: style.copyWith(color: Colors.black)),
                                onPressed: () async {
                                  await Firestore.instance
                                      .collection(ReadCollection)
                                      .document(snapshot
                                          .data.documents[index].documentID)
                                      .delete();
                                  Firestore.instance
                                      .collection(ReadingCollection)
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
                          ],
                          onPressed: () => Navigator.pushNamed(
                              context, Router.bookPage,
                              arguments: BookPageArguments(
                                  book: book,
                                  fromLibrary: true,
                                  bookList: books,
                                  index: index)),
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
