import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutter_app/features/home/pages/book_page.dart';
import 'package:flutter_app/features/home/pages/discover_page.dart';
import 'package:flutter_app/features/home/pages/index_page.dart';
import 'package:flutter_app/features/home/pages/root_page.dart';
import 'package:flutter_app/features/home/pages/see_all_books_page.dart';
import 'package:flutter_app/features/home/pages/settings_page.dart';
import 'package:flutter_app/features/login/pages/sign_up_page.dart';
import 'package:flutter_app/features/splash/pages/splash_page.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  SplashPage splashPage;
  SignUpPage signUpPage;
  RootPage rootPage;
  IndexPage indexPage;
  DiscoverPage discoverPage;
  SettingsPage settingsPage;
  SeeAllBooksPage seeAllBooksPage;
  BookPage bookPage;
}
