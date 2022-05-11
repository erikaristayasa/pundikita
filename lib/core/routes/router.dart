import 'package:flutter/material.dart';

import '../../features/campaign/presentation/pages/campaign_all_page.dart';
import '../../features/campaign/presentation/pages/campaign_category_list_page.dart';
import '../../features/campaign/presentation/pages/campaign_create_page.dart';
import '../../features/campaign/presentation/pages/campaign_detail_page.dart';
import '../../features/campaign/presentation/pages/campaign_search_page.dart';
import '../../features/campaign/presentation/pages/campaign_sub_category_list_page.dart';
import '../../features/campaign/presentation/pages/campaign_type_list_page.dart';
import '../../features/campaign/presentation/pages/fund_usage_detail_page.dart';
import '../../features/donate/presentation/pages/donate_nominal_list_page.dart';
import '../../features/donate/presentation/pages/donate_request_inquiry_page.dart';
import '../../features/donate/presentation/pages/donate_request_inquiry_result_page.dart';
import '../../features/faq/presentation/pages/faq_page.dart';
import '../../features/forgot_password/presentation/pages/forgot_password_page.dart';
import '../../features/login/presentation/pages/login_page.dart';
import '../../features/profile/presentation/pages/profile_update_page.dart';
import '../../features/profile/presentation/pages/setting_detail_page.dart';
import '../../features/register/presentation/pages/register_page.dart';
import '../../features/wallet/presentation/pages/wallet_topup_history_page.dart';
import '../../features/wallet/presentation/pages/wallet_topup_page.dart';
import '../../features/wallet/presentation/pages/wallet_topup_result_page.dart';
import '../../features/zakat_calculate/presentation/pages/zakat_calculate_page.dart';
import '../presentation/pages/main_page.dart';
import '../presentation/pages/not_found_page.dart';
import '../presentation/pages/splash_screen.dart';
import '../presentation/pages/work_in_progress_page.dart';
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
      case path.PROFILE_UPDATE:
        return pageRoute(page: const ProfileUpdatePage());
      case path.FAQ:
        return pageRoute(page: const FaqPage());
      case path.SETTING_DETAIL:
        final args = settings.arguments as SettingDetailPageRouteArguments;
        return pageRoute(
          page: SettingDetailPage(title: args.title, content: args.content),
        );
      case path.CAMPAIGN_ALL:
        final args = settings.arguments as CampaignAllPageRouteArguments;
        return pageRoute(
          page: CampaignAllPage(service: args.service),
        );
      case path.CAMPAIGN_DETAIL:
        final args = settings.arguments as CampaignDetailPageRouteArguments;
        return pageRoute(
          page: CampaignDetailPage(id: args.id, service: args.service),
        );
      case path.FUND_USAGE_DETAIL:
        final args = settings.arguments as FundUsageDetailUsageRouteArguments;
        return pageRoute(
          page: FundUsageDetailPage(usageDetail: args.usageDetail),
        );
      case path.CAMPAIGN_TYPE:
        return pageRoute(page: const CampaignTypeListPage());
      case path.CAMPAIGN_CATEGORY:
        final args = settings.arguments as CampaignCategoryListPageRouteArguments;
        return pageRoute(
          page: CampaignCategoryListPage(type: args.type),
        );
      case path.CAMPAIGN_SUB_CATEGORY:
        final args = settings.arguments as CampaignSubCategoryListPageRouteArguments;
        return pageRoute(
          page: CampaignSubCategoryListPage(
            type: args.type,
            category: args.category,
          ),
        );
      case path.CAMPAIGN_CREATE:
        final args = settings.arguments as CampaignCreatePageRouteArguments;
        return pageRoute(
          page: CampaignCreatePage(
            type: args.type,
            typeId: args.typeId,
            categoryId: args.categoryId,
            subCategoryId: args.subCategoryId,
          ),
        );
      case path.SEARCH:
        return pageRoute(page: const CampaignSearchPage());
      case path.ZAKAT_CALCULATE:
        return pageRoute(page: const ZakatCalculatePage());
      case path.DONATION_NOMINAL_LIST:
        final args = settings.arguments as DonateNominalListPageRouteArguments;
        return pageRoute(
          page: DonateNominalListPage(campaign: args.campaign),
        );
      case path.DONATION_REQUEST_INQURY:
        final args = settings.arguments as DonateRequestInquiryPageRouteArguments;
        return pageRoute(
          page: DonateRequestInquiryPage(
            nominal: args.nominal,
            campaign: args.campaign,
          ),
        );
      case path.DONATION_REQUEST_INQURY_RESULT:
        final args = settings.arguments as DonateRequestInquiryResultPageRouteArguments;
        return pageRoute(page: DonateRequestInquiryResultPage(result: args.result));
      case path.WALLET_TOP_UP:
        return pageRoute(page: const WalletTopUpPage());
      case path.WALLET_TOP_UP_HISTORY:
        return pageRoute(page: const WalletTopUpHistoryPage());
      case path.WALLET_TOP_UP_RESULT:
        final args = settings.arguments as WalletTopUpResultPageRouteArguments;
        return pageRoute(page: WalletTopUpResultPage(result: args.result));
      case path.WORK_IN_PROGRESS:
        return pageRoute(page: const WorkInProgressPage());
      default:
        return pageRoute(page: const NotFoundPage());
    }
  }

  static MaterialPageRoute<dynamic> pageRoute({required Widget page}) {
    return MaterialPageRoute(builder: (_) => page);
  }
}
