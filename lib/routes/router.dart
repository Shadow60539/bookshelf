import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutter_app/features/home/presentation/pages/discover_page.dart';
import 'package:flutter_app/features/home/presentation/pages/index_page.dart';
import 'package:flutter_app/features/home/presentation/pages/see_all_books_page.dart';
import 'package:flutter_app/features/home/presentation/pages/settings_page.dart';
import 'package:flutter_app/features/login/presentation/pages/sign_up_page.dart';
import 'package:flutter_app/features/splash/presentation/pages/splash_page.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  SplashPage splashPage;
  SignUpPage signUpPage;
  IndexPage indexPage;
  DiscoverPage discoverPage;
  SettingsPage settingsPage;
  SeeAllBooksPage seeAllBooksPage;
}
