import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/core/model/book.dart';
import 'package:flutter_app/core/utils/colors.dart';
import 'package:flutter_app/core/utils/dimens.dart';
import 'package:flutter_app/core/utils/strings.dart';
import 'package:flutter_app/routes/router.gr.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReadingBooksBuilder extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  ReadingBooksBuilder({this.scaffoldKey});

  @override
  _ReadingBooksBuilderState createState() => _ReadingBooksBuilderState();
}

class _ReadingBooksBuilderState extends State<ReadingBooksBuilder> {
  FirebaseAuth user = FirebaseAuth.instance;
  String userId = "uid";
  @override
  void initState() {
    user.currentUser().then((value) {
      if (user != null) {
        setState(() {
          userId = value.uid;
        });
      }
    });
    super.initState();
  }

  clearAll() {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: Text(
            'Are you sure you want to clear all books',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          title: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Warning',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 15),
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
                onPressed: () {
                  Firestore.instance
                      .collection(UsersCollection)
                      .document(userId)
                      .collection(ReadingCollection)
                      .getDocuments()
                      .then((snapshot) {
                    for (DocumentSnapshot ds in snapshot.documents) {
                      ds.reference.delete();
                    }
                  });
                  Navigator.pop(context);
                  widget.scaffoldKey.currentState.showSnackBar(SnackBar(
                    content: Text(
                      'Cleared reading list',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.white),
                    ),
                    backgroundColor: kDarkBlue,
                    duration: Duration(seconds: 1),
                  ));
                }),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyText1;
    return StreamBuilder(
      stream: Firestore.instance
          .collection(UsersCollection)
          .document(userId)
          .collection(ReadingCollection)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return Container(
            margin: EdgeInsets.only(top: 820, right: 30),
            height: booksCardHolderHeight,
            width: double.maxFinite,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
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
                        'Continue Reading',
                        style: style.copyWith(
                            fontSize: 30, color: CupertinoColors.black),
                      ),
                      snapshot.data.documents.isEmpty
                          ? Container()
                          : GestureDetector(
                              onTap: clearAll,
                              child: Text(
                                'Clear',
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
                    child: snapshot.data.documents.isEmpty
                        ? Align(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(emptyUrl),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Feed this list with books',
                                  style: style.copyWith(color: Colors.black26),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
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
                                            .collection(UsersCollection)
                                            .document(userId)
                                            .collection(ReadingCollection)
                                            .document(snapshot.data
                                                .documents[index].documentID)
                                            .delete();
                                        widget.scaffoldKey.currentState
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                            'Removed successfully',
                                            style: style.copyWith(
                                                color: Colors.white),
                                          ),
                                          backgroundColor: kDarkBlue,
                                          duration: Duration(seconds: 1),
                                        ));
                                      },
                                      trailingIcon: Icon(
                                        Icons.delete,
                                        size: 18,
                                      ),
                                      backgroundColor: Colors.red),
                                  FocusedMenuItem(
                                      title: Text('Move to wishlist',
                                          style: style.copyWith(
                                              color: Colors.black)),
                                      onPressed: () async {
                                        await Firestore.instance
                                            .collection(UsersCollection)
                                            .document(userId)
                                            .collection(ReadingCollection)
                                            .document(snapshot.data
                                                .documents[index].documentID)
                                            .delete();
                                        Firestore.instance
                                            .collection(UsersCollection)
                                            .document(userId)
                                            .collection(WishListCollection)
                                            .add({
                                          'title': book.title,
                                          'author': book.author,
                                          'imgUrl': book.imgUrl,
                                          'language': book.language,
                                          'pages': book.pages,
                                          'desc': book.desc,
                                          'category': book.category
                                        });
                                        widget.scaffoldKey.currentState
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                            'Moved to wishlist',
                                            style: style.copyWith(
                                                color: Colors.white),
                                          ),
                                          backgroundColor: kDarkBlue,
                                          duration: Duration(seconds: 1),
                                        ));
                                      },
                                      trailingIcon: Icon(
                                        FontAwesomeIcons.book,
                                        size: 16,
                                      )),
                                  FocusedMenuItem(
                                      title: Text('Mark as read',
                                          style: style.copyWith(
                                              color: Colors.black)),
                                      onPressed: () async {
                                        await Firestore.instance
                                            .collection(UsersCollection)
                                            .document(userId)
                                            .collection(ReadingCollection)
                                            .document(snapshot.data
                                                .documents[index].documentID)
                                            .delete();
                                        Firestore.instance
                                            .collection(UsersCollection)
                                            .document(userId)
                                            .collection(ReadCollection)
                                            .add({
                                          'title': book.title,
                                          'author': book.author,
                                          'imgUrl': book.imgUrl,
                                          'language': book.language,
                                          'pages': book.pages,
                                          'desc': book.desc,
                                          'category': book.category
                                        });
                                        widget.scaffoldKey.currentState
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                            'Keep going read more',
                                            style: style.copyWith(
                                                color: Colors.white),
                                          ),
                                          backgroundColor: kDarkBlue,
                                          duration: Duration(seconds: 1),
                                        ));
                                      },
                                      trailingIcon: Icon(
                                        FontAwesomeIcons.check,
                                        size: 14,
                                        color: kDarkBlue,
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                          ),
                  ),
                ],
              ),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
