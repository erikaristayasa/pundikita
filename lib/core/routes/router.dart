import 'package:flutter/material.dart';
import 'package:pundi_kita/features/login/presentation/pages/login_page.dart';

import '../../features/campaign/presentation/pages/campaign_all_page.dart';
import '../../features/campaign/presentation/pages/campaign_detail_page.dart';
import '../presentation/pages/main_page.dart';
import '../presentation/pages/not_found_page.dart';
import '../presentation/pages/splash_screen.dart';
import 'path.dart' as path;

class Router {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case path.SPLASH_SCREEN:
        return pageRoute(page: const SplashScreen());
      case path.LOGIN:
        return pageRoute(page: const LoginPage());
      case path.MAIN:
        return pageRoute(page: const MainPage());
      case path.CAMPAIGN_ALL:
        return pageRoute(page: const CampaignAllPage());
      case path.CAMPAIGN_DETAIL:
        final args = settings.arguments as CampaignDetailPageRouteArguments;
        return pageRoute(page: CampaignDetailPage(id: args.id));
      default:
        return pageRoute(page: const NotFoundPage());
    }
  }

  static MaterialPageRoute<dynamic> pageRoute({required Widget page}) {
    return MaterialPageRoute(builder: (_) => page);
  }
}
