import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/campaign/presentation/bloc/detail/campaign_detail_bloc.dart';
import '../../features/campaign/presentation/bloc/list/campaign_list_bloc.dart';
import '../../features/forgot_password/data/datasources/forgot_password_data_source.dart';
import '../../features/forgot_password/data/repositories/forgot_password_repository_implementation.dart';
import '../../features/forgot_password/domain/repositories/forgot_password_repository.dart';
import '../../features/forgot_password/domain/usecases/forgot_password.dart';
import '../../features/forgot_password/presentation/bloc/forgot_password_bloc.dart';
import '../../features/login/data/datasources/login_data_source.dart';
import '../../features/login/data/repositories/login_repository_implementation.dart';
import '../../features/login/domain/repositories/login_repository.dart';
import '../../features/login/domain/usecases/do_login.dart';
import '../../features/login/presentation/bloc/login_bloc.dart';
import '../../features/register/data/datasources/register_data_source.dart';
import '../../features/register/data/repositories/register_repository_implementation.dart';
import '../../features/register/domain/repositories/register_repository.dart';
import '../../features/register/domain/usecases/do_register.dart';
import '../../features/register/presentation/bloc/register_bloc.dart';
import '../data/datasources/campaign_data_source.dart';
import '../data/repositories/campaign_repository_implementation.dart';
import '../domain/repositories/campaign_repository.dart';
import '../domain/usecases/get_all_campaign_list.dart';
import '../domain/usecases/get_campaign_detail.dart';
import '../domain/usecases/get_user_campaign_list.dart';
import '../network/dio_client.dart';
import '../presentation/blocs/text_controller/text_controller_bloc.dart';
import 'shared_preferences_helper.dart';

final locator = GetIt.instance;

Future<void> locatorSetup() async {
  // bloc
  locator.registerFactory<TextControllerBloc>(() => TextControllerBloc());
  locator.registerFactory<LoginBloc>(() => LoginBloc(doLogin: locator()));
  locator.registerFactory<RegisterBloc>(() => RegisterBloc(register: locator()));
  locator.registerFactory<ForgotPasswordBloc>(() => ForgotPasswordBloc(forgotPassword: locator()));
  locator.registerFactory<CampaignDetailBloc>(() => CampaignDetailBloc(getCampaignDetail: locator()));
  locator.registerFactory<CampaignListBloc>(() => CampaignListBloc(
        getAllCampaignList: locator(),
        getUserCampaignList: locator(),
      ));

  // use cases
  locator.registerLazySingleton<DoLogin>(() => DoLogin(locator()));
  locator.registerLazySingleton<Register>(() => Register(locator()));
  locator.registerLazySingleton<ForgotPassword>(() => ForgotPassword(locator()));
  locator.registerLazySingleton<GetAllCampaignList>(() => GetAllCampaignList(locator()));
  locator.registerLazySingleton<GetUserCampaignList>(() => GetUserCampaignList(locator()));
  locator.registerLazySingleton<GetCampaignDetail>(() => GetCampaignDetail(locator()));

  // repositories
  locator.registerLazySingleton<LoginRepository>(() => LoginRepositoryImplementation(dataSource: locator()));
  locator.registerLazySingleton<RegisterRepository>(() => RegisterRepositoryImplementation(dataSource: locator()));
  locator.registerLazySingleton<ForgotPasswordRepository>(() => ForgotPasswordRepositoryImplementation(dataSource: locator()));
  locator.registerLazySingleton<CampaignRepository>(() => CampaignRepositoryImplementation(dataSource: locator()));

  // data sources
  locator.registerLazySingleton<LoginDataSource>(() => LoginDataSourceImplementation(dio: locator()));
  locator.registerLazySingleton<RegisterDataSource>(() => RegisterDataSourceImplementation(dio: locator()));
  locator.registerLazySingleton<ForgotPasswordDataSource>(() => ForgotPasswordDataSourceImplementation(dio: locator()));
  locator.registerLazySingleton<CampaignDataSource>(() => CampaignDataSourceImplementation(dio: locator()));

  // core
  locator.registerLazySingleton<Dio>(() => DioClient().dio);
  // external
  locator.registerLazySingletonAsync<SharedPreferencesHelper>(
    () async => await SharedPreferencesHelper().init(),
  );
}
