// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_app/features/splash/pages/splash_page.dart';
import 'package:flutter_app/features/login/pages/sign_up_page.dart';
import 'package:flutter_app/features/home/pages/root_page.dart';
import 'package:flutter_app/features/home/pages/index_page.dart';
import 'package:flutter_app/features/home/pages/discover_page.dart';
import 'package:flutter_app/features/home/pages/settings_page.dart';
import 'package:flutter_app/features/home/pages/see_all_books_page.dart';
import 'package:flutter_app/features/home/pages/book_page.dart';
import 'package:flutter_app/core/model/book.dart';

class Router {
  static const splashPage = '/';
  static const signUpPage = '/sign-up-page';
  static const rootPage = '/root-page';
  static const indexPage = '/index-page';
  static const discoverPage = '/discover-page';
  static const settingsPage = '/settings-page';
  static const seeAllBooksPage = '/see-all-books-page';
  static const bookPage = '/book-page';
  static final navigator = ExtendedNavigator();
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Router.splashPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => SplashPage(),
          settings: settings,
        );
      case Router.signUpPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => SignUpPage(),
          settings: settings,
        );
      case Router.rootPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => RootPage(),
          settings: settings,
        );
      case Router.indexPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => IndexPage(),
          settings: settings,
        );
      case Router.discoverPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => DiscoverPage(),
          settings: settings,
        );
      case Router.settingsPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => SettingsPage(),
          settings: settings,
        );
      case Router.seeAllBooksPage:
        if (hasInvalidArgs<int>(args)) {
          return misTypedArgsRoute<int>(args);
        }
        final typedArgs = args as int ?? 0;
        return MaterialPageRoute<dynamic>(
          builder: (_) => SeeAllBooksPage(category: typedArgs),
          settings: settings,
        );
      case Router.bookPage:
        if (hasInvalidArgs<BookPageArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<BookPageArguments>(args);
        }
        final typedArgs = args as BookPageArguments;
        return MaterialPageRoute<dynamic>(
          builder: (_) => BookPage(
              book: typedArgs.book, fromLibrary: typedArgs.fromLibrary),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

//**************************************************************************
// Arguments holder classes
//***************************************************************************

//BookPage arguments holder class
class BookPageArguments {
  final Book book;
  final bool fromLibrary;
  BookPageArguments({@required this.book, this.fromLibrary = false});
}
