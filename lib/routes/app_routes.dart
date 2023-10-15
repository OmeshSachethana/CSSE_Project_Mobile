import 'package:flutter/material.dart';

import '../views/auth_page.dart';

class AppRoutes {
  static const String authPage = '/';

  static Map<String, WidgetBuilder> routes = {
    authPage: (context) => AuthPage(),
  };
}
