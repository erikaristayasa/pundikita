import 'package:dartz/dartz.dart';

import '../../../../core/utility/app_locale.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/login_data_source.dart';

class LoginRepositoryImplementation implements LoginRepository {
  final LoginDataSource dataSource;

  LoginRepositoryImplementation({required this.dataSource});

  @override
  Future<Either<String, String>> login({String? email, String? password}) async {
    try {
      final result = await dataSource.login(email: email, password: password);
      if (result.status == 200) {
        return Right(result.data!);
      }
      return Left(result.data!);
    } catch (e) {
      return Left(AppLocale.loc.unexpectedServerError);
    }
  }

  @override
  Future<Either<String, String>> loginByGoogle({String? email, String? name, String? googleUid, String? phone}) async {
    try {
      final result = await dataSource.loginByGoogle(email: email, name: name, googleUid: googleUid, phone: phone);
      if (result.status == 200) {
        return Right(result.data!);
      }
      return Left(result.data!);
    } catch (e) {
      return Left(AppLocale.loc.unexpectedServerError);
    }
  }
}
