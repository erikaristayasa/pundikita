import 'package:dartz/dartz.dart';
import 'package:pundi_kita/core/utility/helper.dart';

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
      return const Left('Unexpected server error');
    }
  }
}
