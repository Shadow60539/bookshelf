import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/core/colors.dart';
import 'package:flutter_app/core/model/book.dart';
import 'package:flutter_app/core/strings.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';

class SeeAllBooksPage extends StatefulWidget {
  final int category;

  SeeAllBooksPage({this.category = 0});

  _SeeAllBooksPageState createState() => _SeeAllBooksPageState();
}

class _SeeAllBooksPageState extends State<SeeAllBooksPage>
    with SingleTickerProviderStateMixin {
  ValueNotifier<int> _currentTab;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _currentTab = ValueNotifier<int>(widget.category);
    _tabController =
        TabController(length: 10, vsync: this, initialIndex: widget.category);
  }

  Widget categoryBuilder({@required int selectedIndex, String title}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        title,
        style: TextStyle(
            color: _currentTab.value == selectedIndex
                ? Colors.black
                : Colors.black26,
            fontWeight:
                _currentTab.value == selectedIndex ? FontWeight.w600 : null,
            fontSize: 16),
      ),
    );
  }

  Widget searchBar(TextStyle style) {
    return FocusedMenuHolder(
      menuItems: <FocusedMenuItem>[
        FocusedMenuItem(title: Text('Hello'), onPressed: () {}),
        FocusedMenuItem(title: Text('Hello'), onPressed: () {}),
      ],
      onPressed: () {},
      child: Container(
        width: double.maxFinite,
        height: 40,
        decoration: BoxDecoration(
            border: Border.all(color: kDarkBlue),
            color: Colors.white,
            borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 20),
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
    );
  }

  Widget bookBuilder({List<Book> books, int index}) {
    return FocusedMenuHolder(
      menuWidth: 170,
      menuItems: <FocusedMenuItem>[
        FocusedMenuItem(
            title: Text('Add to wish list'),
            onPressed: () {},
            trailingIcon: Icon(
              FontAwesomeIcons.bookmark,
              size: 16,
            )),
        FocusedMenuItem(
            title: Text('Add to read next'),
            onPressed: () {},
            trailingIcon: Icon(
              FontAwesomeIcons.book,
              size: 16,
            )),
      ],
      onPressed: () {
        print('pressed');
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Image.network(
          books[index].imgUrl,
          height: 140,
          width: 100,
        ),
      ),
    );
  }

  Widget tabBody({List<Book> books}) {
    return StaggeredGridView.countBuilder(
      padding: EdgeInsets.symmetric(horizontal: 10).copyWith(bottom: 20),
      itemCount: 21,
      itemBuilder: (BuildContext context, int index) {
        return bookBuilder(books: books, index: index);
      },
      staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      crossAxisCount: 3,
    );
  }

  Future<List<Book>> getBooks() async {
    List<Book> books = [];
    Response response =
        await get('$baseUrl?q=subject:fiction&maxResults=40&key=$apiKey');
    var data = jsonDecode(response.body);
    data['items'].forEach((data) {
      Book book = Book(
          title: data['volumeInfo']['title'],
          imgUrl: data['volumeInfo']['imageLinks']['thumbnail'],
          author: data['volumeInfo']['authors'][0]);
      books.add(book);
    });
    return books;
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyText1;
    return SafeArea(
      child: FutureBuilder<List<Book>>(
        future: getBooks(),
        builder: (BuildContext context, AsyncSnapshot<List<Book>> books) {
          if (books.connectionState == ConnectionState.done) {
            if (books.hasError) {
              return Text(books.error);
            } else {
              return ValueListenableBuilder(
                builder: (BuildContext context, value, Widget child) {
                  return Scaffold(
                    appBar: AppBar(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      leading: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 16,
                            color: Colors.black,
                          ),
                          onPressed: () => Navigator.pop(context)),
                    ),
                    body: Column(
                      children: <Widget>[
                        TabBar(
                          controller: _tabController,
                          onTap: (index) {
                            _currentTab.value = index;
                          },
                          isScrollable: true,
                          labelColor: kDarkBlue,
                          indicatorColor: kDarkBlue,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorWeight: 4,
                          tabs: [
                            categoryBuilder(selectedIndex: 0, title: 'Fiction'),
                            categoryBuilder(selectedIndex: 1, title: 'Poetry'),
                            categoryBuilder(selectedIndex: 2, title: 'Design'),
                            categoryBuilder(selectedIndex: 3, title: 'Cooking'),
                            categoryBuilder(selectedIndex: 4, title: 'Nature'),
                            categoryBuilder(
                                selectedIndex: 5, title: 'Philosophy'),
                            categoryBuilder(
                                selectedIndex: 6, title: 'Education'),
                            categoryBuilder(selectedIndex: 7, title: 'Comics'),
                            categoryBuilder(selectedIndex: 8, title: 'Health'),
                            categoryBuilder(
                                selectedIndex: 9, title: 'Business'),
                          ],
                        ),
                        Expanded(
                            child: Container(
                          margin: EdgeInsets.only(top: 30, left: 20, right: 20),
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    spreadRadius: 10,
                                    blurRadius: 20)
                              ]),
                          child: Column(
                            children: <Widget>[
                              searchBar(style),
                              Expanded(
                                child: TabBarView(
                                  controller: _tabController,
                                  physics: NeverScrollableScrollPhysics(),
                                  children: <Widget>[
                                    tabBody(books: books.data),
                                    tabBody(books: books.data),
                                    tabBody(books: books.data),
                                    tabBody(books: books.data),
                                    tabBody(books: books.data),
                                    tabBody(books: books.data),
                                    tabBody(books: books.data),
                                    tabBody(books: books.data),
                                    tabBody(books: books.data),
                                    tabBody(books: books.data),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ))
                      ],
                    ),
                  );
                },
                valueListenable: _currentTab,
              );
            }
          } else
            return Scaffold(
              body: Center(
                child: Text(
                  'loading..',
                  style: style.copyWith(
                      color: kDarkBlue,
                      fontWeight: FontWeight.w100,
                      fontSize: 20),
                ),
              ),
            );
        },
      ),
    );
  }
}
