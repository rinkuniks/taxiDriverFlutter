import 'package:flutter/material.dart';
import 'package:rovertaxi/view/bookingDetailView/bookingDetailView.dart';
import 'package:rovertaxi/view/notificationView/notificationView.dart';
import 'package:rovertaxi/view/preAuth/splashView.dart';

import '../../view/home/homeView.dart';
import 'routes_name.dart';

class MyRoute {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    switch (settings.name) {
      //PreAuth
      case RoutesName.splshView:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashView());

      case RoutesName.homeView:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeView());

      case RoutesName.notificationView:
        return MaterialPageRoute(
            builder: (BuildContext context) => const NotificationView());

      case RoutesName.bookingDetailView:
        return MaterialPageRoute(
            builder: (BuildContext context) => const BookDetailView());

      //Default Route

      default:
        return MaterialPageRoute(
            builder: (BuildContext context) => const Scaffold(
                  body: Center(
                    child: Text('No Route found...'),
                  ),
                ));
    }
  }
}
