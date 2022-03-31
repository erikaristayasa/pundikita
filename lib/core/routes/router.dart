import 'package:flutter/material.dart';

import '../presentation/pages/not_found_page.dart';

class Router {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      default:
        return pageRoute(page: const NotFoundPage());
    }
  }

  static MaterialPageRoute<dynamic> pageRoute({required Widget page}) {
    return MaterialPageRoute(builder: (_) => page);
  }
}
