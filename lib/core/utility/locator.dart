import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/campaign/presentation/bloc/category/campaign_category_bloc.dart';
import '../../features/campaign/presentation/bloc/category_filter/category_filter_bloc.dart';
import '../../features/campaign/presentation/bloc/detail/campaign_detail_bloc.dart';
import '../../features/campaign/presentation/bloc/list/campaign_list_bloc.dart';
import '../../features/campaign/presentation/bloc/type/campaign_type_bloc.dart';
import '../../features/donate/presentation/bloc/donation_list_bloc.dart';
import '../../features/donate/presentation/bloc/request_inquiry_bloc.dart';
import '../../features/faq/data/datasources/faq_data_source.dart';
import '../../features/faq/data/repositories/faq_repository_implementaion.dart';
import '../../features/faq/domain/repositories/faq_repository.dart';
import '../../features/faq/domain/usecases/get_faq_list.dart';
import '../../features/faq/presentation/bloc/faq_bloc.dart';
import '../../features/forgot_password/data/datasources/forgot_password_data_source.dart';
import '../../features/forgot_password/data/repositories/forgot_password_repository_implementation.dart';
import '../../features/forgot_password/domain/repositories/forgot_password_repository.dart';
import '../../features/forgot_password/domain/usecases/forgot_password.dart';
import '../../features/forgot_password/presentation/bloc/forgot_password_bloc.dart';
import '../../features/login/data/datasources/login_data_source.dart';
import '../../features/login/data/repositories/login_repository_implementation.dart';
import '../../features/login/domain/repositories/login_repository.dart';
import '../../features/login/domain/usecases/do_login.dart';
import '../../features/login/domain/usecases/do_login_by_google.dart';
import '../../features/login/presentation/bloc/login_bloc.dart';
import '../../features/profile/data/datasources/profile_data_source.dart';
import '../../features/profile/data/repositories/profile_repository_implementation.dart';
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../../features/profile/domain/usecases/get_profile.dart';
import '../../features/profile/domain/usecases/update_profile.dart';
import '../../features/profile/domain/usecases/verify_account.dart';
import '../../features/profile/presentation/bloc/profile_bloc.dart';
import '../../features/profile/presentation/bloc/setting_bloc.dart';
import '../../features/register/data/datasources/register_data_source.dart';
import '../../features/register/data/repositories/register_repository_implementation.dart';
import '../../features/register/domain/repositories/register_repository.dart';
import '../../features/register/domain/usecases/do_register.dart';
import '../../features/register/presentation/bloc/register_bloc.dart';
import '../data/datasources/banner_data_source.dart';
import '../data/datasources/campaign_data_source.dart';
import '../data/datasources/donate_data_source.dart';
import '../data/datasources/setting_data_source.dart';
import '../data/repositories/banner_repository_implementation.dart';
import '../data/repositories/campaign_repository_implementation.dart';
import '../data/repositories/donate_repository_implementation.dart';
import '../data/repositories/setting_repository_implementation.dart';
import '../domain/repositories/banner_repository.dart';
import '../domain/repositories/campaign_repository.dart';
import '../domain/repositories/donate_repository.dart';
import '../domain/repositories/setting_repository.dart';
import '../domain/usecases/get_all_campaign_list.dart';
import '../domain/usecases/get_banners.dart';
import '../domain/usecases/get_campaign_categories.dart';
import '../domain/usecases/get_campaign_detail.dart';
import '../domain/usecases/get_campaign_types.dart';
import '../domain/usecases/get_donation_list.dart';
import '../domain/usecases/get_setting.dart';
import '../domain/usecases/request_inquiry.dart';
import '../network/dio_client.dart';
import '../network/network_info.dart';
import '../presentation/blocs/banner/banner_bloc.dart';
import '../presentation/blocs/text_controller/text_controller_bloc.dart';
import 'shared_preferences_helper.dart';

final locator = GetIt.instance;

Future<void> locatorSetup() async {
  // bloc
  locator.registerFactory<TextControllerBloc>(() => TextControllerBloc());
  locator.registerFactory<LoginBloc>(() => LoginBloc(doLogin: locator(), doLoginByGoogle: locator()));
  locator.registerFactory<RegisterBloc>(() => RegisterBloc(register: locator()));
  locator.registerFactory<ForgotPasswordBloc>(() => ForgotPasswordBloc(forgotPassword: locator()));
  locator.registerFactory<CampaignDetailBloc>(() => CampaignDetailBloc(getCampaignDetail: locator()));
  locator.registerFactory<CampaignListBloc>(() => CampaignListBloc(getAllCampaignList: locator()));
  locator.registerFactory<CampaignTypeBloc>(() => CampaignTypeBloc(getCampaignTypes: locator()));
  locator.registerFactory<CampaignCategoryBloc>(() => CampaignCategoryBloc(getCampaignCategories: locator()));
  locator.registerFactory<CategoryFilterBloc>(() => CategoryFilterBloc(getCampaignCategories: locator()));
  locator.registerFactory<RequestInquiryBloc>(() => RequestInquiryBloc(requestInquiry: locator()));
  locator.registerFactory<DonationListBloc>(() => DonationListBloc(getDonationList: locator()));
  locator.registerFactory<BannerBloc>(() => BannerBloc(getBanners: locator()));
  locator.registerFactory<ProfileBloc>(() => ProfileBloc(getProfile: locator(), updateProfile: locator()));
  locator.registerFactory<SettingBloc>(() => SettingBloc(getSetting: locator()));
  locator.registerFactory<FaqBloc>(() => FaqBloc(getFaqList: locator()));

  // use cases
  locator.registerLazySingleton<DoLogin>(() => DoLogin(locator()));
  locator.registerLazySingleton<DoLoginByGoogle>(() => DoLoginByGoogle(locator()));
  locator.registerLazySingleton<Register>(() => Register(locator()));
  locator.registerLazySingleton<ForgotPassword>(() => ForgotPassword(locator()));
  locator.registerLazySingleton<GetAllCampaignList>(() => GetAllCampaignList(locator()));
  locator.registerLazySingleton<GetCampaignDetail>(() => GetCampaignDetail(locator()));
  locator.registerLazySingleton<GetCampaignCategories>(() => GetCampaignCategories(locator()));
  locator.registerLazySingleton<GetCampaignTypes>(() => GetCampaignTypes(locator()));
  locator.registerLazySingleton<RequestInquiry>(() => RequestInquiry(locator()));
  locator.registerLazySingleton<GetDonationList>(() => GetDonationList(locator()));
  locator.registerLazySingleton<GetBanners>(() => GetBanners(locator()));
  locator.registerLazySingleton<GetProfile>(() => GetProfile(locator()));
  locator.registerLazySingleton<UpdateProfile>(() => UpdateProfile(locator()));
  locator.registerLazySingleton<VerifyAccount>(() => VerifyAccount(locator()));
  locator.registerLazySingleton<GetSetting>(() => GetSetting(locator()));
  locator.registerLazySingleton<GetFaqList>(() => GetFaqList(locator()));

  // repositories
  locator.registerLazySingleton<LoginRepository>(() => LoginRepositoryImplementation(dataSource: locator()));
  locator.registerLazySingleton<RegisterRepository>(() => RegisterRepositoryImplementation(dataSource: locator()));
  locator.registerLazySingleton<ForgotPasswordRepository>(() => ForgotPasswordRepositoryImplementation(dataSource: locator()));
  locator.registerLazySingleton<CampaignRepository>(() => CampaignRepositoryImplementation(dataSource: locator()));
  locator.registerLazySingleton<DonateRepository>(() => DonateRepositoryImplementaion(dataSource: locator(), networkInfo: locator()));
  locator.registerLazySingleton<BannerRepository>(() => BannerRepositoryImplementation(dataSource: locator(), networkInfo: locator()));
  locator.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImplementation(dataSource: locator(), networkInfo: locator()));
  locator.registerLazySingleton<SettingRepository>(() => SettingRepositoryImplementation(dataSource: locator(), networkInfo: locator()));
  locator.registerLazySingleton<FaqRepository>(() => FaqRepositoryImplementation(dataSource: locator(), networkInfo: locator()));

  // data sources
  locator.registerLazySingleton<LoginDataSource>(() => LoginDataSourceImplementation(dio: locator()));
  locator.registerLazySingleton<RegisterDataSource>(() => RegisterDataSourceImplementation(dio: locator()));
  locator.registerLazySingleton<ForgotPasswordDataSource>(() => ForgotPasswordDataSourceImplementation(dio: locator()));
  locator.registerLazySingleton<CampaignDataSource>(() => CampaignDataSourceImplementation(dio: locator()));
  locator.registerLazySingleton<DonateDataSource>(() => DonateDateSourceImplementation(dio: locator()));
  locator.registerLazySingleton<BannerDataSource>(() => BannerDataSourceImplementation(dio: locator()));
  locator.registerLazySingleton<ProfileDataSource>(() => ProfileDataSourceImplementation(dio: locator()));
  locator.registerLazySingleton<SettingDataSource>(() => SettingDataSourceImplementation(dio: locator()));
  locator.registerLazySingleton<FaqDataSource>(() => FaqDataSourceImplementation(dio: locator()));

  // core
  locator.registerLazySingleton<Dio>(() => DioClient().dio);
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImplementaion(connectivity: Connectivity()));

  // external
  locator.registerLazySingletonAsync<SharedPreferencesHelper>(
    () async => await SharedPreferencesHelper().init(),
  );
}
