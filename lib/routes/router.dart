import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutter_app/features/login/presentation/pages/login_page.dart';
import 'package:flutter_app/features/splash/presentation/pages/splash_page.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  SplashPage splashPage;
  LoginPage loginPage;
}
