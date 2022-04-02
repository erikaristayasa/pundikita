import 'package:flutter/material.dart';

import '../presentation/pages/main_page.dart';
import '../presentation/pages/not_found_page.dart';
import 'path.dart' as path;

class Router {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case path.MAIN:
        return pageRoute(page: const MainPage());
      default:
        return pageRoute(page: const NotFoundPage());
    }
  }

  static MaterialPageRoute<dynamic> pageRoute({required Widget page}) {
    return MaterialPageRoute(builder: (_) => page);
  }
}
