import 'package:pundi_kita/core/utility/app_locale.dart';
import 'package:pundi_kita/features/register/data/datasources/register_data_source.dart';
import 'package:pundi_kita/features/register/domain/entities/register_request_body.dart';
import 'package:dartz/dartz.dart';
import 'package:pundi_kita/features/register/domain/repositories/register_repository.dart';

class RegisterRepositoryImplementation implements RegisterRepository {
  final RegisterDataSource dataSource;

  RegisterRepositoryImplementation({required this.dataSource});

  @override
  Future<Either<String, String>> register(RegisterRequestBody body) async {
    try {
      final result = await dataSource.register(body);
      if (result.status == 200) {
        return Right(result.data!);
      }
      return Left(result.data!);
    } catch (e) {
      return Left(AppLocale.loc.unexpectedServerError);
    }
  }
}
