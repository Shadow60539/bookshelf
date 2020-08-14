import 'package:flutter/material.dart';
import 'package:flutter_app/core/model/book.dart';

class BookPageTabBarView extends StatelessWidget {
  final List<Book> bookList;
  final int index;
  final TabController tabController;

  BookPageTabBarView({this.bookList, this.index, this.tabController});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyText1;
    return Expanded(
      child: TabBarView(controller: tabController, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 30),
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Condition',
                          style: style.copyWith(color: Colors.black45),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          '4.0',
                          style: style.copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Pages',
                          style: style.copyWith(color: Colors.black45),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          bookList[index].pages.toString() != 'null'
                              ? bookList[index].pages.toString()
                              : '396',
                          style: style.copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Cover',
                          style: style.copyWith(color: Colors.black45),
                        ),
                        Text(
                          'Hard',
                          style: style.copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Language',
                          style: style.copyWith(color: Colors.black45),
                        ),
                        Text(
                          bookList[index].language,
                          style: style.copyWith(color: Colors.black),
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
                bookList[index].desc ?? 'This book has no description',
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
              margin: EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 30),
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Condition',
                          style: style.copyWith(color: Colors.black45),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          '4.0',
                          style: style.copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Pages',
                          style: style.copyWith(color: Colors.black45),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          bookList[index].pages.toString() != 'null'
                              ? bookList[index].pages.toString()
                              : '396',
                          style: style.copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Cover',
                          style: style.copyWith(color: Colors.black45),
                        ),
                        Text(
                          'Hard',
                          style: style.copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Language',
                          style: style.copyWith(color: Colors.black45),
                        ),
                        Text(
                          bookList[index].language,
                          style: style.copyWith(color: Colors.black),
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
                bookList[index].desc ?? 'This book has no description',
                style: style.copyWith(color: Colors.black),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
