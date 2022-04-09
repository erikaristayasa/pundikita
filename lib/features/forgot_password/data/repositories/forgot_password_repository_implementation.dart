import 'package:dartz/dartz.dart';

import '../../../../core/utility/app_locale.dart';
import '../../domain/repositories/forgot_password_repository.dart';
import '../datasources/forgot_password_data_source.dart';

class ForgotPasswordRepositoryImplementation implements ForgotPasswordRepository {
  final ForgotPasswordDataSource dataSource;

  ForgotPasswordRepositoryImplementation({required this.dataSource});

  @override
  Future<Either<String, String>> forgotPassword(String email) async {
    try {
      final result = await dataSource.forgotPassword(email);
      if (result.status == 200) {
        return Right(result.data!);
      } else {
        return Left(result.data!);
      }
    } catch (e) {
      return Left(AppLocale.loc.unexpectedServerError);
    }
  }
}
