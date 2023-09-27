import 'package:flutter/material.dart';
import 'package:newsapp/module/home/home_details_screen.dart';
import 'package:newsapp/module/home/home_screen.dart';
import 'package:newsapp/module/home/model/artical_model.dart';
import 'package:newsapp/module/splash/splash_screen.dart';

class RouteNames {
  static const String splashScreen = '/';
  static const String homePage = '/homePage';
  static const String homeDetailsPage = '/homeDetailsPage';


  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SplashScreen());

      case RouteNames.homePage:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const HomeScreen());

    case RouteNames.homeDetailsPage:
      final event = settings.arguments as Article;
      return MaterialPageRoute(
          settings: settings, builder: (_) => HomeDetailsScreen(
        article: event,
      ));

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
