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
  final PageController _pageController = PageController(initialPage: 0);

  List<Widget> _widgets = <Widget>[DiscoverPage(), SettingsPage()];

  void _onItemTapped(int index) {
    _pageNumberNotifier.value = index;
    _pageController.jumpToPage(index);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _pageNumberNotifier.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _onBackPressed() async {
    if (_pageController.page != 0) {
      _onItemTapped(0);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          floatingActionButton: FloatingActionButton(
            backgroundColor: kDarkBlue,
            onPressed: () {
              Navigator.pushNamed(context, Router.seeAllBooksPage);
            },
            child: Icon(FontAwesomeIcons.plus),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: PageView(
            controller: _pageController,
            children: _widgets,
            physics: NeverScrollableScrollPhysics(),
          ),
          bottomNavigationBar: ValueListenableBuilder(
            valueListenable: _pageNumberNotifier,
            builder: (BuildContext context, int pageNumber, Widget child) {
              return BottomNavigationBar(
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
              );
            },
          ),
        ),
      ),
    );
  }
}
