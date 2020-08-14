import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/model/book.dart';
import 'package:flutter_app/core/utils/colors.dart';
import 'package:flutter_app/core/utils/strings.dart';

class BookPageBottomButtons extends StatelessWidget {
  final bool fromLibrary;
  final List<Book> bookList;
  final int index;
  final GlobalKey<ScaffoldState> scaffoldKey;

  BookPageBottomButtons(
      {this.fromLibrary, this.bookList, this.index, this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyText1;
    return fromLibrary
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                        margin: EdgeInsets.only(right: 0, left: 20),
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
                              borderRadius: BorderRadius.circular(5)),
                          onPressed: () async {
                            await Firestore.instance
                                .collection(ReadingCollection)
                                .add({
                              'title': bookList[index].title,
                              'author': bookList[index].author,
                              'imgUrl': bookList[index].imgUrl,
                              'language': bookList[index].language,
                              'pages': bookList[index].pages,
                              'desc': bookList[index].desc,
                              'category': bookList[index].category
                            });

                            scaffoldKey.currentState.showSnackBar(SnackBar(
                              backgroundColor: kLightBlue,
                              content: Text(
                                'Book added successfully',
                                style: style.copyWith(color: Colors.white),
                              ),
                              duration: Duration(milliseconds: 800),
                            ));

                            Future.delayed(Duration(seconds: 1), () {
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
                        margin: EdgeInsets.only(right: 20, left: 0),
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
                              borderRadius: BorderRadius.circular(5)),
                          onPressed: () async {
                            await Firestore.instance
                                .collection(WishListCollection)
                                .add({
                              'title': bookList[index].title,
                              'author': bookList[index].author,
                              'imgUrl': bookList[index].imgUrl,
                              'language': bookList[index].language,
                              'pages': bookList[index].pages,
                              'desc': bookList[index].desc,
                              'category': bookList[index].category
                            });

                            scaffoldKey.currentState.showSnackBar(SnackBar(
                              backgroundColor: kLightBlue,
                              content: Text(
                                'Book added successfully',
                                style: style.copyWith(color: Colors.white),
                              ),
                              duration: Duration(milliseconds: 800),
                            ));

                            Future.delayed(Duration(seconds: 1), () {
                              Navigator.pop(context);
                            });
                          },
                          color: Colors.white,
                        ))),
              ],
            ),
          );
  }
}
