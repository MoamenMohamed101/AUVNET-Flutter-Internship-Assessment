import 'package:flutter/material.dart';
import 'package:nawel/presentation/login/view/login_view.dart';
import 'package:nawel/presentation/main/main_view.dart';
import 'package:nawel/presentation/onBoarding/view/onBoarding_view.dart';
import 'package:nawel/presentation/register/view/register_view.dart';
import 'package:nawel/presentation/resources/strings_manager.dart';
import 'package:nawel/presentation/splash/splash_view.dart';

class Routes {
  static const String splashRoute = "/";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String mainRoute = "/main";
  static const String onBoardingRoute = "/onBoardingRoute";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(
          builder: (BuildContext context) => const SplashView(),
        );
      case Routes.onBoardingRoute:
        return MaterialPageRoute(
          builder: (BuildContext context) => OnboardingView(),
        );
      case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (BuildContext context) => LoginView(),
        );
      case Routes.registerRoute:
        return MaterialPageRoute(
          builder: (BuildContext context) => const RegisterView(),
        );
      case Routes.mainRoute:
        return MaterialPageRoute(
          builder: (BuildContext context) => MainView(),
        );
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(AppStrings.noRouteFound)),
        body: Center(child: Text(AppStrings.noRouteFound)),
      ),
    );
  }
}
