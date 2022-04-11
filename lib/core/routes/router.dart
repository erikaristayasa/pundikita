import 'package:flutter/material.dart';

import '../../features/campaign/presentation/pages/campaign_all_page.dart';
import '../../features/campaign/presentation/pages/campaign_detail_page.dart';
import '../../features/forgot_password/presentation/pages/forgot_password_page.dart';
import '../../features/login/presentation/pages/login_page.dart';
import '../../features/register/presentation/pages/register_page.dart';
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
      case path.REGISTER:
        return pageRoute(page: const RegisterPage());
      case path.FORGOT_PASSWORD:
        return pageRoute(page: const ForgotPasswordPage());
      case path.MAIN:
        final args = settings.arguments as MainPageRouteArguments?;
        return pageRoute(
          page: MainPage(fromLogin: args?.fromLogin ?? false),
        );
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
