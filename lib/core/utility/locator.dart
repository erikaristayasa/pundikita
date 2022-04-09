import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pundi_kita/core/presentation/blocs/text_controller/text_controller_bloc.dart';
import 'package:pundi_kita/features/forgot_password/data/datasources/forgot_password_data_source.dart';
import 'package:pundi_kita/features/forgot_password/data/repositories/forgot_password_repository_implementation.dart';
import 'package:pundi_kita/features/forgot_password/domain/repositories/forgot_password_repository.dart';
import 'package:pundi_kita/features/forgot_password/domain/usecases/forgot_password.dart';
import 'package:pundi_kita/features/forgot_password/presentation/bloc/forgot_password_bloc.dart';
import 'package:pundi_kita/features/register/data/datasources/register_data_source.dart';
import 'package:pundi_kita/features/register/data/repositories/register_repository_implementation.dart';
import 'package:pundi_kita/features/register/domain/repositories/register_repository.dart';
import 'package:pundi_kita/features/register/domain/usecases/do_register.dart';
import 'package:pundi_kita/features/register/presentation/bloc/register_bloc.dart';

import '../../features/login/data/datasources/login_data_source.dart';
import '../../features/login/data/repositories/login_repository_implementation.dart';
import '../../features/login/domain/repositories/login_repository.dart';
import '../../features/login/domain/usecases/do_login.dart';
import '../../features/login/presentation/bloc/login_bloc.dart';
import '../network/dio_client.dart';
import 'shared_preferences_helper.dart';

final locator = GetIt.instance;

Future<void> locatorSetup() async {
  // bloc
  locator.registerFactory<TextControllerBloc>(() => TextControllerBloc());
  locator.registerFactory<LoginBloc>(() => LoginBloc(doLogin: locator()));
  locator.registerFactory<RegisterBloc>(() => RegisterBloc(register: locator()));
  locator.registerFactory<ForgotPasswordBloc>(() => ForgotPasswordBloc(forgotPassword: locator()));

  // use cases
  locator.registerLazySingleton<DoLogin>(() => DoLogin(locator()));
  locator.registerLazySingleton<Register>(() => Register(locator()));
  locator.registerLazySingleton<ForgotPassword>(() => ForgotPassword(locator()));

  // repositories
  locator.registerLazySingleton<LoginRepository>(() => LoginRepositoryImplementation(dataSource: locator()));
  locator.registerLazySingleton<RegisterRepository>(() => RegisterRepositoryImplementation(dataSource: locator()));
  locator.registerLazySingleton<ForgotPasswordRepository>(() => ForgotPasswordRepositoryImplementation(dataSource: locator()));

  // data sources
  locator.registerLazySingleton<LoginDataSource>(() => LoginDataSourceImplementation(dio: locator()));
  locator.registerLazySingleton<RegisterDataSource>(() => RegisterDataSourceImplementation(dio: locator()));
  locator.registerLazySingleton<ForgotPasswordDataSource>(() => ForgotPasswordDataSourceImplementation(dio: locator()));

  // core
  locator.registerLazySingleton<Dio>(() => DioClient().dio);
  // external
  locator.registerLazySingletonAsync<SharedPreferencesHelper>(
    () async => await SharedPreferencesHelper().init(),
  );
}
