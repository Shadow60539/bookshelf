import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutter_app/features/home/presentation/pages/home_page.dart';
import 'package:flutter_app/features/login/presentation/pages/sign_up_page.dart';
import 'package:flutter_app/features/splash/presentation/pages/splash_page.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  SplashPage splashPage;
  SignUpPage loginPage;
  HomePage homePage;
}
