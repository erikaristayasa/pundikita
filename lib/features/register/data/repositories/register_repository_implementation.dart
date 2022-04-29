import 'package:dartz/dartz.dart';

import '../../../../core/utility/app_locale.dart';
import '../../domain/entities/register_request_body.dart';
import '../../domain/repositories/register_repository.dart';
import '../datasources/register_data_source.dart';

class RegisterRepositoryImplementation implements RegisterRepository {
  final RegisterDataSource dataSource;

  RegisterRepositoryImplementation({required this.dataSource});

  @override
  Future<Either<String, String>> register(RegisterRequestBody body, {required Map<String, dynamic> additionalBody}) async {
    try {
      final result = await dataSource.register(body, additionalBody: additionalBody);
      if (result.status == 200) {
        return Right(result.data!);
      }
      return Left(result.data!);
    } catch (e) {
      return Left(AppLocale.loc.unexpectedServerError);
    }
  }
}
