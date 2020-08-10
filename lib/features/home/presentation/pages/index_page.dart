import 'package:flutter/material.dart';
import 'package:flutter_app/core/colors.dart';
import 'package:flutter_app/features/home/presentation/pages/discover_page.dart';
import 'package:flutter_app/features/home/presentation/pages/settings_page.dart';
import 'package:flutter_app/routes/router.gr.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  ValueNotifier<int> _pageNumberNotifier = ValueNotifier<int>(0);
  List<Widget> _widgets = <Widget>[DiscoverPage(), SettingsPage()];

  void _onItemTapped(int index) {
    _pageNumberNotifier.value = index;
  }

  @override
  void dispose() {
    super.dispose();
    _pageNumberNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ValueListenableBuilder(
        builder: (BuildContext context, pageNumber, Widget child) {
          return Scaffold(
              floatingActionButtonAnimator:
                  FloatingActionButtonAnimator.scaling,
              floatingActionButton: FloatingActionButton(
                backgroundColor: kDarkBlue,
                onPressed: () {
                  Navigator.pushNamed(context, Router.seeAllBooksPage);
                },
                child: Icon(FontAwesomeIcons.plus),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              body: IndexedStack(
                index: _pageNumberNotifier.value,
                children: _widgets,
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: pageNumber,
                onTap: _onItemTapped,
                selectedItemColor: kDarkBlue,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(
                      FontAwesomeIcons.book,
                    ),
                    title: Text(
                      "Discover",
                      style: TextStyle(
                          //fontSize: 12,  default value
                          fontSize: 0),
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      FontAwesomeIcons.cog,
                      //size: 20,
                    ),
                    title: Text(
                      'Settings',
                      style: TextStyle(fontSize: 0
                          //fontSize: 12,
                          ),
                    ),
                  ),
                ],
              ));
        },
        valueListenable: _pageNumberNotifier,
      ),
    );
  }
}
