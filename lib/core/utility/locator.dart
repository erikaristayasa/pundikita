import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

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
  locator.registerLazySingleton<LoginBloc>(() => LoginBloc(doLogin: locator()));

  // use cases
  locator.registerLazySingleton<DoLogin>(() => DoLogin(locator()));

  // repositories
  locator.registerLazySingleton<LoginRepository>(() => LoginRepositoryImplementation(dataSource: locator()));

  // data sources
  locator.registerLazySingleton<LoginDataSource>(() => LoginDataSourceImplementation(dio: locator()));

  // core
  locator.registerLazySingleton<Dio>(() => DioClient().dio);
  // external
  locator.registerLazySingletonAsync<SharedPreferencesHelper>(
    () async => await SharedPreferencesHelper().init(),
  );
}
