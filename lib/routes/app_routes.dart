import 'package:constro/views/home_view.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String homePageScreen = '/';

  static Map<String, WidgetBuilder> routes = {
    homePageScreen: (context) => HomeView(),
  };
}
