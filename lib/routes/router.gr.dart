// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_app/features/splash/presentation/pages/splash_page.dart';
import 'package:flutter_app/features/login/presentation/pages/sign_up_page.dart';
import 'package:flutter_app/features/home/presentation/pages/index_page.dart';
import 'package:flutter_app/features/home/presentation/pages/discover_page.dart';
import 'package:flutter_app/features/home/presentation/pages/settings_page.dart';
import 'package:flutter_app/features/home/presentation/pages/see_all_books_page.dart';

class Router {
  static const splashPage = '/';
  static const signUpPage = '/sign-up-page';
  static const indexPage = '/index-page';
  static const discoverPage = '/discover-page';
  static const settingsPage = '/settings-page';
  static const seeAllBooksPage = '/see-all-books-page';
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
      default:
        return unknownRoutePage(settings.name);
    }
  }
}
